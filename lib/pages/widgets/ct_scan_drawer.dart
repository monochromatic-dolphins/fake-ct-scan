// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:fake_tomograf/models/tomograph.dart';
import 'package:fake_tomograf/pages/widgets/mesh_painter.dart';
import 'rectangle_painter.dart';

class CTScanDrawer extends StatefulWidget {
  const CTScanDrawer(this.tomograph, this.pixels, {Key? key}) : super(key: key);
  final Tomograph tomograph;
  final List<double> pixels;

  @override
  State<StatefulWidget> createState() => _CTScanDrawerState();
}

class _CTScanDrawerState extends State<CTScanDrawer> {
  @override
  Widget build(BuildContext context) {
    final stepSize = (MediaQuery.of(context).size.height - 100) /
        widget.tomograph.board.height.toDouble();
    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationX(pi),
        child: CustomPaint(
          child: CustomPaint(
            child: SizedBox(
              width: widget.tomograph.board.width.toDouble() * stepSize,
              height: widget.tomograph.board.height.toDouble() * stepSize,
            ),
            foregroundPainter:
                MeshPainter(widget.tomograph, context, widget.pixels),
          ),
          foregroundPainter: RectanglePainter(widget.tomograph, context, widget.pixels),
        ),
      ),
    );
  }
}
