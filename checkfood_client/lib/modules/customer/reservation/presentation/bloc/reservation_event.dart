import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_event.freezed.dart';

@freezed
class ReservationEvent with _$ReservationEvent {
  const factory ReservationEvent.loadScene({
    required String restaurantId,
  }) = LoadScene;

  const factory ReservationEvent.loadStatuses({
    required String date,
  }) = LoadStatuses;

  const factory ReservationEvent.selectTable({
    required String tableId,
    required String label,
    required int capacity,
  }) = SelectTable;

  const factory ReservationEvent.changeDate({
    required String date,
  }) = ChangeDate;

  const factory ReservationEvent.selectTime({
    required String startTime,
  }) = SelectTime;

  const factory ReservationEvent.changePartySize({
    required int partySize,
  }) = ChangePartySize;

  const factory ReservationEvent.submitReservation() = SubmitReservation;
}
