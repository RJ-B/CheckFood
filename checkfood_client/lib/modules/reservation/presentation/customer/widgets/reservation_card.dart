import 'package:flutter/material.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../domain/entities/pending_change.dart';
import '../../../domain/entities/reservation.dart';
import '../../../../../../l10n/generated/app_localizations.dart';

/// Karta zobrazující detaily rezervace (restaurace, stůl, datum/čas, počet hostů, stav)
/// spolu s volitelnými tlačítky pro úpravu, zrušení a opakovanou rezervaci.
/// Pokud čeká návrh změny od personálu, zobrazí nad kartou [_PendingChangeBanner].
class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final bool isCancelling;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;
  final PendingChange? pendingChange;
  final bool isPendingChangeLoading;
  final VoidCallback? onAcceptChange;
  final VoidCallback? onDeclineChange;
  final VoidCallback? onCreateRecurring;

  const ReservationCard({
    super.key,
    required this.reservation,
    required this.isCancelling,
    this.onEdit,
    this.onCancel,
    this.pendingChange,
    this.isPendingChangeLoading = false,
    this.onAcceptChange,
    this.onDeclineChange,
    this.onCreateRecurring,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final showActions = (reservation.canEdit || reservation.canCancel);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (pendingChange != null) _PendingChangeBanner(
          pendingChange: pendingChange!,
          isLoading: isPendingChangeLoading,
          onAccept: onAcceptChange,
          onDecline: onDeclineChange,
          l: l,
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reservation.restaurantName ?? l.restaurant,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _StatusChip(status: reservation.status),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.table_restaurant, size: 16, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        reservation.tableLabel ?? l.table,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.people, size: 16, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        l.partySizeShort(reservation.partySize),
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        reservation.endTime != null
                            ? '${_formatDate(reservation.date)}  ${_formatTime(reservation.startTime)} – ${_formatTime(reservation.endTime!)}'
                            : '${_formatDate(reservation.date)}  ${l.timeFrom(_formatTime(reservation.startTime))}',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                if (showActions) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (reservation.canEdit && onEdit != null)
                        TextButton.icon(
                          onPressed: onEdit,
                          icon: const Icon(Icons.edit, size: 18),
                          label: Text(l.edit),
                        ),
                      if (reservation.canCancel && onCancel != null) ...[
                        if (isCancelling)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        else
                          TextButton.icon(
                            onPressed: onCancel,
                            icon: const Icon(Icons.cancel_outlined, size: 18),
                            label: Text(l.cancel),
                            style: TextButton.styleFrom(foregroundColor: AppColors.error),
                          ),
                      ],
                      if (onCreateRecurring != null)
                        TextButton.icon(
                          onPressed: onCreateRecurring,
                          icon: const Icon(Icons.repeat, size: 18),
                          label: const Text('Opakovat'),
                          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length != 3) return isoDate;
    return '${parts[2]}.${parts[1]}.${parts[0]}';
  }

  String _formatTime(String time) {
    final parts = time.split(':');
    if (parts.length >= 2) return '${parts[0]}:${parts[1]}';
    return time;
  }
}

/// Varovný banner zobrazený nad kartou rezervace, pokud restaurace navrhla
/// změnu času nebo stolu vyžadující reakci hosta.
class _PendingChangeBanner extends StatelessWidget {
  final PendingChange pendingChange;
  final bool isLoading;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final S l;

  const _PendingChangeBanner({
    required this.pendingChange,
    required this.isLoading,
    required this.onAccept,
    required this.onDecline,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.10),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.edit_notifications_outlined,
                  size: 16, color: AppColors.warning),
              const SizedBox(width: 6),
              Text(
                l.restaurantProposesChange,
                style: const TextStyle(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          if (pendingChange.proposedStartTime != null) ...[
            const SizedBox(height: 4),
            Text(
              l.proposedNewTime(pendingChange.proposedStartTime!),
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
          if (pendingChange.proposedTableLabel != null) ...[
            const SizedBox(height: 2),
            Text(
              l.proposedNewTable(pendingChange.proposedTableLabel!),
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
          const SizedBox(height: 8),
          if (isLoading)
            const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onAccept,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    child: Text(l.acceptChange,
                        style: const TextStyle(fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDecline,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    child: Text(l.declineChange,
                        style: const TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 4),
          Text(
            l.declineWarning,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.error.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

/// Malý barevný odznak odrážející aktuální stav rezervace.
class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final (label, color) = switch (status) {
      'PENDING_CONFIRMATION' => (l.statusPending, AppColors.warning),
      'CONFIRMED' => (l.statusConfirmed, AppColors.success),
      'RESERVED' => (l.statusConfirmed, AppColors.success),
      'CANCELLED' => (l.statusCancelled, AppColors.error),
      'REJECTED' => (l.statusRejected, AppColors.error),
      'COMPLETED' => (l.statusCompleted, AppColors.textMuted),
      _ => (status, AppColors.textMuted),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
