// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:fake_tomograf/helpers/app_colors.dart';
import 'package:fake_tomograf/models/rectangle.dart';
import 'package:fake_tomograf/models/tomograph.dart';

class RectanglePainter extends CustomPainter {
  RectanglePainter(this.tomograph);

  final Tomograph tomograph;

  final _lowPaint = Paint()..color = AppColors.emeraldGreen;
  final _mediumPaint = Paint()..color = AppColors.beeOrange;
  final _highPaint = Paint()..color = AppColors.bloodRed;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint;
    for (final rectangle in tomograph.rectangles) {
      final rect = Rect.fromLTWH(
        rectangle.pointBottomLeft.x * 10,
        rectangle.pointBottomLeft.y * 10,
        rectangle.width.toDouble() * 10,
        rectangle.height.toDouble() * 10,
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
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
