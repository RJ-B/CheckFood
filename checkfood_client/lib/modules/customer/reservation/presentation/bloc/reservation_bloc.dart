import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_reservation_usecase.dart';
import '../../domain/usecases/get_available_slots_usecase.dart';
import '../../domain/usecases/get_reservation_scene_usecase.dart';
import '../../domain/usecases/get_table_statuses_usecase.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final GetReservationSceneUseCase _getSceneUseCase;
  final GetTableStatusesUseCase _getStatusesUseCase;
  final GetAvailableSlotsUseCase _getSlotsUseCase;
  final CreateReservationUseCase _createReservationUseCase;

  String? _restaurantId;

  ReservationBloc({
    required GetReservationSceneUseCase getSceneUseCase,
    required GetTableStatusesUseCase getStatusesUseCase,
    required GetAvailableSlotsUseCase getSlotsUseCase,
    required CreateReservationUseCase createReservationUseCase,
  })  : _getSceneUseCase = getSceneUseCase,
        _getStatusesUseCase = getStatusesUseCase,
        _getSlotsUseCase = getSlotsUseCase,
        _createReservationUseCase = createReservationUseCase,
        super(ReservationState.initial()) {
    on<LoadScene>(_onLoadScene);
    on<LoadStatuses>(_onLoadStatuses);
    on<SelectTable>(_onSelectTable);
    on<ChangeDate>(_onChangeDate);
    on<SelectTime>(_onSelectTime);
    on<ChangePartySize>(_onChangePartySize);
    on<SubmitReservation>(_onSubmitReservation);
  }

  Future<void> _onLoadScene(LoadScene event, Emitter<ReservationState> emit) async {
    _restaurantId = event.restaurantId;
    emit(state.copyWith(sceneLoading: true, sceneError: null));

    try {
      final scene = await _getSceneUseCase.call(event.restaurantId);
      emit(state.copyWith(sceneLoading: false, scene: scene));

      // Auto-load statuses for today
      add(LoadStatuses(date: state.selectedDate));
    } catch (e) {
      emit(state.copyWith(sceneLoading: false, sceneError: e.toString()));
    }
  }

  Future<void> _onLoadStatuses(LoadStatuses event, Emitter<ReservationState> emit) async {
    if (_restaurantId == null) return;

    try {
      final result = await _getStatusesUseCase.call(_restaurantId!, event.date);
      emit(state.copyWith(tableStatuses: result.tables));
    } catch (_) {
      // Statuses are non-critical; markers stay default color
    }
  }

  Future<void> _onSelectTable(SelectTable event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(
      selectedTableId: event.tableId,
      selectedTableLabel: event.label,
      selectedTableCapacity: event.capacity,
      selectedPartySize: 2,
      selectedStartTime: null,
      availableSlots: null,
      submitSuccess: false,
      submitConflict: false,
      submitError: null,
    ));

    // Load slots for the selected table
    await _loadSlots(event.tableId, state.selectedDate, emit);
  }

  Future<void> _onChangeDate(ChangeDate event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(
      selectedDate: event.date,
      selectedStartTime: null,
      availableSlots: null,
      submitSuccess: false,
      submitConflict: false,
      submitError: null,
    ));

    // Reload statuses for new date
    add(LoadStatuses(date: event.date));

    // Reload slots if a table is selected
    if (state.selectedTableId != null) {
      await _loadSlots(state.selectedTableId!, event.date, emit);
    }
  }

  void _onChangePartySize(ChangePartySize event, Emitter<ReservationState> emit) {
    emit(state.copyWith(selectedPartySize: event.partySize));
  }

  void _onSelectTime(SelectTime event, Emitter<ReservationState> emit) {
    emit(state.copyWith(
      selectedStartTime: event.startTime,
      submitSuccess: false,
      submitConflict: false,
      submitError: null,
    ));
  }

  Future<void> _onSubmitReservation(
    SubmitReservation event,
    Emitter<ReservationState> emit,
  ) async {
    if (_restaurantId == null ||
        state.selectedTableId == null ||
        state.selectedStartTime == null) return;

    emit(state.copyWith(
      submitting: true,
      submitSuccess: false,
      submitConflict: false,
      submitError: null,
    ));

    try {
      await _createReservationUseCase.call(
        restaurantId: _restaurantId!,
        tableId: state.selectedTableId!,
        date: state.selectedDate,
        startTime: state.selectedStartTime!,
        partySize: state.selectedPartySize,
      );

      // Page will navigate away — no further emissions needed
      emit(state.copyWith(submitting: false, submitSuccess: true));
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        emit(state.copyWith(submitting: false, submitConflict: true));
        // Refresh slots to show updated availability
        if (state.selectedTableId != null) {
          await _loadSlots(state.selectedTableId!, state.selectedDate, emit);
        }
      } else {
        emit(state.copyWith(
          submitting: false,
          submitError: e.response?.data?['message']?.toString() ?? 'Chyba při vytváření rezervace.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(submitting: false, submitError: e.toString()));
    }
  }

  Future<void> _loadSlots(String tableId, String date, Emitter<ReservationState> emit) async {
    if (_restaurantId == null) return;
    emit(state.copyWith(slotsLoading: true));

    try {
      final slots = await _getSlotsUseCase.call(_restaurantId!, tableId, date);
      emit(state.copyWith(slotsLoading: false, availableSlots: slots));
    } catch (e) {
      emit(state.copyWith(slotsLoading: false, availableSlots: null));
    }
  }
}
