import 'dart:math';
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final int starCount;
  final Random random;

  BackgroundPainter({this.starCount = 200}) : random = Random(12345);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: .5)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < starCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 0.8;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
