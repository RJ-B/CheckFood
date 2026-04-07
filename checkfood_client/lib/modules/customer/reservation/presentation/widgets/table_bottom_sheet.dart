import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/colors.dart';

import '../../presentation/bloc/reservation_bloc.dart';
import '../../presentation/bloc/reservation_event.dart';
import '../../presentation/bloc/reservation_state.dart';
import '../../../../../../l10n/generated/app_localizations.dart';

/// Bottom sheet shown after a table is tapped in the panorama view,
/// allowing the user to select a time slot and party size before confirming the reservation.
class TableBottomSheet extends StatelessWidget {
  const TableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        final l = S.of(context);
        final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.fromLTRB(20, 12, 20, 24 + bottomPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Text(
                state.selectedTableLabel ?? l.table,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (state.selectedTableCapacity != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    l.capacityOf(state.selectedTableCapacity!),
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Text(
                    l.guestsLabel,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

              Text(
                l.freeTimes,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                      l.noSlotsForDay,
                      style: const TextStyle(color: AppColors.textMuted),
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
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.border,
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
                      : Text(
                          l.confirmReservation,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              if (state.submitConflict)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    l.slotUnavailable,
                    style: const TextStyle(color: AppColors.warning, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (state.submitError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    state.submitError!,
                    style: const TextStyle(color: AppColors.error, fontSize: 13),
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

/// A wrapping grid of tappable time-slot tiles showing start times.
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
        final display = time.length > 5 ? time.substring(0, 5) : time;

        return GestureDetector(
          onTap: () => onSelected(time),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
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
