import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/staff_reservation.dart';

/// Karta zobrazující jednu rezervaci viditelnou personálem s barevným levým
/// okrajem indikujícím stav, časové rozmezí, počet hostů a kontextová tlačítka akcí.
class StaffReservationCard extends StatelessWidget {
  final StaffReservation reservation;
  final bool isActionInProgress;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final VoidCallback? onCheckIn;
  final VoidCallback? onComplete;

  const StaffReservationCard({
    super.key,
    required this.reservation,
    this.isActionInProgress = false,
    this.onConfirm,
    this.onReject,
    this.onCheckIn,
    this.onComplete,
  });

  Color get _borderColor {
    switch (reservation.status) {
      case 'PENDING_CONFIRMATION':
        return AppColors.warning;
      case 'CONFIRMED':
      case 'RESERVED':
        return AppColors.success;
      case 'CHECKED_IN':
        return AppColors.info;
      case 'CANCELLED':
      case 'REJECTED':
        return AppColors.error;
      case 'COMPLETED':
        return AppColors.textMuted;
      default:
        return AppColors.textMuted;
    }
  }

  String _statusLabel(BuildContext context) {
    final l = S.of(context);
    switch (reservation.status) {
      case 'PENDING_CONFIRMATION':
        return l.statusWaiting;
      case 'CONFIRMED':
        return l.statusConfirmed;
      case 'RESERVED':
        return l.statusReserved;
      case 'CHECKED_IN':
        return l.statusCheckedIn;
      case 'CANCELLED':
        return l.statusCancelled;
      case 'REJECTED':
        return l.statusRejected;
      case 'COMPLETED':
        return l.statusCompleted;
      default:
        return reservation.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final timeRange = reservation.endTime != null
        ? '${reservation.startTime.substring(0, 5)} - ${reservation.endTime!.substring(0, 5)}'
        : l.timeFrom(reservation.startTime.substring(0, 5));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: _borderColor, width: 4),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    reservation.tableLabel,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _borderColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _statusLabel(context),
                    style: TextStyle(
                      color: _borderColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text(timeRange,
                    style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                const SizedBox(width: 16),
                const Icon(Icons.people, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text('${reservation.partySize}',
                    style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
              ],
            ),
            const SizedBox(height: 8),

            if (_hasActions) _buildActions(context),
          ],
        ),
      ),
    );
  }

  bool get _hasActions =>
      reservation.canConfirm ||
      reservation.canReject ||
      reservation.canCheckIn ||
      reservation.canComplete;

  Widget _buildActions(BuildContext context) {
    if (isActionInProgress) {
      return const Padding(
        padding: EdgeInsets.only(top: 4),
        child: Center(child: SizedBox(
          width: 20, height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )),
      );
    }

    return Wrap(
      spacing: 8,
      children: [
        if (reservation.canConfirm)
          FilledButton.tonal(
            onPressed: onConfirm,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.successLight,
              foregroundColor: AppColors.success,
            ),
            child: Text(S.of(context).confirm),
          ),
        if (reservation.canReject)
          FilledButton.tonal(
            onPressed: onReject,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.errorLight,
              foregroundColor: AppColors.error,
            ),
            child: Text(S.of(context).reject),
          ),
        if (reservation.canCheckIn)
          FilledButton.tonal(
            onPressed: onCheckIn,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.infoLight,
              foregroundColor: AppColors.info,
            ),
            child: Text(S.of(context).checkIn),
          ),
        if (reservation.canComplete)
          FilledButton.tonal(
            onPressed: onComplete,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.borderLight,
              foregroundColor: AppColors.textSecondary,
            ),
            child: Text(S.of(context).complete),
          ),
      ],
    );
  }
}
