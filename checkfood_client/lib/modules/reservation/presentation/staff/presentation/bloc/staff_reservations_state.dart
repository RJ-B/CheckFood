import '../../domain/entities/staff_reservation.dart';
import '../../domain/entities/staff_table.dart';

/// Immutable stav [StaffReservationsBloc] obsahující seznam rezervací,
/// vybraný datum, dostupné stoly a sledování průběhu jednotlivých akcí.
class StaffReservationsState {
  final bool isLoading;
  final String? error;
  final String selectedDate;
  final String? restaurantId;
  final List<StaffReservation> reservations;
  final List<StaffTable> tables;
  final String? actionInProgressId;
  final String? actionError;

  const StaffReservationsState({
    this.isLoading = false,
    this.error,
    required this.selectedDate,
    this.restaurantId,
    this.reservations = const [],
    this.tables = const [],
    this.actionInProgressId,
    this.actionError,
  });

  StaffReservationsState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    String? selectedDate,
    String? restaurantId,
    List<StaffReservation>? reservations,
    List<StaffTable>? tables,
    String? actionInProgressId,
    bool clearActionInProgress = false,
    String? actionError,
    bool clearActionError = false,
  }) {
    return StaffReservationsState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedDate: selectedDate ?? this.selectedDate,
      restaurantId: restaurantId ?? this.restaurantId,
      reservations: reservations ?? this.reservations,
      tables: tables ?? this.tables,
      actionInProgressId: clearActionInProgress
          ? null
          : (actionInProgressId ?? this.actionInProgressId),
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }
}
