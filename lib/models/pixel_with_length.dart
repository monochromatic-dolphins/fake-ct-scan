import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/rectangle.dart';

class PixelWithLength {
  Rectangle point;
  double length;

  PixelWithLength(this.point, this.length);

  @override
  String toString() {
    return "($point -> $length)";
  }
}