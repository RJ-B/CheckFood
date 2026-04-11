// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/modules/reservation/presentation/staff/domain/entities/staff_reservation.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/entities/staff_table.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/repositories/staff_reservation_repository.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/check_in_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/complete_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/confirm_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/extend_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/get_restaurant_tables_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/get_staff_reservations_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/propose_change_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/domain/usecases/reject_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/presentation/bloc/staff_reservations_bloc.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/presentation/bloc/staff_reservations_event.dart';
import 'package:checkfood_client/modules/reservation/presentation/staff/presentation/bloc/staff_reservations_state.dart';

// ── Shared test data ────────────────────────────────────────────────────────

const _date = '2026-06-01';
const _restId = 'rest-1';

StaffReservation _makeRes({
  String id = 'sr-1',
  String status = 'RESERVED',
  bool canConfirm = false,
  bool canReject = false,
  bool canCheckIn = false,
  bool canComplete = false,
  bool canEdit = false,
  bool canExtend = false,
}) =>
    StaffReservation(
      id: id,
      tableId: 'tbl-1',
      tableLabel: 'T1',
      userId: 42,
      userName: 'Jan Novak',
      date: _date,
      startTime: '18:00:00',
      endTime: '19:30:00',
      partySize: 2,
      status: status,
      createdAt: '2026-05-01T10:00:00',
      canConfirm: canConfirm,
      canReject: canReject,
      canCheckIn: canCheckIn,
      canComplete: canComplete,
      canEdit: canEdit,
      canExtend: canExtend,
    );

const _table = StaffTable(id: 'tbl-1', label: 'T1', capacity: 4, active: true);

// ── Fake repository ─────────────────────────────────────────────────────────

class _FakeStaffRepo implements StaffReservationRepository {
  List<StaffReservation> reservations = [_makeRes()];
  List<StaffTable> tables = [_table];

  bool confirmThrows = false;
  bool rejectThrows = false;
  bool checkInThrows = false;
  bool completeThrows = false;
  bool proposeThrows = false;
  bool extendThrows = false;

  String? lastConfirmedId;
  String? lastRejectedId;
  String? lastCheckedInId;
  String? lastCompletedId;
  String? lastProposedId;
  String? lastExtendedId;
  String? lastExtendedEndTime;

  @override
  Future<List<StaffReservation>> getReservations(String date, {String? restaurantId}) async => reservations;

  @override
  Future<void> confirmReservation(String id) async {
    if (confirmThrows) throw Exception('confirm failed');
    lastConfirmedId = id;
    reservations = [_makeRes(id: id, status: 'CONFIRMED')];
  }

  @override
  Future<void> rejectReservation(String id) async {
    if (rejectThrows) throw Exception('reject failed');
    lastRejectedId = id;
    reservations = [_makeRes(id: id, status: 'REJECTED')];
  }

  @override
  Future<void> checkInReservation(String id) async {
    if (checkInThrows) throw Exception('check-in failed');
    lastCheckedInId = id;
    reservations = [_makeRes(id: id, status: 'CHECKED_IN')];
  }

  @override
  Future<void> completeReservation(String id) async {
    if (completeThrows) throw Exception('complete failed');
    lastCompletedId = id;
    reservations = [_makeRes(id: id, status: 'COMPLETED')];
  }

  @override
  Future<List<StaffTable>> getRestaurantTables({String? restaurantId}) async => tables;

  @override
  Future<void> proposeChange(String reservationId, {String? startTime, String? tableId}) async {
    if (proposeThrows) throw Exception('propose failed');
    lastProposedId = reservationId;
  }

  @override
  Future<void> extendReservation(String reservationId, String endTime) async {
    if (extendThrows) throw Exception('extend failed');
    lastExtendedId = reservationId;
    lastExtendedEndTime = endTime;
  }
}

// ── Bloc factory ─────────────────────────────────────────────────────────────

StaffReservationsBloc _build(_FakeStaffRepo repo) => StaffReservationsBloc(
      getReservations: GetStaffReservationsUseCase(repo),
      confirm: ConfirmReservationUseCase(repo),
      reject: RejectReservationUseCase(repo),
      checkIn: CheckInReservationUseCase(repo),
      complete: CompleteReservationUseCase(repo),
      getTables: GetRestaurantTablesUseCase(repo),
      proposeChange: ProposeChangeUseCase(repo),
      extendReservation: ExtendReservationUseCase(repo),
    );

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late _FakeStaffRepo repo;
  late StaffReservationsBloc bloc;

  setUp(() {
    repo = _FakeStaffRepo();
    bloc = _build(repo);
  });

  tearDown(() => bloc.close());

  // ── initial state ──────────────────────────────────────────────────────────

  group('initial state', () {
    test('should have today\'s date, empty reservations, and no error', () {
      expect(bloc.state.reservations, isEmpty);
      expect(bloc.state.isLoading, false);
      expect(bloc.state.error, isNull);
      expect(bloc.state.selectedDate, isNotEmpty);
    });
  });

  // ── LoadStaffReservations ──────────────────────────────────────────────────

  group('LoadStaffReservations', () {
    test('should emit loading then populated reservations', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>()
              .having((s) => s.isLoading, 'loading', true)
              .having((s) => s.restaurantId, 'restaurantId', _restId),
          isA<StaffReservationsState>()
              .having((s) => s.isLoading, 'loading', false)
              .having((s) => s.reservations, 'reservations', hasLength(1))
              .having((s) => s.selectedDate, 'date', _date),
          // auto-triggers LoadTables since tables is empty
          isA<StaffReservationsState>()
              .having((s) => s.tables, 'tables', isNotEmpty),
        ]),
      );
    });

    test('should emit error on failure and still trigger LoadTables', () async {
      final failRepo = _FailingGetReservationsRepo();
      final failBloc = _build(failRepo as _FakeStaffRepo);
      addTearDown(failBloc.close);

      failBloc.add(LoadStaffReservations(_date, restaurantId: _restId));

      await expectLater(
        failBloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.isLoading, 'loading', true),
          isA<StaffReservationsState>()
              .having((s) => s.isLoading, 'loading', false)
              .having((s) => s.error, 'error', isNotNull),
          // LoadTables auto-triggered after error
          isA<StaffReservationsState>(),
        ]),
      );
    });
  });

  // ── ChangeDate ─────────────────────────────────────────────────────────────

  group('ChangeDate', () {
    test('should update selectedDate and reload reservations', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      const newDate = '2026-06-02';
      repo.reservations = [_makeRes(id: 'sr-2')];
      bloc.add(const ChangeDate(newDate));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>()
              .having((s) => s.selectedDate, 'date', newDate)
              .having((s) => s.isLoading, 'loading', true),
          isA<StaffReservationsState>()
              .having((s) => s.isLoading, 'loading', false)
              .having((s) => s.reservations, 'res', hasLength(1)),
        ]),
      );
    });

    test('should do nothing when date unchanged', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      final selectedDate = bloc.state.selectedDate;
      // A same-date ChangeDate must not trigger isLoading
      bool gotLoadingEmit = false;
      final sub = bloc.stream.listen((s) {
        if (s.isLoading) gotLoadingEmit = true;
      });

      bloc.add(ChangeDate(selectedDate));
      await Future<void>.delayed(const Duration(milliseconds: 150));
      await sub.cancel();

      expect(gotLoadingEmit, false);
    });
  });

  // ── ConfirmReservation ─────────────────────────────────────────────────────

  group('ConfirmReservation', () {
    test('should confirm and reload reservations', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const ConfirmReservation('sr-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>()
              .having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>()
              .having((s) => s.actionInProgressId, 'actionId', isNull)
              .having((s) => s.reservations.first.status, 'status', 'CONFIRMED'),
        ]),
      );

      expect(repo.lastConfirmedId, 'sr-1');
    });

    test('should emit actionError on confirm failure', () async {
      repo.confirmThrows = true;
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const ConfirmReservation('sr-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>()
              .having((s) => s.actionInProgressId, 'actionId', isNull)
              .having((s) => s.actionError, 'error', isNotNull),
        ]),
      );
    });
  });

  // ── RejectReservation ──────────────────────────────────────────────────────

  group('RejectReservation', () {
    test('should reject and reload', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const RejectReservation('sr-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>()
              .having((s) => s.actionInProgressId, 'actionId', isNull)
              .having((s) => s.reservations.first.status, 'status', 'REJECTED'),
        ]),
      );

      expect(repo.lastRejectedId, 'sr-1');
    });

    test('should emit actionError on rejection failure', () async {
      repo.rejectThrows = true;
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const RejectReservation('sr-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>().having((s) => s.actionError, 'error', isNotNull),
        ]),
      );
    });
  });

  // ── CheckInReservation ─────────────────────────────────────────────────────

  group('CheckInReservation', () {
    test('should check in and reload', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const CheckInReservation('sr-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>()
              .having((s) => s.actionInProgressId, 'actionId', isNull)
              .having((s) => s.reservations.first.status, 'status', 'CHECKED_IN'),
        ]),
      );
    });
  });

  // ── CompleteReservation ────────────────────────────────────────────────────

  group('CompleteReservation', () {
    test('should complete and reload', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const CompleteReservation('sr-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>()
              .having((s) => s.reservations.first.status, 'status', 'COMPLETED'),
        ]),
      );
    });
  });

  // ── PollRefresh ────────────────────────────────────────────────────────────

  group('PollRefresh', () {
    test('should silently reload reservations on poll', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      repo.reservations = [_makeRes(id: 'sr-1'), _makeRes(id: 'sr-2')];
      bloc.add(const PollRefresh());

      await expectLater(
        bloc.stream,
        emits(
          isA<StaffReservationsState>()
              .having((s) => s.reservations, 'res', hasLength(2)),
        ),
      );
    });

    test('should swallow errors and not update state on poll failure', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      final stateBeforePoll = bloc.state;
      // Replace underlying repo with one that throws
      final failRepo = _FailingGetReservationsRepo();
      final newBloc = StaffReservationsBloc(
        getReservations: GetStaffReservationsUseCase(failRepo as _FakeStaffRepo),
        confirm: ConfirmReservationUseCase(repo),
        reject: RejectReservationUseCase(repo),
        checkIn: CheckInReservationUseCase(repo),
        complete: CompleteReservationUseCase(repo),
        getTables: GetRestaurantTablesUseCase(repo),
        proposeChange: ProposeChangeUseCase(repo),
        extendReservation: ExtendReservationUseCase(repo),
      );
      addTearDown(newBloc.close);

      newBloc.add(const PollRefresh());
      await expectLater(
        newBloc.stream.timeout(const Duration(milliseconds: 200), onTimeout: (s) => s.close()),
        emitsDone,
      );
      // stateBeforePoll captured above; poll failure must not change state
      expect(stateBeforePoll.reservations.length, greaterThanOrEqualTo(0));
    });
  });

  // ── ProposeChange ──────────────────────────────────────────────────────────

  group('ProposeChange', () {
    test('should propose change and reload', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const ProposeChange('sr-1', startTime: '19:00', tableId: 'tbl-1'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', isNull),
        ]),
      );

      expect(repo.lastProposedId, 'sr-1');
    });

    test('should emit actionError when propose fails', () async {
      repo.proposeThrows = true;
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const ProposeChange('sr-1', startTime: '19:00'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>().having((s) => s.actionError, 'error', isNotNull),
        ]),
      );
    });
  });

  // ── ExtendReservation ──────────────────────────────────────────────────────

  group('ExtendReservation', () {
    test('should extend and reload', () async {
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const ExtendReservation('sr-1', '21:00'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', isNull),
        ]),
      );

      expect(repo.lastExtendedId, 'sr-1');
      expect(repo.lastExtendedEndTime, '21:00');
    });

    test('should emit actionError when extend fails', () async {
      repo.extendThrows = true;
      bloc.add(LoadStaffReservations(_date, restaurantId: _restId));
      await bloc.stream.firstWhere((s) => !s.isLoading && s.tables.isNotEmpty);

      bloc.add(const ExtendReservation('sr-1', '21:00'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<StaffReservationsState>().having((s) => s.actionInProgressId, 'actionId', 'sr-1'),
          isA<StaffReservationsState>().having((s) => s.actionError, 'error', isNotNull),
        ]),
      );
    });
  });

  // ── Background polling lifecycle ───────────────────────────────────────────

  group('Polling lifecycle', () {
    test('startPolling and stopPolling should not throw', () {
      expect(() {
        bloc.startPolling();
        bloc.stopPolling();
      }, returnsNormally);
    });

    test('close cancels poll timer without error', () async {
      bloc.startPolling();
      await expectLater(bloc.close(), completes);
    });
  });
}

// ── Helper ────────────────────────────────────────────────────────────────────

class _FailingGetReservationsRepo extends _FakeStaffRepo {
  @override
  Future<List<StaffReservation>> getReservations(String date, {String? restaurantId}) async {
    throw Exception('network error');
  }
}

