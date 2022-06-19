// Dart imports:
import 'dart:math';
import 'dart:ui';
import 'package:collection/collection.dart';

// Project imports:
import 'package:fake_tomograf/models/pixel_with_length.dart';
import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/rectangle.dart';
import 'package:fake_tomograf/models/straight_line.dart';

class Tomograph {
  late Rectangle board;
  late List<Rectangle> pixelBoard;
  late List<Point> emitters = [];
  late List<Point> receivers = [];
  late List<StraightLine> beams = [];
  late List<Rectangle> rectangles = [];
  int m;

  Tomograph(int resolution, this.m) {
    board = Rectangle(0, 0, resolution, resolution);
    pixelBoard = _createPixelBoard(resolution);
    _calculateEntryPoints(resolution);
    _createBeams();
  }

  List<Rectangle> _createPixelBoard(int resolution) {
    List<Rectangle> pixels = [];
    for (int i = 0; i < resolution; i++) {
      for (int j = 0; j < resolution; j++) {
        pixels.add(Rectangle(i, j, 1, 1));
      }
    }
    return pixels;
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

  Map<StraightLine, double> getBeamsLoss() {
    var beamsWithLoss = <StraightLine, double>{};
    for (var beam in beams) {
      var beamTotalLoss = 0.0;
      for (var rectangle in rectangles) {
        var points = rectangle.getIntersectionPoints(beam);
        if (points.isNotEmpty && points.length > 1) {
          var length = points.first.getDistance(points[1]);
          var beamLost = length * rectangle.resistance;
          beamTotalLoss += beamLost;
        }
      }
      beamsWithLoss.putIfAbsent(beam, () => beamTotalLoss);
    }
    return beamsWithLoss;
  }

  Map<StraightLine, List<double>> getBeamsWithPixels(int resolution) {
    var beamsWithPixels = <StraightLine, List<double>>{};
    for (var beam in beams) {
      beamsWithPixels[beam] = List.filled(resolution * resolution, 0.0);
      var startingPoint = beam.p1;
      Rectangle? currentPixel;

      // Search for the first pixel
      for (var pixel in pixelBoard) {
        if (pixel.isPointInside(startingPoint)) {
          currentPixel = pixel;
          break;
        }
      }
      do {
        var intersectionPoints = currentPixel!.getIntersectionPoints(beam);
        if (intersectionPoints.length == 2) {
          var lengthInPixel =
              intersectionPoints[0].getDistance(intersectionPoints[1]);
          (beamsWithPixels[beam])![currentPixel.toIndex(resolution)] =
              lengthInPixel;
        }
        currentPixel = getNextPixel(beam, currentPixel, resolution);
      } while (currentPixel != null);
    }

    return beamsWithPixels;
  }

  // Move through the pixel board, but not iterate over all of the pixels
  Rectangle? getNextPixel(StraightLine beam, Rectangle currentPixel, int resolution) {
    if (currentPixel.pointTopLeft.y == resolution) {
      return null;
    } else if (beam.isVertical) {
      return pixelBoard.firstWhereOrNull((element) {
        return element.pointBottomRight == currentPixel.pointTopRight &&
            element.pointBottomLeft == currentPixel.pointTopLeft;
      });
    } else {
      var intersectionPoints = currentPixel.getIntersectionPoints(beam);
      var higherPoint = intersectionPoints.reduce((value, element) {
        if (value.y > element.y) {
          return value;
        } else {
          return element;
        }
      });
      var direction = currentPixel.getPointDirection(higherPoint);
      switch (direction) {
        case MoveDirection.left:
          {
            return pixelBoard.singleWhere((element) =>
                element.pointTopRight == currentPixel.pointTopLeft &&
                element.pointBottomRight == currentPixel.pointBottomLeft);
          }
        case MoveDirection.diagonalLeft:
          {
            return pixelBoard.singleWhere((element) =>
                element.pointBottomRight == currentPixel.pointTopLeft);
          }
        case MoveDirection.top:
          {
            return pixelBoard.singleWhere((element) =>
                element.pointBottomLeft == currentPixel.pointTopLeft &&
                element.pointBottomRight == currentPixel.pointTopRight);
          }
        case MoveDirection.diagonalRight:
          {
            return pixelBoard.singleWhere((element) =>
                element.pointBottomLeft == currentPixel.pointTopRight);
          }
        case MoveDirection.right:
          {
            return pixelBoard.singleWhere((element) =>
                element.pointTopLeft == currentPixel.pointTopRight &&
                element.pointBottomLeft == currentPixel.pointBottomRight);
          }
      }
    }
  }

  @override
  String toString() => '$board, $m, $beams, $rectangles';
}

enum MoveDirection { left, diagonalLeft, top, diagonalRight, right }
