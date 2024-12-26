
import 'dart:math';

import 'package:flutter/material.dart';

class ChristmasTree extends StatelessWidget {
  const ChristmasTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Christmas Tree'),
      ),
      body: CustomPaint(
        size: const Size(300, 600),
        painter: TreePainter(),
      ),
    );
  }
}

class TreePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    const double turns = 15;
    const double height = 200;
    const double baseRadius = 120;

    for (double t = 0; t < turns * 2 * pi; t+= 0.1) {

      final double radius = baseRadius * (1 - t / (turns * 2 * pi));
      final double x = centerX + radius * cos(t * 2 * pi);
      final double y = centerY + (height * t/(turns * 2 * pi));
      canvas.drawCircle(Offset(x, y), 5, paint);
    }

  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}