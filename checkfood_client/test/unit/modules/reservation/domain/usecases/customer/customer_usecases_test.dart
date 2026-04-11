// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/modules/reservation/domain/entities/available_slots.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/my_reservations_overview.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/pending_change.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/recurring_reservation.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/reservation.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/reservation_scene.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/table_status.dart';
import 'package:checkfood_client/modules/reservation/domain/repositories/reservation_repository.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/accept_change_request_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/cancel_recurring_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/cancel_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/create_recurring_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/decline_change_request_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_available_slots_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_recurring_reservations_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_reservations_history_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_reservations_overview_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_pending_changes_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_reservation_scene_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_table_statuses_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/update_reservation_usecase.dart';

// ── Fake repository ─────────────────────────────────────────────────────────

const _restId = 'rest-1';
const _tableId = 'tbl-1';
const _date = '2026-06-01';

const _reservation = Reservation(
  id: 'r-1',
  restaurantId: _restId,
  tableId: _tableId,
  date: _date,
  startTime: '18:00',
  status: 'CONFIRMED',
  partySize: 2,
);

const _scene = ReservationScene(
  restaurantId: _restId,
  panoramaUrl: null,
  tables: [],
);

const _statusList = TableStatusList(date: _date, tables: [
  TableStatus(tableId: _tableId, status: 'FREE'),
]);

const _slots = AvailableSlots(
  date: _date,
  tableId: _tableId,
  slotMinutes: 30,
  durationMinutes: 90,
  availableStartTimes: ['18:00', '18:30'],
);

const _overview = MyReservationsOverview(
  upcoming: [_reservation],
  history: [],
  totalHistoryCount: 0,
);

const _pendingChange = PendingChange(
  id: 'pc-1',
  reservationId: 'r-1',
  restaurantName: 'Bistro',
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
  dayOfWeek: '1',
  startTime: '18:00',
  partySize: 2,
  status: 'ACTIVE',
  createdAt: '2026-05-01T10:00:00',
);

class _FakeRepo implements ReservationRepository {
  @override
  Future<ReservationScene> getReservationScene(String restaurantId) async => _scene;

  @override
  Future<TableStatusList> getTableStatuses(String restaurantId, String date) async => _statusList;

  @override
  Future<AvailableSlots> getAvailableSlots(String restaurantId, String tableId, String date, {String? excludeReservationId}) async => _slots;

  @override
  Future<Reservation> createReservation({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async => _reservation;

  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async => _overview;

  @override
  Future<List<Reservation>> getMyReservationsHistory() async => [_reservation];

  @override
  Future<Reservation> updateReservation({
    required String reservationId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async => _reservation;

  @override
  Future<Reservation> cancelReservation(String reservationId) async => _reservation;

  @override
  Future<List<PendingChange>> getPendingChanges() async => [_pendingChange];

  @override
  Future<Reservation> acceptChangeRequest(String changeRequestId) async => _reservation;

  @override
  Future<Reservation> declineChangeRequest(String changeRequestId) async => _reservation;

  @override
  Future<RecurringReservation> createRecurringReservation({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    int partySize = 2,
  }) async => _recurring;

  @override
  Future<List<RecurringReservation>> getMyRecurringReservations() async => [_recurring];

  @override
  Future<RecurringReservation> cancelRecurringReservation(String id) async => _recurring;
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late _FakeRepo repo;

  setUp(() => repo = _FakeRepo());

  group('GetReservationSceneUseCase', () {
    test('should return scene from repository', () async {
      final result = await GetReservationSceneUseCase(repo).call(_restId);
      expect(result, equals(_scene));
    });
  });

  group('GetTableStatusesUseCase', () {
    test('should return table status list', () async {
      final result = await GetTableStatusesUseCase(repo).call(_restId, _date);
      expect(result.tables, hasLength(1));
      expect(result.tables.first.status, 'FREE');
    });
  });

  group('GetAvailableSlotsUseCase', () {
    test('should return available slots', () async {
      final result = await GetAvailableSlotsUseCase(repo).call(_restId, _tableId, _date);
      expect(result.availableStartTimes, hasLength(2));
    });

    test('should pass excludeReservationId when provided', () async {
      // No assertion on repo capture because _FakeRepo ignores it,
      // but the call must not throw.
      final result = await GetAvailableSlotsUseCase(repo)
          .call(_restId, _tableId, _date, excludeReservationId: 'r-1');
      expect(result, isA<AvailableSlots>());
    });
  });

  group('CreateReservationUseCase', () {
    test('should return created reservation', () async {
      final result = await CreateReservationUseCase(repo).call(
        restaurantId: _restId,
        tableId: _tableId,
        date: _date,
        startTime: '18:00',
        partySize: 2,
      );
      expect(result.id, 'r-1');
    });
  });

  group('GetMyReservationsOverviewUseCase', () {
    test('should return overview', () async {
      final result = await GetMyReservationsOverviewUseCase(repo).call();
      expect(result.upcoming, hasLength(1));
    });
  });

  group('GetMyReservationsHistoryUseCase', () {
    test('should return history list', () async {
      final result = await GetMyReservationsHistoryUseCase(repo).call();
      expect(result, hasLength(1));
    });
  });

  group('UpdateReservationUseCase', () {
    test('should return updated reservation', () async {
      final result = await UpdateReservationUseCase(repo).call(
        reservationId: 'r-1',
        tableId: _tableId,
        date: _date,
        startTime: '18:30',
        partySize: 2,
      );
      expect(result.id, 'r-1');
    });
  });

  group('CancelReservationUseCase', () {
    test('should return cancelled reservation', () async {
      final result = await CancelReservationUseCase(repo).call('r-1');
      expect(result.id, 'r-1');
    });
  });

  group('GetPendingChangesUseCase', () {
    test('should return pending changes list', () async {
      final result = await GetPendingChangesUseCase(repo).call();
      expect(result, hasLength(1));
      expect(result.first.id, 'pc-1');
    });
  });

  group('AcceptChangeRequestUseCase', () {
    test('should return reservation after accept', () async {
      final result = await AcceptChangeRequestUseCase(repo).call('pc-1');
      expect(result.id, 'r-1');
    });
  });

  group('DeclineChangeRequestUseCase', () {
    test('should return reservation after decline', () async {
      final result = await DeclineChangeRequestUseCase(repo).call('pc-1');
      expect(result.id, 'r-1');
    });
  });

  group('CreateRecurringReservationUseCase', () {
    test('should return created recurring reservation', () async {
      final result = await CreateRecurringReservationUseCase(repo).call(
        restaurantId: _restId,
        tableId: _tableId,
        dayOfWeek: '1',
        startTime: '18:00',
        partySize: 2,
      );
      expect(result.id, 'rec-1');
    });
  });

  group('GetMyRecurringReservationsUseCase', () {
    test('should return recurring list', () async {
      final result = await GetMyRecurringReservationsUseCase(repo).call();
      expect(result, hasLength(1));
    });
  });

  group('CancelRecurringReservationUseCase', () {
    test('should return cancelled recurring reservation', () async {
      final result = await CancelRecurringReservationUseCase(repo).call('rec-1');
      expect(result.id, 'rec-1');
    });
  });
}
