import 'package:flutter/material.dart';

import '../../domain/entities/staff_reservation.dart';

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
        return Colors.orange;
      case 'CONFIRMED':
      case 'RESERVED':
        return Colors.green;
      case 'CHECKED_IN':
        return Colors.blue;
      case 'CANCELLED':
      case 'REJECTED':
        return Colors.red;
      case 'COMPLETED':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String get _statusLabel {
    switch (reservation.status) {
      case 'PENDING_CONFIRMATION':
        return 'Cekajici';
      case 'CONFIRMED':
        return 'Potvrzeno';
      case 'RESERVED':
        return 'Rezervovano';
      case 'CHECKED_IN':
        return 'Pritomen';
      case 'CANCELLED':
        return 'Zruseno';
      case 'REJECTED':
        return 'Odmitnuto';
      case 'COMPLETED':
        return 'Dokonceno';
      default:
        return reservation.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeRange = reservation.endTime != null
        ? '${reservation.startTime.substring(0, 5)} - ${reservation.endTime!.substring(0, 5)}'
        : 'od ${reservation.startTime.substring(0, 5)}';

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
            // Header: table label + status badge
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
                    color: _borderColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _statusLabel,
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

            // Time + party size
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(timeRange,
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
                const SizedBox(width: 16),
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${reservation.partySize}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 8),

            // Action buttons
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
              backgroundColor: Colors.green.shade50,
              foregroundColor: Colors.green.shade700,
            ),
            child: const Text('Potvrdit'),
          ),
        if (reservation.canReject)
          FilledButton.tonal(
            onPressed: onReject,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red.shade700,
            ),
            child: const Text('Odmitnout'),
          ),
        if (reservation.canCheckIn)
          FilledButton.tonal(
            onPressed: onCheckIn,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.blue.shade700,
            ),
            child: const Text('Check-in'),
          ),
        if (reservation.canComplete)
          FilledButton.tonal(
            onPressed: onComplete,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.grey.shade700,
            ),
            child: const Text('Dokoncit'),
          ),
      ],
    );
  }
}
