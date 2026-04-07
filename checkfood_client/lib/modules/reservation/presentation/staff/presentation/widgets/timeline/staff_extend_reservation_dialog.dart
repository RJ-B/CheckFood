import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/theme/colors.dart';
import '../../../../../../../l10n/generated/app_localizations.dart';
import '../../../domain/entities/staff_reservation.dart';
import '../../bloc/staff_reservations_bloc.dart';
import '../../bloc/staff_reservations_event.dart';

/// Dialog umožňující personálu vybrat nový čas konce a odeslat event
/// [ExtendReservation] pro prodloužení aktivní rezervace.
class StaffExtendReservationDialog extends StatefulWidget {
  final StaffReservation reservation;

  const StaffExtendReservationDialog({
    super.key,
    required this.reservation,
  });

  @override
  State<StaffExtendReservationDialog> createState() =>
      _StaffExtendReservationDialogState();
}

class _StaffExtendReservationDialogState
    extends State<StaffExtendReservationDialog> {
  TimeOfDay? _selectedEndTime;

  String _formatTimeOfDay(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);

    return AlertDialog(
      title: Text(l.extendReservation),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.extendInfo,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Text(l.newEndTime,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final initial = _selectedEndTime ??
                  const TimeOfDay(hour: 22, minute: 0);
              final picked = await showTimePicker(
                context: context,
                initialTime: initial,
                builder: (ctx, child) => MediaQuery(
                  data: MediaQuery.of(ctx)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                ),
              );
              if (picked != null) {
                setState(() => _selectedEndTime = picked);
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 18, color: AppColors.textMuted),
                  const SizedBox(width: 8),
                  Text(
                    _selectedEndTime != null
                        ? _formatTimeOfDay(_selectedEndTime!)
                        : l.selectTime,
                    style: TextStyle(
                      color: _selectedEndTime != null
                          ? AppColors.textPrimary
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.cancel),
        ),
        FilledButton(
          onPressed: _selectedEndTime == null
              ? null
              : () {
                  context.read<StaffReservationsBloc>().add(
                        ExtendReservation(
                          widget.reservation.id,
                          _formatTimeOfDay(_selectedEndTime!),
                        ),
                      );
                  Navigator.pop(context);
                },
          child: Text(l.extendReservation),
        ),
      ],
    );
  }
}
