import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/reservation.dart';

part 'my_reservations_event.freezed.dart';

@freezed
class MyReservationsEvent with _$MyReservationsEvent {
  const factory MyReservationsEvent.load() = LoadMyReservations;
  const factory MyReservationsEvent.refresh() = RefreshMyReservations;
  const factory MyReservationsEvent.showAllHistory() = ShowAllHistory;
  const factory MyReservationsEvent.cancel({required String reservationId}) = CancelReservation;

  const factory MyReservationsEvent.startEdit({required Reservation reservation}) = StartEditReservation;
  const factory MyReservationsEvent.editDateChanged({required String date}) = EditDateChanged;
  const factory MyReservationsEvent.editTableChanged({required String tableId}) = EditTableChanged;
  const factory MyReservationsEvent.editTimeSelected({required String startTime}) = EditTimeSelected;
  const factory MyReservationsEvent.editPartySizeChanged({required int partySize}) = EditPartySizeChanged;
  const factory MyReservationsEvent.submitEdit() = SubmitEditReservation;

  const factory MyReservationsEvent.loadPendingChanges() = LoadPendingChanges;
  const factory MyReservationsEvent.acceptChangeRequest({required String changeRequestId}) = AcceptChangeRequest;
  const factory MyReservationsEvent.declineChangeRequest({required String changeRequestId}) = DeclineChangeRequest;

  const factory MyReservationsEvent.createRecurring({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    required int partySize,
  }) = CreateRecurringReservation;
  const factory MyReservationsEvent.loadRecurring() = LoadRecurringReservations;
  const factory MyReservationsEvent.cancelRecurring({required String id}) = CancelRecurringReservation;
}
