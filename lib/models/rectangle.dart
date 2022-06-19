// Project imports:
import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/straight_line.dart';
import 'package:fake_tomograf/models/tomograph.dart';
import 'package:fake_tomograf/view_models/rectangle_view_model.dart';

class Rectangle {
  final Point pointTopLeft;
  final Point pointTopRight;
  final Point pointBottomRight;
  final Point pointBottomLeft;
  final double resistance;
  final StraightLine lineTop;
  final StraightLine lineRight;
  final StraightLine lineBottom;
  final StraightLine lineLeft;
  final int width;
  final int height;

  factory Rectangle(int x, int y, int width, int height, {double? resistance}) {
    final pointBottomLeft = Point(x.toDouble(), y.toDouble());
    final pointBottomRight = Point(x.toDouble() + width, y.toDouble());
    final pointTopRight = Point(x.toDouble() + width, y.toDouble() + height);
    final pointTopLeft = Point(x.toDouble(), y.toDouble() + height);
    final lineTop = StraightLine(pointTopLeft, pointTopRight);
    final lineRight = StraightLine(pointTopRight, pointBottomRight);
    final lineBottom = StraightLine(pointBottomRight, pointBottomLeft);
    final lineLeft = StraightLine(pointBottomLeft, pointTopLeft);
    return Rectangle._internal(
      height: height,
      width: width,
      lineLeft: lineLeft,
      lineRight: lineRight,
      lineBottom: lineBottom,
      lineTop: lineTop,
      pointBottomLeft: pointBottomLeft,
      pointBottomRight: pointBottomRight,
      pointTopLeft: pointTopLeft,
      pointTopRight: pointTopRight,
      resistance: resistance ?? 0,
    );
  }

  factory Rectangle.fromViewModel(RectangleViewModel viewModel) {
    return Rectangle(
      viewModel.rectangleX,
      viewModel.rectangleY,
      viewModel.rectangleXwidth,
      viewModel.rectangleYlength,
      resistance: viewModel.absorptionCapacity,
    );
  }

  Rectangle._internal({
    required this.height,
    required this.width,
    required this.lineLeft,
    required this.lineRight,
    required this.lineBottom,
    required this.lineTop,
    required this.pointBottomLeft,
    required this.pointBottomRight,
    required this.pointTopLeft,
    required this.pointTopRight,
    required this.resistance,
  });

  List<Point> getIntersectionPoints(StraightLine otherLine) {
    // Check intersections on edge overlapping
    if (otherLine.overlaps(lineLeft)) return [pointTopLeft, pointBottomLeft];
    if (otherLine.overlaps(lineRight)) return [pointTopRight, pointBottomRight];
    if (otherLine.overlaps(lineTop)) return [pointTopLeft, pointTopRight];
    if (otherLine.overlaps(lineBottom)) {
      return [pointBottomLeft, pointBottomRight];
    }

    // Find point of intersection for each line
    List<Point> pointsOfIntersections = [
      lineTop,
      lineRight,
      lineBottom,
      lineLeft
    ].fold(<Point>[], (List<Point> result, rectangleLine) {
      Point? point = otherLine.getPointOfIntersection(rectangleLine);
      if (point != null) result.add(point);
      return result;
    });

    // Remove duplicates
    Set<String> pointsTmp = <String>{};
    pointsOfIntersections = pointsOfIntersections
        .where((point) => pointsTmp.add(point.toString()))
        .toList();

    return pointsOfIntersections;
  }

  bool isPointInside(Point point) {
    return point.x >= pointBottomLeft.x &&
        point.x <= pointBottomRight.x &&
        point.y <= pointTopRight.y &&
        point.y >= pointBottomRight.y;
  }

  MoveDirection getPointDirection(Point point) {
    if (point == pointTopLeft) {
      return MoveDirection.diagonalLeft;
    } else if (point.x == pointTopLeft.x) {
      return MoveDirection.left;
    } else if (point.x > pointTopLeft.x && point.x < pointTopRight.x) {
      return MoveDirection.top;
    } else if (point == pointTopRight) {
      return MoveDirection.diagonalRight;
    } else {
      return MoveDirection.right;
    }
  }

  int toIndex(int resolution) {
    return pointBottomLeft.x.toInt() + pointBottomLeft.y.toInt() * resolution;
  }

  @override
  String toString() {
    return 'tl: $pointTopLeft, tr: $pointTopRight, br: $pointBottomRight, bl: $pointBottomLeft';
  }
}

enum ResistanceRange { low, medium, high }

extension ResistanceValueExtension on double {
  ResistanceRange getResistanceRange() {
    if (this < 3) {
      return ResistanceRange.low;
    } else if (this < 6) {
      return ResistanceRange.medium;
    } else {
      return ResistanceRange.high;
    }
  }
}
