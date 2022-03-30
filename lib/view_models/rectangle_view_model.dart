class RectangleViewModel {
  RectangleViewModel({
    required String rectangleStartX,
    required String rectangleStartY,
    required String rectangleXwidth,
    required String rectangleYlength,
    required String absorptionCapacity,
  })  : rectangleX = int.parse(rectangleStartX),
        rectangleY = int.parse(rectangleStartY),
        rectangleXwidth = int.parse(rectangleXwidth),
        rectangleYlength = int.parse(rectangleYlength),
        absorptionCapacity = double.parse(absorptionCapacity);

  final int rectangleX;
  final int rectangleY;
  final int rectangleXwidth;
  final int rectangleYlength;
  final double absorptionCapacity;
}
