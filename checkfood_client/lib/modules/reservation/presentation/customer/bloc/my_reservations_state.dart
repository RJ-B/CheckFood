import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/available_slots.dart';
import '../../../domain/entities/pending_change.dart';
import '../../../domain/entities/recurring_reservation.dart';
import '../../../domain/entities/reservation.dart';
import '../../../domain/entities/reservation_scene.dart';

part 'my_reservations_state.freezed.dart';

@freezed
class MyReservationsState with _$MyReservationsState {
  const MyReservationsState._();

  const factory MyReservationsState({
    @Default(true) bool isLoading,
    String? loadError,
    @Default([]) List<Reservation> upcoming,
    @Default([]) List<Reservation> history,
    @Default(0) int totalHistoryCount,
    @Default(false) bool showingAllHistory,
    @Default(false) bool isLoadingHistory,
    @Default([]) List<PendingChange> pendingChanges,
    String? pendingChangeActionId,
    String? cancellingId,
    @Default(false) bool cancelSuccess,
    Reservation? editingReservation,
    @Default([]) List<SceneTable> editTables,
    @Default(false) bool isLoadingEditSlots,
    AvailableSlots? editSlots,
    String? editSelectedTableId,
    String? editSelectedDate,
    String? editSelectedTime,
    int? editPartySize,
    @Default(false) bool isSubmittingEdit,
    @Default(false) bool editSuccess,
    @Default(false) bool editConflict,
    String? editError,
    @Default([]) List<RecurringReservation> recurringReservations,
    @Default(false) bool isLoadingRecurring,
    @Default(false) bool recurringSuccess,
  }) = _MyReservationsState;

  bool get canSubmitEdit =>
      editingReservation != null &&
      editSelectedTableId != null &&
      editSelectedDate != null &&
      editSelectedTime != null &&
      editPartySize != null &&
      !isSubmittingEdit;
}
