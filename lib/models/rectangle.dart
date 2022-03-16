import 'package:fake_tomograf/models/point.dart';

class Rectangle {
  late Point p1;
  late Point p2;
  late Point p3;
  late Point p4;
  late double resistance;

  // TODO: Add lines

  Rectangle(int x, int y, int width, int height, {this.resistance = 0.0}) {
    p1 = Point(x.toDouble(), y.toDouble());
    p2 = Point(x.toDouble() + width, y.toDouble());
    p3 = Point(x.toDouble(), y.toDouble() + height);
    p4 = Point(x.toDouble() + width, y.toDouble() + height);
  }

  @override
  String toString() {
    return '${p1.toString()}, ${p2.toString()}\n${p3.toString()}, ${p4.toString()}';
  }
}
