import 'package:flutter/material.dart';
import 'package:hackfest/line_points.dart';
import 'package:hackfest/temprature/chart_today.dart';
import 'package:hackfest/vibration/chart_today.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_devices.dart';

class Home extends StatefulWidget {
  final String appName;
//  final List<LinePoint> pointList;

  const Home({Key key, this.appName}) : super(key: key);

  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.appName),
            centerTitle: true,
            bottom: TabBar(tabs: [
              Tab(
                text: "TEMPRATURE",
              ),
              Tab(
                text: "VIBRATION",
              ),
            ]),
          ),
          body: TabContainers(
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.bluetooth),
          ),
        ));
  }
}

class TabContainers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

//    print("pointList" + pointList.toString());
    return TabBarView(children: [
      ChartToday(
      ),
      VibChart(),
    ]);
  }
}
