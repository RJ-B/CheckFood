import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/cancel_reservation_usecase.dart';
import '../../domain/usecases/get_available_slots_usecase.dart';
import '../../domain/usecases/get_my_reservations_history_usecase.dart';
import '../../domain/usecases/get_my_reservations_overview_usecase.dart';
import '../../domain/usecases/get_reservation_scene_usecase.dart';
import '../../domain/usecases/update_reservation_usecase.dart';
import 'my_reservations_event.dart';
import 'my_reservations_state.dart';

class MyReservationsBloc
    extends Bloc<MyReservationsEvent, MyReservationsState> {
  final GetMyReservationsOverviewUseCase _getOverviewUseCase;
  final GetMyReservationsHistoryUseCase _getHistoryUseCase;
  final CancelReservationUseCase _cancelUseCase;
  final UpdateReservationUseCase _updateUseCase;
  final GetReservationSceneUseCase _getSceneUseCase;
  final GetAvailableSlotsUseCase _getSlotsUseCase;

  MyReservationsBloc({
    required GetMyReservationsOverviewUseCase getOverviewUseCase,
    required GetMyReservationsHistoryUseCase getHistoryUseCase,
    required CancelReservationUseCase cancelUseCase,
    required UpdateReservationUseCase updateUseCase,
    required GetReservationSceneUseCase getSceneUseCase,
    required GetAvailableSlotsUseCase getSlotsUseCase,
  })  : _getOverviewUseCase = getOverviewUseCase,
        _getHistoryUseCase = getHistoryUseCase,
        _cancelUseCase = cancelUseCase,
        _updateUseCase = updateUseCase,
        _getSceneUseCase = getSceneUseCase,
        _getSlotsUseCase = getSlotsUseCase,
        super(const MyReservationsState()) {
    on<LoadMyReservations>(_onLoad);
    on<RefreshMyReservations>(_onRefresh);
    on<ShowAllHistory>(_onShowAllHistory);
    on<CancelReservation>(_onCancel);
    on<StartEditReservation>(_onStartEdit);
    on<EditDateChanged>(_onEditDateChanged);
    on<EditTableChanged>(_onEditTableChanged);
    on<EditTimeSelected>(_onEditTimeSelected);
    on<EditPartySizeChanged>(_onEditPartySizeChanged);
    on<SubmitEditReservation>(_onSubmitEdit);
  }

  // ── Load overview ──────────────────────────────────────────────────

  Future<void> _onLoad(
    LoadMyReservations event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, loadError: null));
    try {
      final overview = await _getOverviewUseCase();
      emit(state.copyWith(
        isLoading: false,
        upcoming: overview.upcoming,
        history: overview.history,
        totalHistoryCount: overview.totalHistoryCount,
        showingAllHistory: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        loadError: 'Nepodařilo se načíst rezervace.',
      ));
    }
  }

  // ── Refresh (pull-to-refresh, no loading spinner) ──────────────────

  Future<void> _onRefresh(
    RefreshMyReservations event,
    Emitter<MyReservationsState> emit,
  ) async {
    try {
      final overview = await _getOverviewUseCase();
      emit(state.copyWith(
        upcoming: overview.upcoming,
        history: overview.history,
        totalHistoryCount: overview.totalHistoryCount,
        showingAllHistory: false,
        cancelSuccess: false,
        editSuccess: false,
      ));
    } catch (_) {
      // Silent fail on refresh
    }
  }

  // ── Show all history ───────────────────────────────────────────────

  Future<void> _onShowAllHistory(
    ShowAllHistory event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(isLoadingHistory: true));
    try {
      final allHistory = await _getHistoryUseCase();
      emit(state.copyWith(
        isLoadingHistory: false,
        history: allHistory,
        showingAllHistory: true,
      ));
    } catch (_) {
      emit(state.copyWith(isLoadingHistory: false));
    }
  }

  // ── Cancel reservation ─────────────────────────────────────────────

  Future<void> _onCancel(
    CancelReservation event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(cancellingId: event.reservationId, cancelSuccess: false));
    try {
      await _cancelUseCase(event.reservationId);
      // Reload overview after cancel
      final overview = await _getOverviewUseCase();
      emit(state.copyWith(
        cancellingId: null,
        cancelSuccess: true,
        upcoming: overview.upcoming,
        history: overview.history,
        totalHistoryCount: overview.totalHistoryCount,
        showingAllHistory: false,
      ));
    } catch (_) {
      emit(state.copyWith(cancellingId: null));
    }
  }

  // ── Start edit ─────────────────────────────────────────────────────

  Future<void> _onStartEdit(
    StartEditReservation event,
    Emitter<MyReservationsState> emit,
  ) async {
    final reservation = event.reservation;
    emit(state.copyWith(
      editingReservation: reservation,
      editSelectedTableId: reservation.tableId,
      editSelectedDate: reservation.date,
      editSelectedTime: reservation.startTime,
      editPartySize: reservation.partySize,
      editSlots: null,
      editTables: [],
      isLoadingEditSlots: true,
      isSubmittingEdit: false,
      editSuccess: false,
      editConflict: false,
      editError: null,
    ));

    try {
      // Load tables from scene
      final scene = await _getSceneUseCase(reservation.restaurantId);
      emit(state.copyWith(editTables: scene.tables));

      // Load available slots for current table+date
      final slots = await _getSlotsUseCase(
        reservation.restaurantId,
        reservation.tableId,
        reservation.date,
        excludeReservationId: reservation.id,
      );
      emit(state.copyWith(
        isLoadingEditSlots: false,
        editSlots: slots,
      ));
    } catch (_) {
      emit(state.copyWith(
        isLoadingEditSlots: false,
        editError: 'Nepodařilo se načíst data pro úpravu.',
      ));
    }
  }

  // ── Edit: date changed ─────────────────────────────────────────────

  Future<void> _onEditDateChanged(
    EditDateChanged event,
    Emitter<MyReservationsState> emit,
  ) async {
    final reservation = state.editingReservation;
    if (reservation == null) return;

    emit(state.copyWith(
      editSelectedDate: event.date,
      editSelectedTime: null,
      isLoadingEditSlots: true,
      editSlots: null,
    ));

    try {
      final slots = await _getSlotsUseCase(
        reservation.restaurantId,
        state.editSelectedTableId ?? reservation.tableId,
        event.date,
        excludeReservationId: reservation.id,
      );
      emit(state.copyWith(isLoadingEditSlots: false, editSlots: slots));
    } catch (_) {
      emit(state.copyWith(isLoadingEditSlots: false));
    }
  }

  // ── Edit: table changed ────────────────────────────────────────────

  Future<void> _onEditTableChanged(
    EditTableChanged event,
    Emitter<MyReservationsState> emit,
  ) async {
    final reservation = state.editingReservation;
    if (reservation == null) return;

    emit(state.copyWith(
      editSelectedTableId: event.tableId,
      editSelectedTime: null,
      isLoadingEditSlots: true,
      editSlots: null,
    ));

    try {
      final slots = await _getSlotsUseCase(
        reservation.restaurantId,
        event.tableId,
        state.editSelectedDate ?? reservation.date,
        excludeReservationId: reservation.id,
      );
      emit(state.copyWith(isLoadingEditSlots: false, editSlots: slots));
    } catch (_) {
      emit(state.copyWith(isLoadingEditSlots: false));
    }
  }

  // ── Edit: time selected ────────────────────────────────────────────

  Future<void> _onEditTimeSelected(
    EditTimeSelected event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(editSelectedTime: event.startTime));
  }

  // ── Edit: party size changed ───────────────────────────────────────

  Future<void> _onEditPartySizeChanged(
    EditPartySizeChanged event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(editPartySize: event.partySize));
  }

  // ── Submit edit ────────────────────────────────────────────────────

  Future<void> _onSubmitEdit(
    SubmitEditReservation event,
    Emitter<MyReservationsState> emit,
  ) async {
    final reservation = state.editingReservation;
    if (reservation == null || !state.canSubmitEdit) return;

    emit(state.copyWith(
      isSubmittingEdit: true,
      editConflict: false,
      editError: null,
    ));

    try {
      await _updateUseCase(
        reservationId: reservation.id,
        tableId: state.editSelectedTableId!,
        date: state.editSelectedDate!,
        startTime: state.editSelectedTime!,
        partySize: state.editPartySize!,
      );

      // Reload overview
      final overview = await _getOverviewUseCase();
      emit(state.copyWith(
        isSubmittingEdit: false,
        editSuccess: true,
        editingReservation: null,
        upcoming: overview.upcoming,
        history: overview.history,
        totalHistoryCount: overview.totalHistoryCount,
        showingAllHistory: false,
      ));
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        emit(state.copyWith(
          isSubmittingEdit: false,
          editConflict: true,
        ));
      } else {
        emit(state.copyWith(
          isSubmittingEdit: false,
          editError: 'Nepodařilo se uložit změny.',
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        isSubmittingEdit: false,
        editError: 'Nepodařilo se uložit změny.',
      ));
    }
  }
}
