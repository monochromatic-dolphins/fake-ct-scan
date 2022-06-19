// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:fake_tomograf/helpers/app_colors.dart';
import 'package:fake_tomograf/models/rectangle.dart';
import 'package:fake_tomograf/models/tomograph.dart';

class RectanglePainter extends CustomPainter {
  RectanglePainter(this.tomograph, this.context, this.pixels);

  final Tomograph tomograph;
  final BuildContext context;
  final List<double> pixels;

  final _lowPaint = Paint()..color = AppColors.emeraldGreen;
  final _mediumPaint = Paint()..color = AppColors.beeOrange;
  final _highPaint = Paint()..color = AppColors.bloodRed;

  @override
  void paint(Canvas canvas, Size size) {
    if (pixels.isNotEmpty) return;
    Paint paint;
    final stepSize = (MediaQuery.of(context).size.height - 100) / tomograph.board.height.toDouble();

    for (final rectangle in tomograph.rectangles) {
      final rect = Rect.fromLTWH(
        rectangle.pointBottomLeft.x * stepSize,
        rectangle.pointBottomLeft.y * stepSize,
        rectangle.width.toDouble() * stepSize,
        rectangle.height.toDouble() * stepSize,
      );
      switch (rectangle.resistance.getResistanceRange()) {
        case ResistanceRange.low:
          paint = _lowPaint;
          break;
        case ResistanceRange.medium:
          paint = _mediumPaint;
          break;
        case ResistanceRange.high:
          paint = _highPaint;
          break;
      }
      // paint = Paint()..color = Color.fromRGBO(rectangle.resistance.toInt(), rectangle.resistance.toInt(), 0, 0.8);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
