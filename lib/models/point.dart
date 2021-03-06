// Dart imports:
import 'dart:math';

class Point {
  double x;
  double y;

  Point(this.x, this.y);

  double getDistance(Point point) {
    return sqrt(pow(point.x - x, 2) + pow(point.y - y, 2));
  }

  bool equals(Point point) {
    return point.x == x && point.y == y;
  }

  @override
  bool operator ==(Object other) =>
      other is Point &&
      other.runtimeType == runtimeType &&
      other.x == x &&
      other.y == y;

  @override
  String toString() {
    return '($x, $y)';
  }

  @override
  int get hashCode => super.hashCode;
}
