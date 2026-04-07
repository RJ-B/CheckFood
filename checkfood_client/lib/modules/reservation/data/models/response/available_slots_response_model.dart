import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/available_slots.dart';

part 'available_slots_response_model.freezed.dart';
part 'available_slots_response_model.g.dart';

/// API response model nesoucí dostupné časy začátku rezervace pro konkrétní stůl a datum.
@freezed
class AvailableSlotsResponseModel with _$AvailableSlotsResponseModel {
  const AvailableSlotsResponseModel._();

  const factory AvailableSlotsResponseModel({
    String? date,
    String? tableId,
    int? slotMinutes,
    int? durationMinutes,
    @Default([]) List<String> availableStartTimes,
  }) = _AvailableSlotsResponseModel;

  factory AvailableSlotsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsResponseModelFromJson(json);

  AvailableSlots toEntity() => AvailableSlots(
        date: date ?? '',
        tableId: tableId ?? '',
        slotMinutes: slotMinutes ?? 30,
        durationMinutes: durationMinutes ?? 90,
        availableStartTimes: availableStartTimes,
      );
}
