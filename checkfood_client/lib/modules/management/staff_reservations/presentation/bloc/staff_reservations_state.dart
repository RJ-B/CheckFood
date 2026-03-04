import '../../domain/entities/staff_reservation.dart';

class StaffReservationsState {
  final bool isLoading;
  final String? error;
  final String selectedDate;
  final List<StaffReservation> reservations;
  final String? actionInProgressId;
  final String? actionError;

  const StaffReservationsState({
    this.isLoading = false,
    this.error,
    required this.selectedDate,
    this.reservations = const [],
    this.actionInProgressId,
    this.actionError,
  });

  StaffReservationsState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    String? selectedDate,
    List<StaffReservation>? reservations,
    String? actionInProgressId,
    bool clearActionInProgress = false,
    String? actionError,
    bool clearActionError = false,
  }) {
    return StaffReservationsState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedDate: selectedDate ?? this.selectedDate,
      reservations: reservations ?? this.reservations,
      actionInProgressId: clearActionInProgress
          ? null
          : (actionInProgressId ?? this.actionInProgressId),
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }
}
