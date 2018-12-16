import 'package:flutter/material.dart';
import 'package:hackfest/line_chart.dart';
import 'package:hackfest/line_points.dart';

const String safeMessage = "No Risk";
const String dangerMessage = "Risk found";

class VibChart extends StatelessWidget {
  @override
  List<LinePoint> pointList = <LinePoint>[
    LinePoint(1, 2, Colors.green),
    LinePoint(2, 2, Colors.green),
    LinePoint(3, 5, Colors.green),
    LinePoint(4, 5, Colors.red),
    LinePoint(5, 23.3, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[AlertContainer(), Expanded(child: LineChart())],
      ),
    );
  }
}

class AlertContainer extends StatefulWidget {
  @override
  AlertContainerState createState() {
    return new AlertContainerState();
  }
}

class AlertContainerState extends State<AlertContainer> {
  bool _isSafe;
  double _maxValue;

  @override
  void initState() {
    _isSafe = false;
    _maxValue = 23.3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _isSafe ? safeMessage : dangerMessage,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Max. value ${_maxValue}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Icon(
            _isSafe ? Icons.check_circle : Icons.error,
            color: Colors.white,
          )
        ],
      ),
      color: _isSafe ? Colors.green : Colors.red,
    );
  }
}
