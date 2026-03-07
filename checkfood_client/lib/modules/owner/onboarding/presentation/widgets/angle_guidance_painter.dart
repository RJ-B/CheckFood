import 'dart:math';
import 'package:flutter/material.dart';
import 'panorama_capture_screen.dart' show SpherePoint;

/// AR overlay painter that projects sphere-grid capture points onto the camera
/// preview using a simple 3D → 2D perspective projection with FOV culling.
class SphereGuidancePainter extends CustomPainter {
  final double currentYaw;
  final double currentPitch;
  final Set<int> capturedIndices;
  final List<SpherePoint> sphereGrid;
  final int? alignedIndex;
  final double pulseScale;
  final double cameraFov;

  SphereGuidancePainter({
    required this.currentYaw,
    required this.currentPitch,
    required this.capturedIndices,
    required this.sphereGrid,
    this.alignedIndex,
    this.pulseScale = 1.0,
    this.cameraFov = 70.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final halfFov = cameraFov / 2;

    // Crosshair at center
    final crossPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(cx - 20, cy),
      Offset(cx + 20, cy),
      crossPaint,
    );
    canvas.drawLine(
      Offset(cx, cy - 20),
      Offset(cx, cy + 20),
      crossPaint,
    );

    for (final point in sphereGrid) {
      // Compute angular difference from current orientation
      final relYaw = _angleDiff(point.yaw, currentYaw);
      final relPitch = point.pitch - currentPitch;

      // Signed yaw difference (for left/right placement)
      final signedYaw = _signedAngleDiff(point.yaw, currentYaw);

      // FOV culling — skip points outside visible cone (with margin)
      const cullMargin = 15.0;
      if (relYaw.abs() > halfFov + cullMargin ||
          relPitch.abs() > halfFov + cullMargin) {
        continue;
      }

      // Project to screen coordinates
      // signedYaw > 0 means point is to the right of where camera looks
      final screenX = cx + (signedYaw / halfFov) * (size.width / 2);
      final screenY = cy - (relPitch / halfFov) * (size.height / 2);

      final isCaptured = capturedIndices.contains(point.index);
      final isAligned = point.index == alignedIndex;

      // Dot size — larger when closer to center, smaller at edges
      final distFromCenter = sqrt(relYaw * relYaw + relPitch * relPitch);
      var baseRadius = _lerp(10.0, 5.0, (distFromCenter / halfFov).clamp(0, 1));

      if (isAligned) {
        baseRadius *= pulseScale;
      }

      // Color coding
      Color dotColor;
      if (isCaptured) {
        dotColor = Colors.greenAccent;
      } else if (isAligned) {
        dotColor = Colors.yellowAccent;
      } else {
        dotColor = Colors.white.withValues(alpha: 0.5);
      }

      // Outer glow for aligned dot
      if (isAligned) {
        final glowPaint = Paint()
          ..color = Colors.yellowAccent.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
        canvas.drawCircle(
          Offset(screenX, screenY),
          baseRadius * 1.5,
          glowPaint,
        );
      }

      // Draw dot
      final dotPaint = Paint()
        ..color = dotColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(screenX, screenY), baseRadius, dotPaint);

      // Ring around captured dots
      if (isCaptured) {
        final ringPaint = Paint()
          ..color = Colors.greenAccent.withValues(alpha: 0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawCircle(
          Offset(screenX, screenY),
          baseRadius + 3,
          ringPaint,
        );
      }
    }
  }

  /// Unsigned shortest angular distance (0..180).
  double _angleDiff(double a, double b) {
    final diff = (a - b).abs() % 360;
    return diff > 180 ? 360 - diff : diff;
  }

  /// Signed shortest angular distance (-180..180).
  /// Positive means [target] is clockwise from [current].
  double _signedAngleDiff(double target, double current) {
    var diff = (target - current) % 360;
    if (diff > 180) diff -= 360;
    if (diff < -180) diff += 360;
    return diff;
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(covariant SphereGuidancePainter oldDelegate) =>
      currentYaw != oldDelegate.currentYaw ||
      currentPitch != oldDelegate.currentPitch ||
      capturedIndices.length != oldDelegate.capturedIndices.length ||
      alignedIndex != oldDelegate.alignedIndex ||
      pulseScale != oldDelegate.pulseScale;
}
