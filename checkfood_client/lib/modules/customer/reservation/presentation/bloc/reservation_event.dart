import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_event.freezed.dart';

@freezed
class ReservationEvent with _$ReservationEvent {
  /// Load panorama scene + tables for a restaurant
  const factory ReservationEvent.loadScene({
    required String restaurantId,
  }) = LoadScene;

  /// Load table statuses for the selected date
  const factory ReservationEvent.loadStatuses({
    required String date,
  }) = LoadStatuses;

  /// User tapped a table marker in the panorama
  const factory ReservationEvent.selectTable({
    required String tableId,
    required String label,
    required int capacity,
  }) = SelectTable;

  /// User changed the reservation date
  const factory ReservationEvent.changeDate({
    required String date,
  }) = ChangeDate;

  /// User selected a start time slot
  const factory ReservationEvent.selectTime({
    required String startTime,
  }) = SelectTime;

  /// User changed the party size
  const factory ReservationEvent.changePartySize({
    required int partySize,
  }) = ChangePartySize;

  /// User confirmed the reservation
  const factory ReservationEvent.submitReservation() = SubmitReservation;
}
