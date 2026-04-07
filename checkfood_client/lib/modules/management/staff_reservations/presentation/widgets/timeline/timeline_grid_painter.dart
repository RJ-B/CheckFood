import 'package:flutter/material.dart';

/// Custom painter that draws the horizontal row lines and vertical hour/half-hour
/// grid for the reservation timeline.
class TimelineGridPainter extends CustomPainter {
  final int tableCount;
  final double rowHeight;
  final double pixelsPerHour;
  final double totalHours;

  TimelineGridPainter({
    required this.tableCount,
    required this.rowHeight,
    required this.pixelsPerHour,
    required this.totalHours,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final lightPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 0.5;

    final halfHourPaint = Paint()
      ..color = const Color(0xFFF3F4F6)
      ..strokeWidth = 0.5;

    for (int i = 0; i <= tableCount; i++) {
      final y = i * rowHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), lightPaint);
    }

    final hours = totalHours.ceil();
    for (int i = 0; i <= hours; i++) {
      final x = i * pixelsPerHour;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), lightPaint);
      if (i < hours) {
        final halfX = x + pixelsPerHour / 2;
        canvas.drawLine(
            Offset(halfX, 0), Offset(halfX, size.height), halfHourPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant TimelineGridPainter oldDelegate) =>
      oldDelegate.tableCount != tableCount ||
      oldDelegate.totalHours != totalHours;
}
