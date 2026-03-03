import 'package:flutter/material.dart';

import '../../domain/entities/reservation.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final bool isCancelling;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const ReservationCard({
    super.key,
    required this.reservation,
    required this.isCancelling,
    this.onEdit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final showActions = (reservation.canEdit || reservation.canCancel);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant name + status chip
            Row(
              children: [
                Expanded(
                  child: Text(
                    reservation.restaurantName ?? 'Restaurace',
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

            // Table + party size
            Row(
              children: [
                const Icon(Icons.table_restaurant, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  reservation.tableLabel ?? 'Stůl',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${reservation.partySize} os.',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Date + time
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${_formatDate(reservation.date)}  ${_formatTime(reservation.startTime)} – ${_formatTime(reservation.endTime)}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
              ],
            ),

            // Action buttons — driven by backend canEdit/canCancel flags
            if (showActions) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (reservation.canEdit && onEdit != null)
                    TextButton.icon(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Upravit'),
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
                        label: const Text('Zrušit'),
                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                      ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length != 3) return isoDate;
    return '${parts[2]}.${parts[1]}.${parts[0]}';
  }

  String _formatTime(String time) {
    // Remove seconds if present (e.g., "18:00:00" → "18:00")
    final parts = time.split(':');
    if (parts.length >= 2) return '${parts[0]}:${parts[1]}';
    return time;
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      'PENDING_CONFIRMATION' => ('Čeká na potvrzení', Colors.orange),
      'CONFIRMED' => ('Potvrzeno', Colors.green),
      'RESERVED' => ('Potvrzeno', Colors.green),
      'CANCELLED' => ('Zrušeno', Colors.red),
      'REJECTED' => ('Zamítnuto', Colors.red),
      'COMPLETED' => ('Dokončeno', Colors.grey),
      _ => (status, Colors.grey),
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
