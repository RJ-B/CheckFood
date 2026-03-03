import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/bloc/reservation_bloc.dart';
import '../../presentation/bloc/reservation_event.dart';
import '../../presentation/bloc/reservation_state.dart';

class TableBottomSheet extends StatelessWidget {
  const TableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Table header
              Text(
                state.selectedTableLabel ?? 'Stůl',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (state.selectedTableCapacity != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Kapacita: ${state.selectedTableCapacity} míst',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),

              const SizedBox(height: 16),

              // Party size selector
              Row(
                children: [
                  const Text(
                    'Počet hostů:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: state.selectedPartySize > 1
                        ? () => context
                            .read<ReservationBloc>()
                            .add(ReservationEvent.changePartySize(
                                partySize: state.selectedPartySize - 1))
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '${state.selectedPartySize}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed:
                        state.selectedPartySize < (state.selectedTableCapacity ?? 10)
                            ? () => context
                                .read<ReservationBloc>()
                                .add(ReservationEvent.changePartySize(
                                    partySize: state.selectedPartySize + 1))
                            : null,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Time slots
              const Text(
                'Volné časy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              if (state.slotsLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.availableSlots == null ||
                  state.availableSlots!.availableStartTimes.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'Žádné volné termíny pro tento den.',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                )
              else
                _TimeSlotsGrid(
                  slots: state.availableSlots!.availableStartTimes,
                  durationMinutes: state.availableSlots!.durationMinutes,
                  selectedTime: state.selectedStartTime,
                  onSelected: (time) => context
                      .read<ReservationBloc>()
                      .add(ReservationEvent.selectTime(startTime: time)),
                ),

              const SizedBox(height: 20),

              // Confirm button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: state.canSubmit
                      ? () => context
                          .read<ReservationBloc>()
                          .add(const ReservationEvent.submitReservation())
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: state.submitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Potvrdit rezervaci',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              // Error messages
              if (state.submitConflict)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Termín už není volný. Vyberte jiný čas.',
                    style: TextStyle(color: Colors.orange, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (state.submitError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    state.submitError!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ── Time Slots Grid ──────────────────────────────────────────────────────

class _TimeSlotsGrid extends StatelessWidget {
  final List<String> slots;
  final int durationMinutes;
  final String? selectedTime;
  final ValueChanged<String> onSelected;

  const _TimeSlotsGrid({
    required this.slots,
    required this.durationMinutes,
    required this.selectedTime,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: slots.map((time) {
        final isSelected = time == selectedTime;
        // Show HH:mm (strip seconds if present)
        final display = time.length > 5 ? time.substring(0, 5) : time;

        return GestureDetector(
          onTap: () => onSelected(time),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? Colors.teal : Colors.grey[300]!,
              ),
            ),
            child: Text(
              display,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
