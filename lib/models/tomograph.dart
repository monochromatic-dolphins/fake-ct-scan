import 'dart:math';
import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/rectangle.dart';
import 'package:fake_tomograf/models/straight_line.dart';

class Tomograph {
  late Rectangle tomograph;
  late List<List<Point>> entryPoints = [[], []];
  late List<StraightLine> bundles = [];
  int m;

  Tomograph(int a, this.m) {
    tomograph = Rectangle(0, 0, a, a);
    _calculateEntryPoints(a);
    _calculateBundleLines();
  }

  void _calculateEntryPoints(int a) {
    double divider = a / (m - 1);
    for (var i = 0; i < m; i++) {
      entryPoints.first.add(Point(roundDouble(i * divider, 3), 0));
      entryPoints.last.add(Point(roundDouble(i * divider, 3), a));
    }
  }

  void _calculateBundleLines() {
    for (var i = 0; i < m; i++) {
      for (var j = 0; j < m; j++) {
        Point point1 = Point(
            entryPoints.first.elementAt(i).x, entryPoints.first.elementAt(i).y);
        Point point2 = Point(
            entryPoints.last.elementAt(j).x, entryPoints.last.elementAt(j).y);
        bundles.add(StraightLine(point1, point2));
      }
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
