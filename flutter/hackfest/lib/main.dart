import 'package:flutter/material.dart';
import 'package:hackfest/bluetooth_devices.dart';
import 'home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appName = "HackFest";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BluetoothDevices(appName: appName,),
    );
  }
}
