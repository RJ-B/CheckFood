import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../domain/entities/staff_reservation.dart';
import '../../../domain/entities/staff_table.dart';
import '../../bloc/staff_reservations_bloc.dart';
import '../../bloc/staff_reservations_event.dart';

/// Bottom sheet umožňující personálu navrhnout změnu času nebo stolu, nebo tiše
/// prodloužit čas konce stávající rezervace.
class StaffEditReservationSheet extends StatefulWidget {
  final StaffReservation reservation;
  final List<StaffTable> availableTables;

  const StaffEditReservationSheet({
    super.key,
    required this.reservation,
    required this.availableTables,
  });

  @override
  State<StaffEditReservationSheet> createState() =>
      _StaffEditReservationSheetState();
}

class _StaffEditReservationSheetState extends State<StaffEditReservationSheet> {
  late String _selectedStartTime;
  late String? _selectedEndTime;
  late String _selectedTableId;

  static final List<String> _timeSlots = List.generate(
    36,
    (i) {
      final hour = 6 + i ~/ 2;
      final minute = (i % 2) * 30;
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    },
  );

  @override
  void initState() {
    super.initState();
    _selectedStartTime = widget.reservation.startTime.substring(0, 5);
    _selectedEndTime = widget.reservation.endTime?.substring(0, 5);
    _selectedTableId = widget.reservation.tableId;
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).viewPadding.bottom +
            20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l.proposeChange,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            l.pendingChangeInfo,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 20),

          Text(l.newStartTime,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _timeSlots.contains(_selectedStartTime)
                ? _selectedStartTime
                : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              prefixIcon: const Icon(Icons.access_time,
                  size: 18, color: AppColors.textMuted),
            ),
            hint: Text(l.selectTime),
            items: _timeSlots
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedStartTime = val);
            },
          ),

          const SizedBox(height: 16),
          Text(l.newEndTime,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedEndTime != null &&
                    _timeSlots.contains(_selectedEndTime)
                ? _selectedEndTime
                : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              prefixIcon: const Icon(Icons.access_time,
                  size: 18, color: AppColors.textMuted),
            ),
            hint: Text(l.selectTime),
            items: _timeSlots
                .where((t) => t.compareTo(_selectedStartTime) > 0)
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (val) {
              setState(() => _selectedEndTime = val);
            },
          ),

          if (widget.availableTables.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(l.newTable,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedTableId,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              hint: Text(l.selectTable),
              items: widget.availableTables
                  .map((t) => DropdownMenuItem(
                        value: t.id,
                        child: Text('${t.label} (${t.capacity})'),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => _selectedTableId = val ?? _selectedTableId),
            ),
          ],

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _onSubmit,
              child: Text(l.proposeChange),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    final originalStart = widget.reservation.startTime.substring(0, 5);
    final originalEnd = widget.reservation.endTime?.substring(0, 5);

    final startChanged = _selectedStartTime != originalStart;
    final endChanged = _selectedEndTime != originalEnd;
    final tableChanged = _selectedTableId != widget.reservation.tableId;

    if (endChanged && !startChanged && !tableChanged && _selectedEndTime != null) {
      context.read<StaffReservationsBloc>().add(
            ExtendReservation(widget.reservation.id, _selectedEndTime!),
          );
      Navigator.pop(context);
      return;
    }

    final newTime = startChanged ? _selectedStartTime : null;
    final newTableId = tableChanged ? _selectedTableId : null;

    if (newTime == null && newTableId == null) {
      Navigator.pop(context);
      return;
    }

    context.read<StaffReservationsBloc>().add(
          ProposeChange(
            widget.reservation.id,
            startTime: newTime,
            tableId: newTableId,
          ),
        );
    Navigator.pop(context);
  }
}
