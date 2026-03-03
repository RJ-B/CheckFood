import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/reservation_scene.dart';
import '../bloc/my_reservations_bloc.dart';
import '../bloc/my_reservations_event.dart';
import '../bloc/my_reservations_state.dart';

class EditReservationSheet extends StatelessWidget {
  const EditReservationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyReservationsBloc, MyReservationsState>(
      listener: (context, state) {
        if (state.editSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final reservation = state.editingReservation;
        if (reservation == null) return const SizedBox.shrink();

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Upravit rezervaci',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  reservation.restaurantName ?? '',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),

                // Date picker
                _DatePickerField(
                  selectedDate: state.editSelectedDate ?? reservation.date,
                  onDateChanged: (date) => context
                      .read<MyReservationsBloc>()
                      .add(MyReservationsEvent.editDateChanged(date: date)),
                ),
                const SizedBox(height: 16),

                // Table picker
                if (state.editTables.isNotEmpty) ...[
                  _TablePicker(
                    tables: state.editTables,
                    selectedTableId:
                        state.editSelectedTableId ?? reservation.tableId,
                    onTableChanged: (tableId) => context
                        .read<MyReservationsBloc>()
                        .add(MyReservationsEvent.editTableChanged(
                            tableId: tableId)),
                  ),
                  const SizedBox(height: 16),
                ],

                // Party size
                _PartySizePicker(
                  partySize: state.editPartySize ?? reservation.partySize,
                  onChanged: (size) => context
                      .read<MyReservationsBloc>()
                      .add(MyReservationsEvent.editPartySizeChanged(
                          partySize: size)),
                ),
                const SizedBox(height: 16),

                // Time slots
                const Text(
                  'Dostupné časy',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                if (state.isLoadingEditSlots)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.editSlots != null &&
                    state.editSlots!.availableStartTimes.isNotEmpty)
                  _TimeSlotsGrid(
                    slots: state.editSlots!.availableStartTimes,
                    selectedTime: state.editSelectedTime,
                    onTimeSelected: (time) => context
                        .read<MyReservationsBloc>()
                        .add(MyReservationsEvent.editTimeSelected(
                            startTime: time)),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Žádné volné termíny pro tento den.',
                      style: TextStyle(color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 16),

                // Error messages
                if (state.editConflict)
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Termín už není volný. Vyberte jiný čas.',
                      style: TextStyle(color: Colors.orange, fontSize: 13),
                    ),
                  ),
                if (state.editError != null)
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      state.editError!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),

                // Submit button
                ElevatedButton(
                  onPressed: state.canSubmitEdit
                      ? () => context
                          .read<MyReservationsBloc>()
                          .add(const MyReservationsEvent.submitEdit())
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: state.isSubmittingEdit
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Uložit změny'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Date Picker ──────────────────────────────────────────────────────────

class _DatePickerField extends StatelessWidget {
  final String selectedDate;
  final ValueChanged<String> onDateChanged;

  const _DatePickerField({
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(selectedDate) ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 60)),
          locale: const Locale('cs', 'CZ'),
        );
        if (picked != null) {
          onDateChanged(picked.toIso8601String().substring(0, 10));
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Datum',
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(_formatDate(selectedDate)),
      ),
    );
  }

  String _formatDate(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length != 3) return isoDate;
    return '${parts[2]}.${parts[1]}.${parts[0]}';
  }
}

// ── Table Picker ─────────────────────────────────────────────────────────

class _TablePicker extends StatelessWidget {
  final List<SceneTable> tables;
  final String selectedTableId;
  final ValueChanged<String> onTableChanged;

  const _TablePicker({
    required this.tables,
    required this.selectedTableId,
    required this.onTableChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Stůl',
        prefixIcon: const Icon(Icons.table_restaurant),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedTableId,
          isExpanded: true,
          isDense: true,
          items: tables
              .map((t) => DropdownMenuItem(
                    value: t.tableId,
                    child: Text('${t.label} (${t.capacity} míst)'),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onTableChanged(value);
          },
        ),
      ),
    );
  }
}

// ── Party Size Picker ────────────────────────────────────────────────────

class _PartySizePicker extends StatelessWidget {
  final int partySize;
  final ValueChanged<int> onChanged;

  const _PartySizePicker({
    required this.partySize,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Počet osob',
        prefixIcon: const Icon(Icons.people),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: partySize > 1 ? () => onChanged(partySize - 1) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$partySize',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: partySize < 20 ? () => onChanged(partySize + 1) : null,
          ),
        ],
      ),
    );
  }
}

// ── Time Slots Grid ──────────────────────────────────────────────────────

class _TimeSlotsGrid extends StatelessWidget {
  final List<String> slots;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const _TimeSlotsGrid({
    required this.slots,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: slots.map((time) {
        final isSelected = time == selectedTime;
        final displayTime = _formatTime(time);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: ChoiceChip(
            label: Text(displayTime),
            selected: isSelected,
            onSelected: (_) => onTimeSelected(time),
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : null,
              fontWeight: isSelected ? FontWeight.w600 : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  String _formatTime(String time) {
    final parts = time.split(':');
    if (parts.length >= 2) return '${parts[0]}:${parts[1]}';
    return time;
  }
}
