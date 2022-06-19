class RectangleViewModel {
  RectangleViewModel({
    required String rectangleStartX,
    required String rectangleStartY,
    required String rectangleXWidth,
    required String rectangleYLength,
    required String absorptionCapacity,
  })  : rectangleX = int.parse(rectangleStartX),
        rectangleY = int.parse(rectangleStartY),
        rectangleXwidth = int.parse(rectangleXWidth),
        rectangleYlength = int.parse(rectangleYLength),
        absorptionCapacity = double.parse(absorptionCapacity);

  final int rectangleX;
  final int rectangleY;
  final int rectangleXwidth;
  final int rectangleYlength;
  final double absorptionCapacity;
}
