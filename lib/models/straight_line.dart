// Project imports:
import 'package:fake_tomograf/models/point.dart';

class StraightLine {
  Point p1;
  Point p2;
  late double a;
  late double b;

  StraightLine(this.p1, this.p2) {
    if (p1.equals(p2)) {
      throw Exception('Cannot create a line from a single point');
    }
    _calculateEquation();
  }

  bool get isHorizontal {
    return p1.y == p2.y;
  }

  bool get isVertical {
    return p1.x == p2.x;
  }

  bool get isDiagonal {
    return !isHorizontal && !isVertical;
  }

  void _calculateEquation() {
    if (isVertical) {
      a = 0;
      b = p1.x.toDouble();
    } else if (isHorizontal) {
      a = 0;
      b = p1.y.toDouble();
    } else {
      a = (p2.y - p1.y) / (p2.x - p1.x);
      b = p1.y - a * p1.x;
    }
  }

  /// Returns a point where two lines intersects if the point of intersection is
  /// on the current line (between points creating the line). If the lines are
  /// parallel or point is out of line boundaries returns a null.
  /// The case for parallel lines should be handled separately, for example using
  /// the `overlaps()` method.
  Point? getPointOfIntersection(StraightLine otherLine) {
    double? x;
    double? y;
    Point? point;

    if (overlaps(otherLine)) return point;

    if (isDiagonal && otherLine.isDiagonal) {
      x = (otherLine.b - b) / (a - otherLine.a);
      y = (a * x) + b;
    } else if (isDiagonal && otherLine.isHorizontal) {
      y = otherLine.b;
      x = (y - b) / a;
    } else if (isDiagonal && otherLine.isVertical) {
      x = otherLine.b;
      y = (a * x) + b;
    } else if (isHorizontal && otherLine.isDiagonal) {
      y = b;
      x = (y - otherLine.b) / otherLine.a;
    } else if (isHorizontal && otherLine.isVertical) {
      x = otherLine.b;
      y = b;
    } else if (isVertical && otherLine.isDiagonal) {
      x = b;
      y = (otherLine.a * x) + otherLine.b;
    } else if (isVertical && otherLine.isHorizontal) {
      x = b;
      y = otherLine.b;
    }

    if (x != null && y != null) {
      x = x == -0.0 ? 0 : x;
      y = y == -0.0 ? 0 : y;

      Point p = Point(x, y);
      if (isPointWithinBoundaryOfLine(p) && otherLine.isPointWithinBoundaryOfLine(p)) point = p;
    }

    return point;
  }

  bool isPointWithinBoundaryOfLine(Point point) {
    double xMin = p1.x < p2.x ? p1.x : p2.x;
    double xMax = p1.x > p2.x ? p1.x : p2.x;
    double yMin = p1.y < p2.y ? p1.y : p2.y;
    double yMax = p1.y > p2.y ? p1.y : p2.y;

    return (xMin <= point.x && point.x <= xMax) && (yMin <= point.y && point.y <= yMax);
  }

  bool overlaps(StraightLine otherLine) {
    return (a == otherLine.a && b == otherLine.b) &&
        (isDiagonal && otherLine.isDiagonal ||
            isVertical && otherLine.isVertical ||
            isHorizontal && otherLine.isHorizontal);
  }

  @override
  String toString() {
    if (isHorizontal) return 'y = ${b.toStringAsFixed(2)}';
    if (isVertical) return 'x = ${b.toStringAsFixed(2)}';
    return 'y = ${a.toStringAsFixed(2)}x + ${b.toStringAsFixed(2)}';
  }
}
