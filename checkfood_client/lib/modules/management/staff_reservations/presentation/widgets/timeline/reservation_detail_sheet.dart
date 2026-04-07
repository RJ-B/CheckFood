import 'package:flutter/material.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../domain/entities/staff_reservation.dart';
import '../../../domain/entities/staff_table.dart';

/// Shows a dialog with the full detail of a reservation and contextual action
/// buttons (confirm, reject, check-in, edit, complete) based on backend
/// capability flags.
void showReservationDetailSheet(
  BuildContext context, {
  required StaffReservation reservation,
  required bool isActionInProgress,
  VoidCallback? onConfirm,
  VoidCallback? onReject,
  VoidCallback? onCheckIn,
  VoidCallback? onComplete,
  VoidCallback? onEdit,
  VoidCallback? onExtend,
  List<StaffTable> availableTables = const [],
}) {
  showDialog(
    context: context,
    builder: (ctx) {
      final l = S.of(ctx);
      final timeRange = reservation.endTime != null
          ? '${reservation.startTime.substring(0, 5)} – ${reservation.endTime!.substring(0, 5)}'
          : l.timeFrom(reservation.startTime.substring(0, 5));

      return AlertDialog(
        title: Row(
          children: [
            Expanded(
              child: Text(
                reservation.userName ?? 'Host #${reservation.userId}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.table_restaurant, 'Stůl', reservation.tableLabel),
                  const SizedBox(height: 8),
                  _infoRow(Icons.access_time, 'Čas', timeRange),
                  const SizedBox(height: 8),
                  _infoRow(Icons.people, 'Počet osob', '${reservation.partySize}'),
                  const SizedBox(height: 8),
                  _infoRow(Icons.info_outline, 'Stav', _statusLabel(reservation.status, l)),
                ],
              ),
            ),
            if (reservation.hasPendingChange) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.hourglass_top, size: 16, color: AppColors.warning),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l.waitingForResponse,
                        style: const TextStyle(color: AppColors.warning, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (isActionInProgress)
              const Center(child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ))
            else
              _buildActionButtons(ctx, l, reservation,
                onConfirm: onConfirm,
                onReject: onReject,
                onCheckIn: onCheckIn,
                onComplete: onComplete,
                onEdit: onEdit,
                onExtend: onExtend,
              ),
          ],
        ),
      );
    },
  );
}

Widget _infoRow(IconData icon, String label, String value) {
  return Row(
    children: [
      Icon(icon, size: 18, color: AppColors.textMuted),
      const SizedBox(width: 10),
      Text(
        '$label: ',
        style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

String _statusLabel(String status, S l) {
  switch (status) {
    case 'CONFIRMED': return 'Potvrzeno';
    case 'PENDING': return 'Čeká na potvrzení';
    case 'CHECKED_IN': return 'Přítomen';
    case 'COMPLETED': return 'Dokončeno';
    case 'CANCELLED': return 'Zrušeno';
    case 'REJECTED': return 'Zamítnuto';
    default: return status;
  }
}

Widget _buildActionButtons(
  BuildContext ctx,
  S l,
  StaffReservation reservation, {
  VoidCallback? onConfirm,
  VoidCallback? onReject,
  VoidCallback? onCheckIn,
  VoidCallback? onComplete,
  VoidCallback? onEdit,
  VoidCallback? onExtend,
}) {
  final buttons = <Widget>[];

  if (reservation.canConfirm) {
    buttons.add(_actionButton(ctx, l.confirm, AppColors.successLight, AppColors.success, () {
      Navigator.pop(ctx); onConfirm?.call();
    }));
  }
  if (reservation.canReject) {
    buttons.add(_actionButton(ctx, l.reject, AppColors.errorLight, AppColors.error, () {
      Navigator.pop(ctx); onReject?.call();
    }));
  }
  if (reservation.canCheckIn) {
    buttons.add(_actionButton(ctx, l.checkIn, AppColors.infoLight, AppColors.info, () {
      Navigator.pop(ctx); onCheckIn?.call();
    }));
  }
  if (reservation.canEdit) {
    buttons.add(_actionButton(ctx, l.editReservation, AppColors.primary.withValues(alpha: 0.12), AppColors.primary, () {
      Navigator.pop(ctx); onEdit?.call();
    }));
  }
  if (reservation.canComplete) {
    buttons.add(_actionButton(ctx, l.complete, AppColors.borderLight, AppColors.textSecondary, () {
      Navigator.pop(ctx); onComplete?.call();
    }));
  }

  if (buttons.isEmpty) return const SizedBox.shrink();

  final rows = <Widget>[];
  for (var i = 0; i < buttons.length; i += 2) {
    if (i + 1 < buttons.length) {
      rows.add(Row(
        children: [
          Expanded(child: buttons[i]),
          const SizedBox(width: 8),
          Expanded(child: buttons[i + 1]),
        ],
      ));
    } else {
      rows.add(buttons[i]);
    }
    if (i + 2 < buttons.length) rows.add(const SizedBox(height: 8));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: rows,
  );
}

Widget _actionButton(BuildContext ctx, String label, Color bg, Color fg, VoidCallback onPressed) {
  return FilledButton.tonal(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: fg,
      padding: const EdgeInsets.symmetric(vertical: 12),
    ),
    child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
  );
}
