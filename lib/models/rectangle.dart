import 'package:fake_tomograf/models/point.dart';

class Rectangle {
  late Point p1;
  late Point p2;
  late Point p3;
  late Point p4;
  double m;

  Rectangle(int x, int y, int width, int height, this.m) {
    p1 = Point(x, y);
    p2 = Point(x + width, y);
    p3 = Point(x, y + height);
    p4 = Point(x + width, y + height);
  }

  @override
  String toString() {
    return '${p1.toString()}, ${p2.toString()}\n${p3.toString()}, ${p4.toString()}';
  }
}
