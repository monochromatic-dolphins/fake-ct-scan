import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/straight_line.dart';

class Rectangle {
  late Point pointTopLeft;
  late Point pointTopRight;
  late Point pointBottomRight;
  late Point pointBottomLeft;
  late double resistance;
  late StraightLine lineTop;
  late StraightLine lineRight;
  late StraightLine lineBottom;
  late StraightLine lineLeft;

  Rectangle(int x, int y, int width, int height, {this.resistance = 0.0}) {
    pointTopLeft = Point(x.toDouble(), y.toDouble());
    pointTopRight = Point(x.toDouble() + width, y.toDouble());
    pointBottomRight = Point(x.toDouble() + width, y.toDouble() - height);
    pointBottomLeft = Point(x.toDouble(), y.toDouble() - height);
    lineTop = StraightLine(pointTopLeft, pointTopRight);
    lineRight = StraightLine(pointTopRight, pointBottomRight);
    lineBottom = StraightLine(pointBottomRight, pointBottomLeft);
    lineLeft = StraightLine(pointBottomLeft, pointTopLeft);
  }

  List<Point> getIntersectionPoints(StraightLine otherLine) {
    // Check intersections on edge overlapping
    if (otherLine.overlaps(lineLeft)) return [pointTopLeft, pointBottomLeft];
    if (otherLine.overlaps(lineRight)) return [pointTopRight, pointBottomRight];
    if (otherLine.overlaps(lineTop)) return [pointTopLeft, pointTopRight];
    if (otherLine.overlaps(lineBottom)) return [pointBottomLeft, pointBottomRight];

    // Find point of intersection for each line
    List<Point> pointsOfIntersections = [lineTop, lineRight, lineBottom, lineLeft].fold(<Point>[], (List<Point> result, rectangleLine) {
      Point? point = otherLine.getPointOfIntersection(rectangleLine);
      if (point != null) result.add(point);
      return result;
    });

    // Remove duplicates
    Set<String> pointsTmp = <String>{};
    pointsOfIntersections = pointsOfIntersections.where((point) => pointsTmp.add(point.toString())).toList();

    return pointsOfIntersections;
  }

  @override
  String toString() {
    return '${pointTopLeft.toString()}, ${pointTopRight.toString()}\n${pointBottomRight.toString()}, ${pointBottomLeft.toString()}';
  }
}
