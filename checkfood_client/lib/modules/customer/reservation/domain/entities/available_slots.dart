import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_slots.freezed.dart';

@freezed
class AvailableSlots with _$AvailableSlots {
  const factory AvailableSlots({
    required String date,
    required String tableId,
    required int slotMinutes,
    required int durationMinutes,
    required List<String> availableStartTimes,
  }) = _AvailableSlots;
}
