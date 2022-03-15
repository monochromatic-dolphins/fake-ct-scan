import 'package:fake_tomograf/models/point.dart';

class StraightLine {
  Point p1;
  Point p2;
  late double a;
  late double b;
  late final String equation;

  StraightLine(this.p1, this.p2) {
    if (p1.equals(p2)) {
      throw Exception('Cannot create a line from a single point');
    }
    _calculateEquation();
  }

  void _calculateEquation() {
    if (isVertical()) {
      a = 0;
      b = p1.x.toDouble();
    } else if (isHorizontal()) {
      a = 0;
      b = p1.y.toDouble();
    } else {
      a = (p2.y - p1.y) / (p2.x - p1.x);
      b = p1.y - a * p1.x;
    }
  }

  bool isHorizontal() {
    return p1.y == p2.y;
  }

  bool isVertical() {
    return p1.x == p2.x;
  }

  bool isDiagonal() {
    return !isHorizontal() && !isVertical();
  }

  @override
  String toString() {
    if (a == 0) return 'y = ${b.toStringAsFixed(2)}';
    return 'y = ${a.toStringAsFixed(2)}x + ${b.toStringAsFixed(2)}';
  }
}
