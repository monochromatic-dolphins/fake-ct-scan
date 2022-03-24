import 'package:fake_tomograf/models/point.dart';

class RectangleViewModel {
  RectangleViewModel({
    required String rectangleStartX,
    required String rectangleStartY,
    required String rectangleXlength,
    required String rectangleYwidth,
    required String absorptionCapacity,
  })  : rectangleX = int.parse(rectangleStartX),
        rectangleY = int.parse(rectangleStartY),
        rectangleXwidth = int.parse(rectangleXlength),
        rectangleYlength = int.parse(rectangleXlength),
        absorptionCapacity = double.parse(absorptionCapacity);

  final int rectangleX;
  final int rectangleY;
  final int rectangleXwidth;
  final int rectangleYlength;
  final double absorptionCapacity;
}
