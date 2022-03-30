// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:fake_tomograf/helpers/app_colors.dart';
import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/tomograph.dart';

class MeshPainter extends CustomPainter {
  MeshPainter(this.tomograph);

  final Tomograph tomograph;

  @override
  void paint(Canvas canvas, Size size) {
    final meshPaint = Paint()
      ..color = AppColors.cloudyGrey
      ..strokeWidth = 1;

    final tStart = Point(0, 0);
    final tEnd = Point(
      tomograph.board.width.toDouble(),
      tomograph.board.height.toDouble(),
    );

    // Draw vertical lines
    for (var i = tStart.x; i <= tEnd.x; i++) {
      Offset start = Offset(i * 10, tStart.y * 10);
      Offset end = Offset(i * 10, tEnd.y * 10);
      canvas.drawLine(start, end, meshPaint);
    }

    // Draw horizontal lines
    for (var i = tStart.y; i <= tEnd.y; i++) {
      Offset start = Offset(tStart.x * 10, i * 10);
      Offset end = Offset(tEnd.x * 10, i * 10);
      canvas.drawLine(start, end, meshPaint);
    }

    final beamPaint = Paint()
      ..color = AppColors.unicornPurple
      ..strokeWidth = 3;

    // Draw beams
    for (final beam in tomograph.beams) {
      Offset start = Offset(beam.p1.x * 10, beam.p1.y * 10);
      Offset end = Offset(beam.p2.x * 10, beam.p2.y * 10);
      canvas.drawLine(start, end, beamPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
