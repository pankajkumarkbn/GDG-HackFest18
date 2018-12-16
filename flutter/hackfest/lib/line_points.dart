import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as chart;

class LinePoint {
  final int x;
  final num y;
  final chart.Color color;

  LinePoint(this.x, this.y, Color color)
      : this.color = new chart.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);

}