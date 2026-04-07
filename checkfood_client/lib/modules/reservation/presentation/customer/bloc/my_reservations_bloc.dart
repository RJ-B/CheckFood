import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/accept_change_request_usecase.dart';
import '../../../domain/usecases/cancel_reservation_usecase.dart';
import '../../../domain/usecases/decline_change_request_usecase.dart';
import '../../../domain/usecases/get_available_slots_usecase.dart';
import '../../../domain/usecases/get_my_reservations_history_usecase.dart';
import '../../../domain/usecases/get_my_reservations_overview_usecase.dart';
import '../../../domain/usecases/get_pending_changes_usecase.dart';
import '../../../domain/usecases/get_reservation_scene_usecase.dart';
import '../../../domain/usecases/update_reservation_usecase.dart';
import '../../../domain/usecases/create_recurring_reservation_usecase.dart';
import '../../../domain/usecases/get_my_recurring_reservations_usecase.dart';
import '../../../domain/usecases/cancel_recurring_reservation_usecase.dart';
import 'my_reservations_event.dart';
import 'my_reservations_state.dart';

/// BLoC spravující seznam rezervací uživatele: načítání přehledu, úprava a
/// rušení jednotlivých rezervací, reakce na čekající návrhy změn a
/// vytváření nebo rušení sérií opakovaných rezervací.
class MyReservationsBloc
    extends Bloc<MyReservationsEvent, MyReservationsState> {
  final GetMyReservationsOverviewUseCase _getOverviewUseCase;
  final GetMyReservationsHistoryUseCase _getHistoryUseCase;
  final CancelReservationUseCase _cancelUseCase;
  final UpdateReservationUseCase _updateUseCase;
  final GetReservationSceneUseCase _getSceneUseCase;
  final GetAvailableSlotsUseCase _getSlotsUseCase;
  final GetPendingChangesUseCase _getPendingChangesUseCase;
  final AcceptChangeRequestUseCase _acceptChangeRequestUseCase;
  final DeclineChangeRequestUseCase _declineChangeRequestUseCase;
  final CreateRecurringReservationUseCase _createRecurringUseCase;
  final GetMyRecurringReservationsUseCase _getRecurringUseCase;
  final CancelRecurringReservationUseCase _cancelRecurringUseCase;

  MyReservationsBloc({
    required GetMyReservationsOverviewUseCase getOverviewUseCase,
    required GetMyReservationsHistoryUseCase getHistoryUseCase,
    required CancelReservationUseCase cancelUseCase,
    required UpdateReservationUseCase updateUseCase,
    required GetReservationSceneUseCase getSceneUseCase,
    required GetAvailableSlotsUseCase getSlotsUseCase,
    required GetPendingChangesUseCase getPendingChangesUseCase,
    required AcceptChangeRequestUseCase acceptChangeRequestUseCase,
    required DeclineChangeRequestUseCase declineChangeRequestUseCase,
    required CreateRecurringReservationUseCase createRecurringUseCase,
    required GetMyRecurringReservationsUseCase getRecurringUseCase,
    required CancelRecurringReservationUseCase cancelRecurringUseCase,
  })  : _getOverviewUseCase = getOverviewUseCase,
        _getHistoryUseCase = getHistoryUseCase,
        _cancelUseCase = cancelUseCase,
        _updateUseCase = updateUseCase,
        _getSceneUseCase = getSceneUseCase,
        _getSlotsUseCase = getSlotsUseCase,
        _getPendingChangesUseCase = getPendingChangesUseCase,
        _acceptChangeRequestUseCase = acceptChangeRequestUseCase,
        _declineChangeRequestUseCase = declineChangeRequestUseCase,
        _createRecurringUseCase = createRecurringUseCase,
        _getRecurringUseCase = getRecurringUseCase,
        _cancelRecurringUseCase = cancelRecurringUseCase,
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
    on<LoadPendingChanges>(_onLoadPendingChanges);
    on<AcceptChangeRequest>(_onAcceptChangeRequest);
    on<DeclineChangeRequest>(_onDeclineChangeRequest);
    on<CreateRecurringReservation>(_onCreateRecurring);
    on<LoadRecurringReservations>(_onLoadRecurring);
    on<CancelRecurringReservation>(_onCancelRecurring);
  }

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
      add(const MyReservationsEvent.loadPendingChanges());
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        loadError: 'Nepodařilo se načíst rezervace.',
      ));
    }
  }

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
    } catch (_) {}
  }

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

  Future<void> _onCancel(
    CancelReservation event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(cancellingId: event.reservationId, cancelSuccess: false));
    try {
      await _cancelUseCase(event.reservationId);
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
      final scene = await _getSceneUseCase(reservation.restaurantId);
      emit(state.copyWith(editTables: scene.tables));

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

  Future<void> _onEditTimeSelected(
    EditTimeSelected event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(editSelectedTime: event.startTime));
  }

  Future<void> _onEditPartySizeChanged(
    EditPartySizeChanged event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(editPartySize: event.partySize));
  }

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

  Future<void> _onLoadPendingChanges(
    LoadPendingChanges event,
    Emitter<MyReservationsState> emit,
  ) async {
    try {
      final changes = await _getPendingChangesUseCase();
      emit(state.copyWith(pendingChanges: changes));
    } catch (_) {}
  }

  Future<void> _onAcceptChangeRequest(
    AcceptChangeRequest event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(pendingChangeActionId: event.changeRequestId));
    try {
      await _acceptChangeRequestUseCase(event.changeRequestId);
      final overview = await _getOverviewUseCase();
      final changes = await _getPendingChangesUseCase();
      emit(state.copyWith(
        pendingChangeActionId: null,
        pendingChanges: changes,
        upcoming: overview.upcoming,
        history: overview.history,
        totalHistoryCount: overview.totalHistoryCount,
        showingAllHistory: false,
      ));
    } catch (e) {
      dev.log('AcceptChangeRequest failed: $e', name: 'CheckFood.Reservations');
      emit(state.copyWith(pendingChangeActionId: null));
    }
  }

  Future<void> _onDeclineChangeRequest(
    DeclineChangeRequest event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(pendingChangeActionId: event.changeRequestId));
    try {
      await _declineChangeRequestUseCase(event.changeRequestId);
      final overview = await _getOverviewUseCase();
      final changes = await _getPendingChangesUseCase();
      emit(state.copyWith(
        pendingChangeActionId: null,
        pendingChanges: changes,
        upcoming: overview.upcoming,
        history: overview.history,
        totalHistoryCount: overview.totalHistoryCount,
        showingAllHistory: false,
      ));
    } catch (_) {
      emit(state.copyWith(pendingChangeActionId: null));
    }
  }

  Future<void> _onCreateRecurring(
    CreateRecurringReservation event,
    Emitter<MyReservationsState> emit,
  ) async {
    emit(state.copyWith(isLoadingRecurring: true, recurringSuccess: false));
    try {
      await _createRecurringUseCase(
        restaurantId: event.restaurantId,
        tableId: event.tableId,
        dayOfWeek: event.dayOfWeek,
        startTime: event.startTime,
        partySize: event.partySize,
      );
      final recurring = await _getRecurringUseCase();
      emit(state.copyWith(
        isLoadingRecurring: false,
        recurringReservations: recurring,
        recurringSuccess: true,
      ));
    } catch (e) {
      dev.log('CreateRecurring failed: $e', name: 'CheckFood.Reservations');
      emit(state.copyWith(isLoadingRecurring: false));
    }
  }

  Future<void> _onLoadRecurring(
    LoadRecurringReservations event,
    Emitter<MyReservationsState> emit,
  ) async {
    try {
      final recurring = await _getRecurringUseCase();
      emit(state.copyWith(recurringReservations: recurring));
    } catch (_) {}
  }

  Future<void> _onCancelRecurring(
    CancelRecurringReservation event,
    Emitter<MyReservationsState> emit,
  ) async {
    try {
      await _cancelRecurringUseCase(event.id);
      final recurring = await _getRecurringUseCase();
      final overview = await _getOverviewUseCase();
      emit(state.copyWith(
        recurringReservations: recurring,
        upcoming: overview.upcoming,
        history: overview.history,
      ));
    } catch (e) {
      dev.log('CancelRecurring failed: $e', name: 'CheckFood.Reservations');
    }
  }
}
