import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/available_slots.dart';
import '../../domain/entities/reservation_scene.dart';
import '../../domain/entities/table_status.dart';

part 'reservation_state.freezed.dart';

@freezed
class ReservationState with _$ReservationState {
  const ReservationState._();

  const factory ReservationState({
    // Scene
    @Default(false) bool sceneLoading,
    ReservationScene? scene,
    String? sceneError,

    // Statuses
    @Default([]) List<TableStatus> tableStatuses,

    // Selection
    String? selectedTableId,
    String? selectedTableLabel,
    int? selectedTableCapacity,
    required String selectedDate,

    // Party size
    @Default(2) int selectedPartySize,

    // Slots
    @Default(false) bool slotsLoading,
    AvailableSlots? availableSlots,
    String? selectedStartTime,

    // Submit
    @Default(false) bool submitting,
    @Default(false) bool submitSuccess,
    @Default(false) bool submitConflict,
    String? submitError,
  }) = _ReservationState;

  factory ReservationState.initial() => ReservationState(
        selectedDate: DateTime.now().toIso8601String().substring(0, 10),
      );

  bool get canSubmit =>
      selectedTableId != null &&
      selectedStartTime != null &&
      !submitting &&
      !slotsLoading;
}
