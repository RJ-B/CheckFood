import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../utils/marker_animation_controller.dart';

/// Overlay kreslící animované kruhy markerů během přechodů cluster↔individuální.
class MarkerAnimationOverlay extends StatelessWidget {
  final List<MarkerTransition> transitions;
  final double progress;
  final bool isExpanding;

  const MarkerAnimationOverlay({
    super.key,
    required this.transitions,
    required this.progress,
    required this.isExpanding,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _MarkerAnimationPainter(
          transitions: transitions,
          progress: progress,
          isExpanding: isExpanding,
        ),
      ),
    );
  }
}

/// Custom painter kreslící animované kruhy pro každý probíhající [MarkerTransition]
/// při rozbalování nebo sbalování cluster markerů na mapě.
class _MarkerAnimationPainter extends CustomPainter {
  final List<MarkerTransition> transitions;
  final double progress;
  final bool isExpanding;

  static const _curve = Curves.easeOutCubic;

  _MarkerAnimationPainter({
    required this.transitions,
    required this.progress,
    required this.isExpanding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final t = _curve.transform(progress);

    for (final tr in transitions) {
      final pos = tr.positionAt(t);

      final scale = isExpanding
          ? 0.2 + 0.8 * t
          : 1.0 - 0.8 * t;

      final opacity = isExpanding
          ? (t * 1.5).clamp(0.0, 1.0)
          : (1.0 - t).clamp(0.0, 1.0);

      final radius = (tr.size / 2) * scale;
      if (radius < 1 || opacity < 0.05) continue;

      canvas.drawCircle(
        pos + const Offset(0, 2),
        radius,
        Paint()
          ..color = Colors.black.withValues(alpha: 0.15 * opacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );

      canvas.drawCircle(
        pos,
        radius,
        Paint()..color = AppColors.brandDark.withValues(alpha: opacity),
      );

      canvas.drawCircle(
        pos,
        radius - 1.5,
        Paint()
          ..color = Colors.white.withValues(alpha: opacity * 0.9)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );

      if (scale > 0.4 && tr.label.isNotEmpty) {
        final fontSize = (radius * 0.75).clamp(6.0, 16.0);
        final textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: tr.label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white.withValues(alpha: opacity),
            ),
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            pos.dx - textPainter.width / 2,
            pos.dy - textPainter.height / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_MarkerAnimationPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
