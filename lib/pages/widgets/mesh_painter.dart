// Flutter imports:
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:fake_tomograf/helpers/app_colors.dart';
import 'package:fake_tomograf/models/point.dart';
import 'package:fake_tomograf/models/tomograph.dart';

class MeshPainter extends CustomPainter {
  MeshPainter(this.tomograph, this.context, this.pixels);

  final Tomograph tomograph;
  final BuildContext context;
  final List<double> pixels;

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

    final stepSize = (MediaQuery.of(context).size.height - 100) / tomograph.board.height.toDouble();

    // Draw vertical lines
    for (var i = tStart.x; i <= tEnd.x; i++) {
      Offset start = Offset(i * stepSize, tStart.y * stepSize);
      Offset end = Offset(i * stepSize, tEnd.y * stepSize);
      canvas.drawLine(start, end, meshPaint);
    }

    // Draw horizontal lines
    for (var i = tStart.y; i <= tEnd.y; i++) {
      Offset start = Offset(tStart.x * stepSize, i * stepSize);
      Offset end = Offset(tEnd.x * stepSize, i * stepSize);
      canvas.drawLine(start, end, meshPaint);
    }

    final beamPaint = Paint()
      ..color = AppColors.unicornPurple
      ..strokeWidth = 3;

    // Draw beams
    for (final beam in tomograph.beams) {
      Offset start = Offset(beam.p1.x * stepSize, beam.p1.y * stepSize);
      Offset end = Offset(beam.p2.x * stepSize, beam.p2.y * stepSize);
      canvas.drawLine(start, end, beamPaint);
    }

    // Draw calculated pixels
    if (pixels.isEmpty) return;
    final maxValue = pixels.reduce(max);
    for (int i = 0; i < pixels.length; i++) {
      if (pixels[i] == 0) continue;

      final row = (i / tomograph.board.width).floor();
      final column = i % tomograph.board.width;
      print('Pixel $i -> row: $row, column $column, value ${pixels[i]}');

      final rect = Rect.fromLTWH(column.toDouble() * stepSize, row.toDouble() * stepSize, stepSize, stepSize,);
      final opacity = pixels[i] / maxValue;
      print(opacity);
      final paint = Paint()..color = Color.fromRGBO(0, 255, 0, opacity);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
