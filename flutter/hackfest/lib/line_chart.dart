import 'package:flutter/material.dart';
import 'package:hackfest/line_points.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:cloud_firestore/cloud_firestore.dart';

class LineChart extends StatefulWidget {

  @override
  LineChartState createState() {
    return new LineChartState();
  }
}

class LineChartState extends State<LineChart> {
  List<LinePoint> pointsList = <LinePoint>[];

  List<chart.Series<LinePoint, num>> datumList() {
    print("POINTS LIST : " + pointsList.toString());
    return [
      chart.Series<LinePoint, num>(
          id: "line",
          data: pointsList,
          domainFn: (LinePoint point, _) => point.x,
          measureFn: (LinePoint p, _) => p.y,
          colorFn: (LinePoint clickData, _) => clickData.color,
          displayName: "temprature")
    ];
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: Firestore.instance.collection("data").snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        print("Snapshot : " + snapshot.toString());
        if (!snapshot.hasData) {
          return const Center(
            child: const Text("No data available."),
          );
        }
0
        for (int i = 0; i < snapshot.data.documents.length; i++) {
//          setState(() {
            pointsList.add(LinePoint(
                i,
                num.parse(snapshot.data.documents[i].data['temp']),
                Colors.green));

            print("DATA : " + snapshot.data.documents[i].data['temp']);
            print("pointsList[i].toString() : "  + pointsList.toString());
//          });
        }

        return Container(
            constraints: BoxConstraints.expand(),
            child: chart.LineChart(datumList()));
      },
    );
  }
}
