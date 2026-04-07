import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/usecases/get_staff_reservations_usecase.dart';
import '../../domain/usecases/confirm_reservation_usecase.dart';
import '../../domain/usecases/reject_reservation_usecase.dart';
import '../../domain/usecases/check_in_reservation_usecase.dart';
import '../../domain/usecases/complete_reservation_usecase.dart';
import '../../domain/usecases/get_restaurant_tables_usecase.dart';
import '../../domain/usecases/propose_change_usecase.dart';
import '../../domain/usecases/extend_reservation_usecase.dart';
import 'staff_reservations_event.dart';
import 'staff_reservations_state.dart';

/// BLoC that manages the staff reservation list: loading reservations for a
/// selected date, confirming, rejecting, checking in, completing, proposing
/// changes, extending reservations, and periodic background polling.
class StaffReservationsBloc
    extends Bloc<StaffReservationsEvent, StaffReservationsState> {
  final GetStaffReservationsUseCase _getReservations;
  final ConfirmReservationUseCase _confirm;
  final RejectReservationUseCase _reject;
  final CheckInReservationUseCase _checkIn;
  final CompleteReservationUseCase _complete;
  final GetRestaurantTablesUseCase _getTables;
  final ProposeChangeUseCase _proposeChange;
  final ExtendReservationUseCase _extendReservation;

  Timer? _pollTimer;

  StaffReservationsBloc({
    required GetStaffReservationsUseCase getReservations,
    required ConfirmReservationUseCase confirm,
    required RejectReservationUseCase reject,
    required CheckInReservationUseCase checkIn,
    required CompleteReservationUseCase complete,
    required GetRestaurantTablesUseCase getTables,
    required ProposeChangeUseCase proposeChange,
    required ExtendReservationUseCase extendReservation,
  })  : _getReservations = getReservations,
        _confirm = confirm,
        _reject = reject,
        _checkIn = checkIn,
        _complete = complete,
        _getTables = getTables,
        _proposeChange = proposeChange,
        _extendReservation = extendReservation,
        super(StaffReservationsState(
          selectedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        )) {
    on<LoadStaffReservations>(_onLoad);
    on<ChangeDate>(_onChangeDate);
    on<ConfirmReservation>(_onConfirm);
    on<RejectReservation>(_onReject);
    on<CheckInReservation>(_onCheckIn);
    on<CompleteReservation>(_onComplete);
    on<PollRefresh>(_onPollRefresh);
    on<LoadTables>(_onLoadTables);
    on<ProposeChange>(_onProposeChange);
    on<ExtendReservation>(_onExtendReservation);
  }

  void startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => add(const PollRefresh()),
    );
  }

  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoad(
      LoadStaffReservations event, Emitter<StaffReservationsState> emit) async {
    final rid = event.restaurantId ?? state.restaurantId;
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
      restaurantId: rid,
    ));
    try {
      final reservations = await _getReservations(event.date, restaurantId: rid);
      emit(state.copyWith(
        isLoading: false,
        reservations: reservations,
        selectedDate: event.date,
      ));
      if (state.tables.isEmpty || event.restaurantId != null) {
        add(const LoadTables());
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
      if (state.tables.isEmpty) {
        add(const LoadTables());
      }
    }
  }

  Future<void> _onChangeDate(
      ChangeDate event, Emitter<StaffReservationsState> emit) async {
    if (event.date == state.selectedDate) return;
    emit(state.copyWith(selectedDate: event.date, isLoading: true, clearError: true));
    try {
      final reservations = await _getReservations(event.date, restaurantId: state.restaurantId);
      emit(state.copyWith(isLoading: false, reservations: reservations));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onConfirm(
      ConfirmReservation event, Emitter<StaffReservationsState> emit) async {
    emit(state.copyWith(actionInProgressId: event.id, clearActionError: true));
    try {
      await _confirm(event.id);
      final reservations = await _getReservations(state.selectedDate, restaurantId: state.restaurantId);
      emit(state.copyWith(
          reservations: reservations, clearActionInProgress: true));
    } catch (e) {
      emit(state.copyWith(
          actionError: e.toString(), clearActionInProgress: true));
    }
  }

  Future<void> _onReject(
      RejectReservation event, Emitter<StaffReservationsState> emit) async {
    emit(state.copyWith(actionInProgressId: event.id, clearActionError: true));
    try {
      await _reject(event.id);
      final reservations = await _getReservations(state.selectedDate, restaurantId: state.restaurantId);
      emit(state.copyWith(
          reservations: reservations, clearActionInProgress: true));
    } catch (e) {
      emit(state.copyWith(
          actionError: e.toString(), clearActionInProgress: true));
    }
  }

  Future<void> _onCheckIn(
      CheckInReservation event, Emitter<StaffReservationsState> emit) async {
    emit(state.copyWith(actionInProgressId: event.id, clearActionError: true));
    try {
      await _checkIn(event.id);
      final reservations = await _getReservations(state.selectedDate, restaurantId: state.restaurantId);
      emit(state.copyWith(
          reservations: reservations, clearActionInProgress: true));
    } catch (e) {
      emit(state.copyWith(
          actionError: e.toString(), clearActionInProgress: true));
    }
  }

  Future<void> _onComplete(
      CompleteReservation event, Emitter<StaffReservationsState> emit) async {
    emit(state.copyWith(actionInProgressId: event.id, clearActionError: true));
    try {
      await _complete(event.id);
      final reservations = await _getReservations(state.selectedDate, restaurantId: state.restaurantId);
      emit(state.copyWith(
          reservations: reservations, clearActionInProgress: true));
    } catch (e) {
      emit(state.copyWith(
          actionError: e.toString(), clearActionInProgress: true));
    }
  }

  Future<void> _onPollRefresh(
      PollRefresh event, Emitter<StaffReservationsState> emit) async {
    try {
      final reservations = await _getReservations(state.selectedDate, restaurantId: state.restaurantId);
      emit(state.copyWith(reservations: reservations, clearActionError: true));
    } catch (_) {}
  }

  Future<void> _onLoadTables(
      LoadTables event, Emitter<StaffReservationsState> emit) async {
    try {
      final tables = await _getTables(restaurantId: state.restaurantId);
      emit(state.copyWith(tables: tables));
    } catch (_) {}
  }

  Future<void> _onProposeChange(
      ProposeChange event, Emitter<StaffReservationsState> emit) async {
    emit(state.copyWith(actionInProgressId: event.reservationId, clearActionError: true));
    try {
      await _proposeChange(event.reservationId, startTime: event.startTime, tableId: event.tableId);
      final reservations = await _getReservations(state.selectedDate, restaurantId: state.restaurantId);
      emit(state.copyWith(reservations: reservations, clearActionInProgress: true));
    } catch (e) {
      emit(state.copyWith(actionError: e.toString(), clearActionInProgress: true));
    }
  }

  Future<void> _onExtendReservation(
      ExtendReservation event, Emitter<StaffReservationsState> emit) async {
    emit(state.copyWith(actionInProgressId: event.reservationId, clearActionError: true));
    try {
      await _extendReservation(event.reservationId, event.endTime);
      final reservations = await _getReservations(state.selectedDate, restaurantId: state.restaurantId);
      emit(state.copyWith(reservations: reservations, clearActionInProgress: true));
    } catch (e) {
      emit(state.copyWith(actionError: e.toString(), clearActionInProgress: true));
    }
  }
}
