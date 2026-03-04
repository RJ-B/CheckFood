import 'dart:math';
import 'package:flutter/material.dart';

class AngleGuidancePainter extends CustomPainter {
  final double currentHeading;
  final Set<int> capturedAngles;
  final int totalAngles;
  final int? activeTargetIndex;

  AngleGuidancePainter({
    required this.currentHeading,
    required this.capturedAngles,
    this.totalAngles = 8,
    this.activeTargetIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.35;
    final dotRadius = 10.0;
    final angleStep = 360.0 / totalAngles;

    // Outer circle (guide ring)
    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, ringPaint);

    // Target dots
    for (int i = 0; i < totalAngles; i++) {
      final angleDeg = i * angleStep;
      final angleRad = (angleDeg - 90) * pi / 180;
      final dotCenter = Offset(
        center.dx + radius * cos(angleRad),
        center.dy + radius * sin(angleRad),
      );

      final Paint dotPaint;
      if (capturedAngles.contains(i)) {
        // Captured: green
        dotPaint = Paint()..color = Colors.greenAccent;
      } else if (i == activeTargetIndex) {
        // Current target: yellow, pulsing
        dotPaint = Paint()..color = Colors.yellowAccent;
      } else {
        // Pending: white semi-transparent
        dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.5);
      }

      canvas.drawCircle(dotCenter, dotRadius, dotPaint);

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${angleDeg.toInt()}',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 10,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(dotCenter.dx - textPainter.width / 2, dotCenter.dy + dotRadius + 2),
      );
    }

    // Current heading arrow
    final headingRad = (currentHeading - 90) * pi / 180;
    final arrowLength = radius * 0.7;
    final arrowEnd = Offset(
      center.dx + arrowLength * cos(headingRad),
      center.dy + arrowLength * sin(headingRad),
    );

    final arrowPaint = Paint()
      ..color = Colors.tealAccent
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, arrowEnd, arrowPaint);

    // Arrow tip
    final tipSize = 12.0;
    final tipAngle1 = headingRad + pi * 0.85;
    final tipAngle2 = headingRad - pi * 0.85;
    final tip1 = Offset(
      arrowEnd.dx + tipSize * cos(tipAngle1),
      arrowEnd.dy + tipSize * sin(tipAngle1),
    );
    final tip2 = Offset(
      arrowEnd.dx + tipSize * cos(tipAngle2),
      arrowEnd.dy + tipSize * sin(tipAngle2),
    );
    final tipPath = Path()
      ..moveTo(arrowEnd.dx, arrowEnd.dy)
      ..lineTo(tip1.dx, tip1.dy)
      ..lineTo(tip2.dx, tip2.dy)
      ..close();
    canvas.drawPath(tipPath, Paint()..color = Colors.tealAccent);
  }

  @override
  bool shouldRepaint(covariant AngleGuidancePainter oldDelegate) {
    return currentHeading != oldDelegate.currentHeading ||
        capturedAngles != oldDelegate.capturedAngles ||
        activeTargetIndex != oldDelegate.activeTargetIndex;
  }
}
