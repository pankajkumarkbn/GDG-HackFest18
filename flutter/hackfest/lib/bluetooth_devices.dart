import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hackfest/home.dart';
import 'package:hackfest/line_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: Make list trailing with connect and disconnect button
FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

class BluetoothDevices extends StatefulWidget {
  final String appName;

  const BluetoothDevices({Key key, this.appName}) : super(key: key);

  @override
  _BluetoothDevicesState createState() => _BluetoothDevicesState();
}

class _BluetoothDevicesState extends State<BluetoothDevices> {
  List<LinePoint> pointList = [];
  BluetoothDevice _device;
  List<BluetoothDevice> _devices = [];
//  List<LinePoint> pointList = [];

  bool _connected = false;
  bool _pressed = false;


  DateTime _date;


  _BluetoothDevicesState();

  Future<void> initPlatformState() async {




    Map<String, dynamic> _dataMap;


    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error occures");
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case FlutterBluetoothSerial.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
          });
          break;
        case FlutterBluetoothSerial.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;
        default:
          // TODO
          print(state);
          break;
      }
    });

    bluetooth.onRead().listen((msg) {
      _date = DateTime.now();
      final DocumentReference _documentReference =
      Firestore.instance.document("data/${_date}");
      setState(() {

        if(msg != " ") {
          print('Read: $msg');
          List<String> message = msg.split(" ");

          _dataMap = <String, dynamic>{
            'temp': message[0],
            "vib": message[1] == null ? '0' : message[1]
//            'vib': message[1],
          };

          _documentReference.setData(_dataMap).whenComplete(() {
            print("Added Successfully to user");
          }).catchError((e) => print('Error is => $e'));


//          pointList
//              .add(LinePoint(pointList.length, int.parse(message[0]), Colors.green));
          print("POINT LIST" + pointList.toString());
        } else {
          print("NO DATA");
        }


      });
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });
  }

  Widget _getDevicesList() {
    if (_devices.isEmpty) {
      return Center(
        child: Text("No devices found"),
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_devices[index].name),
          trailing: FlatButton(
            onPressed: () {
              if (_pressed) {
                print("Error");
              } else if (_connected) {
                _disconnect();
              } else {
                _connect(index);
              }
            },
            child: Text(_connected ? 'Disconnect' : 'Connect'),
          ),
        );
      },
      itemCount: _devices.length,
    );
  }

  void _connect(int index) {
    _device = _devices[index];
    print(_device);
    if (_device == null) {
      print('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _pressed = false);
          });
          setState(() => _pressed = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _pressed = true);
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Devices"),
        centerTitle: true,
      ),
      body: _getDevicesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Home(appName: widget.appName)));


        },
        child: Icon(Icons.trending_up),
        tooltip: "Graph ",
      ),
    );
  }
}
