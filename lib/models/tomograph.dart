// Dart imports:
import 'dart:math';

// Project imports:
import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/rectangle.dart';
import 'package:fake_tomograf/models/straight_line.dart';

class Tomograph {
  late Rectangle board;
  late List<Point> emitters = [];
  late List<Point> receivers = [];
  late List<StraightLine> beams = [];
  late List<Rectangle> rectangles = [];
  int m;

  Tomograph(int resolution, this.m) {
    board = Rectangle(0, 0, resolution, resolution);
    _calculateEntryPoints(resolution);
    _createBeams();
  }

  void _calculateEntryPoints(int a) {
    double divider = a / (m - 1);
    for (var i = 0; i < m; i++) {
      emitters.add(Point(roundDouble(i * divider, 3), 0));
      receivers.add(Point(roundDouble(i * divider, 3), a.toDouble()));
    }
  }

  void _createBeams() {
    for (Point emitter in emitters) {
      for (Point receiver in receivers) {
        beams.add(StraightLine(emitter, receiver));
      }
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Map<StraightLine, double> getBeamsLost() {
    var beamsWithLose = <StraightLine, double>{};
    for (var beam in beams) {
      var beamTotalLost = 0.0;
      for (var rectangle in rectangles) {
        var points = rectangle.getIntersectionPoints(beam);
        if (points.isNotEmpty) {
          var length = points.first.getDistance(points[1]);
          var beamLost = length * rectangle.resistance;
          beamTotalLost += beamLost;
        }
      }
      beamsWithLose.putIfAbsent(beam, () => beamTotalLost);
    }
    return beamsWithLose;
  }

  @override
  String toString() => '$board, $m, $beams, $rectangles';
}
