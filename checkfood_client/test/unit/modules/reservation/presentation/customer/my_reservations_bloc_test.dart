// ignore_for_file: lines_longer_than_80_chars
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/modules/reservation/domain/entities/available_slots.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/my_reservations_overview.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/pending_change.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/recurring_reservation.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/reservation.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/reservation_scene.dart';
import 'package:checkfood_client/modules/reservation/domain/repositories/reservation_repository.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/table_status.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/accept_change_request_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/cancel_recurring_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/cancel_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/create_recurring_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/decline_change_request_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_available_slots_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_recurring_reservations_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_reservations_history_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_reservations_overview_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_pending_changes_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_reservation_scene_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/update_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/my_reservations_bloc.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/my_reservations_event.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/my_reservations_state.dart';

// ── Shared test data ────────────────────────────────────────────────────────

const _restId = 'rest-1';
const _tableId = 'tbl-1';
const _date = '2026-06-01';

const _upcoming = Reservation(
  id: 'r-1',
  restaurantId: _restId,
  tableId: _tableId,
  restaurantName: 'Test Bistro',
  tableLabel: 'T1',
  date: _date,
  startTime: '18:00',
  endTime: '19:30',
  status: 'CONFIRMED',
  partySize: 2,
  canEdit: true,
  canCancel: true,
);

const _historyRes = Reservation(
  id: 'r-0',
  restaurantId: _restId,
  tableId: _tableId,
  date: '2026-05-01',
  startTime: '12:00',
  status: 'COMPLETED',
  partySize: 2,
);

const _overview = MyReservationsOverview(
  upcoming: [_upcoming],
  history: [_historyRes],
  totalHistoryCount: 1,
);

const _emptyOverview = MyReservationsOverview(
  upcoming: [],
  history: [],
  totalHistoryCount: 0,
);

const _pendingChange = PendingChange(
  id: 'pc-1',
  reservationId: 'r-1',
  restaurantName: 'Test Bistro',
  proposedStartTime: '19:00',
  proposedTableId: _tableId,
  proposedTableLabel: 'T1',
  originalStartTime: '18:00',
  originalTableId: _tableId,
  originalTableLabel: 'T1',
  reservationDate: _date,
  status: 'PENDING',
  createdAt: '2026-05-30T10:00:00',
);

const _recurring = RecurringReservation(
  id: 'rec-1',
  restaurantId: _restId,
  tableId: _tableId,
  restaurantName: 'Test Bistro',
  tableLabel: 'T1',
  dayOfWeek: '1',
  startTime: '18:00',
  partySize: 2,
  status: 'ACTIVE',
  createdAt: '2026-05-01T10:00:00',
  instanceCount: 3,
);

const _slots = AvailableSlots(
  date: _date,
  tableId: _tableId,
  slotMinutes: 30,
  durationMinutes: 90,
  availableStartTimes: ['18:00', '18:30', '19:00'],
);

const _scene = ReservationScene(
  restaurantId: _restId,
  panoramaUrl: null,
  tables: [SceneTable(tableId: _tableId, label: 'T1', yaw: 0, pitch: 0, capacity: 4)],
);

// ── Fake repository ─────────────────────────────────────────────────────────

class _FakeRepo implements ReservationRepository {
  MyReservationsOverview overviewResult = _overview;
  List<Reservation> historyResult = [_historyRes];
  bool cancelThrows = false;
  bool updateThrows = false;
  bool updateConflict = false;
  bool acceptThrows = false;
  bool declineThrows = false;
  bool createRecurringThrows = false;
  List<PendingChange> pendingChangesResult = [];
  List<RecurringReservation> recurringResult = [];

  String? lastCancelledId;
  String? lastAcceptedChangeId;
  String? lastDeclinedChangeId;
  String? lastCancelledRecurringId;

  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async => overviewResult;

  @override
  Future<List<Reservation>> getMyReservationsHistory() async => historyResult;

  @override
  Future<Reservation> cancelReservation(String reservationId) async {
    if (cancelThrows) throw Exception('cancel failed');
    lastCancelledId = reservationId;
    return _historyRes;
  }

  @override
  Future<Reservation> updateReservation({
    required String reservationId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async {
    if (updateConflict) {
      throw DioException(
        requestOptions: RequestOptions(path: '/reservations/$reservationId'),
        response: Response(
          statusCode: 409,
          requestOptions: RequestOptions(path: '/reservations/$reservationId'),
        ),
        type: DioExceptionType.badResponse,
      );
    }
    if (updateThrows) throw Exception('update failed');
    return _upcoming;
  }

  @override
  Future<List<PendingChange>> getPendingChanges() async => pendingChangesResult;

  @override
  Future<Reservation> acceptChangeRequest(String changeRequestId) async {
    if (acceptThrows) throw Exception('accept failed');
    lastAcceptedChangeId = changeRequestId;
    return _upcoming;
  }

  @override
  Future<Reservation> declineChangeRequest(String changeRequestId) async {
    if (declineThrows) throw Exception('decline failed');
    lastDeclinedChangeId = changeRequestId;
    return _upcoming;
  }

  @override
  Future<RecurringReservation> createRecurringReservation({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    int partySize = 2,
  }) async {
    if (createRecurringThrows) throw Exception('create recurring failed');
    return _recurring;
  }

  @override
  Future<List<RecurringReservation>> getMyRecurringReservations() async => recurringResult;

  @override
  Future<RecurringReservation> cancelRecurringReservation(String id) async {
    lastCancelledRecurringId = id;
    return _recurring;
  }

  // Unused in these tests
  @override
  Future<ReservationScene> getReservationScene(String restaurantId) async => _scene;

  @override
  Future<TableStatusList> getTableStatuses(String restaurantId, String date) async =>
      const TableStatusList(date: _date, tables: []);

  @override
  Future<AvailableSlots> getAvailableSlots(String restaurantId, String tableId, String date, {String? excludeReservationId}) async => _slots;

  @override
  Future<Reservation> createReservation({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async => _upcoming;
}

// ── Bloc factory ─────────────────────────────────────────────────────────────

MyReservationsBloc _build(_FakeRepo repo) => MyReservationsBloc(
      getOverviewUseCase: GetMyReservationsOverviewUseCase(repo),
      getHistoryUseCase: GetMyReservationsHistoryUseCase(repo),
      cancelUseCase: CancelReservationUseCase(repo),
      updateUseCase: UpdateReservationUseCase(repo),
      getSceneUseCase: GetReservationSceneUseCase(repo),
      getSlotsUseCase: GetAvailableSlotsUseCase(repo),
      getPendingChangesUseCase: GetPendingChangesUseCase(repo),
      acceptChangeRequestUseCase: AcceptChangeRequestUseCase(repo),
      declineChangeRequestUseCase: DeclineChangeRequestUseCase(repo),
      createRecurringUseCase: CreateRecurringReservationUseCase(repo),
      getRecurringUseCase: GetMyRecurringReservationsUseCase(repo),
      cancelRecurringUseCase: CancelRecurringReservationUseCase(repo),
    );

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late _FakeRepo repo;
  late MyReservationsBloc bloc;

  setUp(() {
    repo = _FakeRepo();
    bloc = _build(repo);
  });

  tearDown(() => bloc.close());

  // ── initial state ──────────────────────────────────────────────────────────

  group('initial state', () {
    test('should start with isLoading true and empty lists', () {
      expect(bloc.state.isLoading, true);
      expect(bloc.state.upcoming, isEmpty);
      expect(bloc.state.history, isEmpty);
      expect(bloc.state.loadError, isNull);
    });
  });

  // ── LoadMyReservations ─────────────────────────────────────────────────────

  group('LoadMyReservations', () {
    test('should emit loading then loaded state on success', () async {
      bloc.add(const MyReservationsEvent.load());

      // Wait until loading completes (isLoading transitions to false)
      await bloc.stream.firstWhere((s) => !s.isLoading && s.loadError == null);

      expect(bloc.state.isLoading, false);
      expect(bloc.state.upcoming, hasLength(1));
      expect(bloc.state.history, hasLength(1));
      expect(bloc.state.upcoming.first.id, 'r-1');
    });

    test('should emit loadError on repository failure', () async {
      repo.overviewResult = _emptyOverview; // replaced by throw below
      final errorRepo = _ThrowingOverviewRepo();
      final errorBloc = _build(errorRepo as _FakeRepo);
      // Use ad-hoc approach: monkey-patch via separate test with throw
      errorBloc.close();

      // Simpler: use a subclass that throws
      final failRepo = _FakeRepo();
      final failBloc = _build(failRepo);
      failRepo.overviewResult; // ensure it's there but we'll override below

      // Rebuild with a repo that throws
      final throwBloc = MyReservationsBloc(
        getOverviewUseCase: _ThrowingOverviewUseCase(),
        getHistoryUseCase: GetMyReservationsHistoryUseCase(failRepo),
        cancelUseCase: CancelReservationUseCase(failRepo),
        updateUseCase: UpdateReservationUseCase(failRepo),
        getSceneUseCase: GetReservationSceneUseCase(failRepo),
        getSlotsUseCase: GetAvailableSlotsUseCase(failRepo),
        getPendingChangesUseCase: GetPendingChangesUseCase(failRepo),
        acceptChangeRequestUseCase: AcceptChangeRequestUseCase(failRepo),
        declineChangeRequestUseCase: DeclineChangeRequestUseCase(failRepo),
        createRecurringUseCase: CreateRecurringReservationUseCase(failRepo),
        getRecurringUseCase: GetMyRecurringReservationsUseCase(failRepo),
        cancelRecurringUseCase: CancelRecurringReservationUseCase(failRepo),
      );
      addTearDown(throwBloc.close);

      throwBloc.add(const MyReservationsEvent.load());

      await expectLater(
        throwBloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.isLoading, 'isLoading', true),
          isA<MyReservationsState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.loadError, 'loadError', isNotNull),
        ]),
      );

      failBloc.close();
    });

    test('should emit empty overview when no reservations exist', () async {
      repo.overviewResult = _emptyOverview;
      bloc.add(const MyReservationsEvent.load());

      await bloc.stream.firstWhere((s) => !s.isLoading);

      expect(bloc.state.upcoming, isEmpty);
      expect(bloc.state.history, isEmpty);
    });
  });

  // ── RefreshMyReservations ──────────────────────────────────────────────────

  group('RefreshMyReservations', () {
    test('should silently reload overview without toggling isLoading', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);

      repo.overviewResult = _emptyOverview;
      bloc.add(const MyReservationsEvent.refresh());

      await expectLater(
        bloc.stream,
        emits(
          isA<MyReservationsState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.upcoming, 'upcoming', isEmpty),
        ),
      );
    });
  });

  // ── ShowAllHistory ─────────────────────────────────────────────────────────

  group('ShowAllHistory', () {
    test('should emit isLoadingHistory then all history', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);

      repo.historyResult = [_historyRes, _historyRes, _historyRes];
      bloc.add(const MyReservationsEvent.showAllHistory());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.isLoadingHistory, 'loading', true),
          isA<MyReservationsState>()
              .having((s) => s.isLoadingHistory, 'loading', false)
              .having((s) => s.showingAllHistory, 'showingAll', true)
              .having((s) => s.history, 'history', hasLength(3)),
        ]),
      );
    });
  });

  // ── CancelReservation ──────────────────────────────────────────────────────

  group('CancelReservation', () {
    test('should set cancellingId, call repo, then refresh overview', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);

      bloc.add(const MyReservationsEvent.cancel(reservationId: 'r-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>()
              .having((s) => s.cancellingId, 'cancellingId', 'r-1')
              .having((s) => s.cancelSuccess, 'cancelSuccess', false),
          isA<MyReservationsState>()
              .having((s) => s.cancellingId, 'cancellingId', isNull)
              .having((s) => s.cancelSuccess, 'cancelSuccess', true),
        ]),
      );

      expect(repo.lastCancelledId, 'r-1');
    });

    test('should clear cancellingId on failure without setting cancelSuccess', () async {
      repo.cancelThrows = true;
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);

      bloc.add(const MyReservationsEvent.cancel(reservationId: 'r-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.cancellingId, 'cancellingId', 'r-1'),
          isA<MyReservationsState>()
              .having((s) => s.cancellingId, 'cancellingId', isNull)
              .having((s) => s.cancelSuccess, 'cancelSuccess', false),
        ]),
      );
    });
  });

  // ── StartEditReservation / edit flow ──────────────────────────────────────

  group('StartEditReservation', () {
    test('should populate edit fields and load slots', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);

      bloc.add(MyReservationsEvent.startEdit(reservation: _upcoming));

      // Wait for the full edit-start sequence to complete
      await bloc.stream.firstWhere((s) =>
          s.editingReservation != null &&
          s.editTables.isNotEmpty &&
          s.editSlots != null &&
          !s.isLoadingEditSlots);

      expect(bloc.state.editingReservation, isNotNull);
      expect(bloc.state.editTables, isNotEmpty);
      expect(bloc.state.editSlots, isNotNull);
    });

    test('canSubmitEdit requires all fields set; is true once all present', () async {
      // _onStartEdit sets date, table, time from reservation immediately
      // so canSubmitEdit becomes true once slots are loaded.
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);
      bloc.add(MyReservationsEvent.startEdit(reservation: _upcoming));
      await bloc.stream.firstWhere((s) =>
          s.editSlots != null && !s.isLoadingEditSlots);

      // All required fields are set (date, table, time, partySize all from reservation)
      expect(bloc.state.canSubmitEdit, true);
    });
  });

  // ── SubmitEditReservation ──────────────────────────────────────────────────

  group('SubmitEditReservation', () {
    Future<void> _prepareEdit() async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);
      bloc.add(MyReservationsEvent.startEdit(reservation: _upcoming));
      await bloc.stream.firstWhere((s) => s.editSlots != null && !s.isLoadingEditSlots);
      bloc.add(const MyReservationsEvent.editTimeSelected(startTime: '18:30'));
      await bloc.stream.firstWhere((s) => s.editSelectedTime == '18:30');
    }

    test('should emit editSuccess on successful update', () async {
      await _prepareEdit();

      bloc.add(const MyReservationsEvent.submitEdit());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.isSubmittingEdit, 'submitting', true),
          isA<MyReservationsState>()
              .having((s) => s.isSubmittingEdit, 'submitting', false)
              .having((s) => s.editSuccess, 'success', true)
              .having((s) => s.editingReservation, 'editing', isNull),
        ]),
      );
    });

    test('should emit editConflict on 409', () async {
      repo.updateConflict = true;
      await _prepareEdit();

      bloc.add(const MyReservationsEvent.submitEdit());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.isSubmittingEdit, 'submitting', true),
          isA<MyReservationsState>()
              .having((s) => s.isSubmittingEdit, 'submitting', false)
              .having((s) => s.editConflict, 'conflict', true),
        ]),
      );
    });

    test('should emit editError on generic failure', () async {
      repo.updateThrows = true;
      await _prepareEdit();

      bloc.add(const MyReservationsEvent.submitEdit());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.isSubmittingEdit, 'submitting', true),
          isA<MyReservationsState>()
              .having((s) => s.editError, 'error', isNotNull)
              .having((s) => s.editConflict, 'conflict', false),
        ]),
      );
    });

    test('should do nothing when canSubmitEdit is false', () async {
      // Build a fresh bloc with a state that has no editing reservation
      final emptyBloc = _build(_FakeRepo());
      addTearDown(emptyBloc.close);
      // canSubmitEdit == false in initial state
      expect(emptyBloc.state.canSubmitEdit, false);

      emptyBloc.add(const MyReservationsEvent.submitEdit());

      // No submit-related emission should occur within a short window
      bool gotSubmitState = false;
      emptyBloc.stream.listen((s) {
        if (s.isSubmittingEdit || s.editSuccess || s.editConflict || s.editError != null) {
          gotSubmitState = true;
        }
      });

      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(gotSubmitState, false);
    });
  });

  // ── LoadPendingChanges ─────────────────────────────────────────────────────

  group('LoadPendingChanges', () {
    test('should populate pendingChanges list', () async {
      repo.pendingChangesResult = [_pendingChange];
      bloc.add(const MyReservationsEvent.loadPendingChanges());

      await expectLater(
        bloc.stream,
        emits(
          isA<MyReservationsState>()
              .having((s) => s.pendingChanges, 'pendingChanges', hasLength(1)),
        ),
      );
    });
  });

  // ── AcceptChangeRequest ────────────────────────────────────────────────────

  group('AcceptChangeRequest', () {
    test('should set pendingChangeActionId, call accept, then refresh', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);

      bloc.add(const MyReservationsEvent.acceptChangeRequest(changeRequestId: 'pc-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>()
              .having((s) => s.pendingChangeActionId, 'actionId', 'pc-1'),
          isA<MyReservationsState>()
              .having((s) => s.pendingChangeActionId, 'actionId', isNull),
        ]),
      );

      expect(repo.lastAcceptedChangeId, 'pc-1');
    });

    test('should clear actionId on failure', () async {
      repo.acceptThrows = true;
      bloc.add(const MyReservationsEvent.acceptChangeRequest(changeRequestId: 'pc-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.pendingChangeActionId, 'actionId', 'pc-1'),
          isA<MyReservationsState>().having((s) => s.pendingChangeActionId, 'actionId', isNull),
        ]),
      );
    });
  });

  // ── DeclineChangeRequest ───────────────────────────────────────────────────

  group('DeclineChangeRequest', () {
    test('should call decline and refresh overview', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);

      bloc.add(const MyReservationsEvent.declineChangeRequest(changeRequestId: 'pc-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.pendingChangeActionId, 'actionId', 'pc-1'),
          isA<MyReservationsState>().having((s) => s.pendingChangeActionId, 'actionId', isNull),
        ]),
      );

      expect(repo.lastDeclinedChangeId, 'pc-1');
    });

    test('should clear actionId on failure', () async {
      repo.declineThrows = true;
      bloc.add(const MyReservationsEvent.declineChangeRequest(changeRequestId: 'pc-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.pendingChangeActionId, 'actionId', 'pc-1'),
          isA<MyReservationsState>().having((s) => s.pendingChangeActionId, 'actionId', isNull),
        ]),
      );
    });
  });

  // ── CreateRecurringReservation ─────────────────────────────────────────────

  group('CreateRecurringReservation', () {
    test('should emit recurringSuccess and populate recurringReservations', () async {
      repo.recurringResult = [_recurring];
      bloc.add(const MyReservationsEvent.createRecurring(
        restaurantId: _restId,
        tableId: _tableId,
        dayOfWeek: '1',
        startTime: '18:00',
        partySize: 2,
      ));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.isLoadingRecurring, 'loading', true),
          isA<MyReservationsState>()
              .having((s) => s.isLoadingRecurring, 'loading', false)
              .having((s) => s.recurringSuccess, 'success', true)
              .having((s) => s.recurringReservations, 'recurring', isNotEmpty),
        ]),
      );
    });

    test('should clear isLoadingRecurring on failure', () async {
      repo.createRecurringThrows = true;
      bloc.add(const MyReservationsEvent.createRecurring(
        restaurantId: _restId,
        tableId: _tableId,
        dayOfWeek: '1',
        startTime: '18:00',
        partySize: 2,
      ));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyReservationsState>().having((s) => s.isLoadingRecurring, 'loading', true),
          isA<MyReservationsState>()
              .having((s) => s.isLoadingRecurring, 'loading', false)
              .having((s) => s.recurringSuccess, 'success', false),
        ]),
      );
    });
  });

  // ── CancelRecurringReservation ─────────────────────────────────────────────

  group('CancelRecurringReservation', () {
    test('should call cancelRecurring and refresh data', () async {
      repo.recurringResult = [];
      bloc.add(const MyReservationsEvent.cancelRecurring(id: 'rec-1'));

      await expectLater(
        bloc.stream,
        emits(isA<MyReservationsState>()),
      );

      expect(repo.lastCancelledRecurringId, 'rec-1');
    });
  });

  // ── Edit field changes ─────────────────────────────────────────────────────

  group('Edit field mutations', () {
    test('EditDateChanged should reload slots and clear selected time', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);
      bloc.add(MyReservationsEvent.startEdit(reservation: _upcoming));
      await bloc.stream.firstWhere((s) => s.editSlots != null && !s.isLoadingEditSlots);

      // Change the date — this clears time and triggers slot reload
      bloc.add(const MyReservationsEvent.editDateChanged(date: '2026-06-08'));

      // Verify the intermediate state has isLoadingEditSlots=true and time cleared
      final loadingState = await bloc.stream.firstWhere((s) =>
          s.editSelectedDate == '2026-06-08' && s.isLoadingEditSlots);
      expect(loadingState.editSelectedTime, isNull);

      // Wait for slots to reload
      await bloc.stream.firstWhere((s) =>
          s.editSelectedDate == '2026-06-08' && !s.isLoadingEditSlots);

      expect(bloc.state.editSelectedDate, '2026-06-08');
      expect(bloc.state.editSelectedTime, isNull);
    });

    test('EditTableChanged should reload slots', () async {
      bloc.add(const MyReservationsEvent.load());
      await bloc.stream.firstWhere((s) => !s.isLoading);
      bloc.add(MyReservationsEvent.startEdit(reservation: _upcoming));
      await bloc.stream.firstWhere((s) => s.editSlots != null && !s.isLoadingEditSlots);

      bloc.add(const MyReservationsEvent.editTableChanged(tableId: 'tbl-2'));

      await bloc.stream.firstWhere((s) =>
          s.editSelectedTableId == 'tbl-2' && !s.isLoadingEditSlots);

      expect(bloc.state.editSelectedTableId, 'tbl-2');
    });

    test('EditPartySizeChanged should update party size', () async {
      bloc.add(const MyReservationsEvent.editPartySizeChanged(partySize: 4));
      await expectLater(
        bloc.stream,
        emits(isA<MyReservationsState>().having((s) => s.editPartySize, 'size', 4)),
      );
    });
  });
}

// ── Helper classes ─────────────────────────────────────────────────────────

class _ThrowingOverviewRepo extends _FakeRepo {
  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async {
    throw Exception('overview unavailable');
  }
}

class _ThrowingOverviewUseCase extends GetMyReservationsOverviewUseCase {
  _ThrowingOverviewUseCase() : super(_ThrowingOverviewRepo());
}
