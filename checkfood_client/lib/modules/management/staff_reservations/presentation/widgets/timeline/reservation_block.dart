import 'package:flutter/material.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../domain/entities/staff_reservation.dart';

/// Barevný blok na timeline reprezentující jednu rezervaci, s volitelným
/// přerušovaným okrajem (pro čekající změny) a pulzující animací
/// (když probíhá akce).
class ReservationBlock extends StatelessWidget {
  final StaffReservation reservation;
  final double width;
  final double height;
  final bool isDashed;
  final bool isPulsing;
  final bool isActionInProgress;
  final VoidCallback? onTap;

  const ReservationBlock({
    super.key,
    required this.reservation,
    required this.width,
    required this.height,
    this.isDashed = false,
    this.isPulsing = false,
    this.isActionInProgress = false,
    this.onTap,
  });

  Color get _backgroundColor {
    switch (reservation.status) {
      case 'PENDING_CONFIRMATION':
        return AppColors.warning.withValues(alpha: 0.2);
      case 'CONFIRMED':
      case 'RESERVED':
        return AppColors.info.withValues(alpha: 0.2);
      case 'CHECKED_IN':
        return AppColors.success.withValues(alpha: 0.2);
      case 'COMPLETED':
        return AppColors.textMuted.withValues(alpha: 0.15);
      default:
        return AppColors.textMuted.withValues(alpha: 0.1);
    }
  }

  Color get _borderColor {
    switch (reservation.status) {
      case 'PENDING_CONFIRMATION':
        return AppColors.warning;
      case 'CONFIRMED':
      case 'RESERVED':
        return AppColors.info;
      case 'CHECKED_IN':
        return AppColors.success;
      case 'COMPLETED':
        return AppColors.textMuted;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget block = GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: isDashed
              ? null
              : Border.all(color: _borderColor, width: 1.5),
        ),
        foregroundDecoration: isDashed
            ? _DashedBorderDecoration(color: _borderColor, radius: 6)
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              reservation.userName ?? '#${reservation.userId}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _borderColor,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              '${reservation.partySize}x',
              style: TextStyle(
                fontSize: 10,
                color: _borderColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );

    if (isPulsing) {
      block = _PulsingWrapper(child: block);
    }

    return block;
  }
}

/// Obalí [child] do opakující se fade-in/fade-out animace pro indikaci probíhající akce.
class _PulsingWrapper extends StatefulWidget {
  final Widget child;
  const _PulsingWrapper({required this.child});

  @override
  State<_PulsingWrapper> createState() => _PulsingWrapperState();
}

class _PulsingWrapperState extends State<_PulsingWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.6, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }
}

/// [Decoration] kreslící přerušovaný zaoblený okraj kolem svého boxu.
class _DashedBorderDecoration extends Decoration {
  final Color color;
  final double radius;
  const _DashedBorderDecoration({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DashedBorderPainter(color: color, radius: radius);
  }
}

/// Implementace [BoxPainter] kreslící cestu přerušovaného okraje.
class _DashedBorderPainter extends BoxPainter {
  final Color color;
  final double radius;
  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final path = Path()..addRRect(rrect);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final dashEnd = (distance + 4).clamp(0.0, metric.length);
        dashPath.addPath(metric.extractPath(distance, dashEnd), Offset.zero);
        distance += 7;
      }
    }
    canvas.drawPath(dashPath, paint);
  }
}
