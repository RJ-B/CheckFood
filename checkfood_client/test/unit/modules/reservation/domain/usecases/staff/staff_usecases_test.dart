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

// ── Fake repository ─────────────────────────────────────────────────────────

const _restId = 'rest-1';
const _date = '2026-06-01';

final _res = StaffReservation(
  id: 'sr-1',
  tableId: 'tbl-1',
  tableLabel: 'T1',
  userId: 42,
  date: _date,
  startTime: '18:00:00',
  partySize: 2,
  status: 'RESERVED',
  createdAt: '2026-05-01T10:00:00',
  canConfirm: true,
  canReject: true,
  canCheckIn: false,
  canComplete: false,
);

const _table = StaffTable(id: 'tbl-1', label: 'T1', capacity: 4, active: true);

class _FakeStaffRepo implements StaffReservationRepository {
  bool confirmCalled = false;
  bool rejectCalled = false;
  bool checkInCalled = false;
  bool completeCalled = false;
  String? lastProposedStartTime;
  String? lastProposedTableId;
  String? lastExtendedEndTime;

  @override
  Future<List<StaffReservation>> getReservations(String date, {String? restaurantId}) async => [_res];

  @override
  Future<void> confirmReservation(String id) async => confirmCalled = true;

  @override
  Future<void> rejectReservation(String id) async => rejectCalled = true;

  @override
  Future<void> checkInReservation(String id) async => checkInCalled = true;

  @override
  Future<void> completeReservation(String id) async => completeCalled = true;

  @override
  Future<List<StaffTable>> getRestaurantTables({String? restaurantId}) async => [_table];

  @override
  Future<void> proposeChange(String reservationId, {String? startTime, String? tableId}) async {
    lastProposedStartTime = startTime;
    lastProposedTableId = tableId;
  }

  @override
  Future<void> extendReservation(String reservationId, String endTime) async {
    lastExtendedEndTime = endTime;
  }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late _FakeStaffRepo repo;

  setUp(() => repo = _FakeStaffRepo());

  group('GetStaffReservationsUseCase', () {
    test('should return list for given date', () async {
      final result = await GetStaffReservationsUseCase(repo).call(_date);
      expect(result, hasLength(1));
      expect(result.first.id, 'sr-1');
    });

    test('should pass restaurantId to repository', () async {
      final result = await GetStaffReservationsUseCase(repo)
          .call(_date, restaurantId: _restId);
      expect(result.isNotEmpty, isTrue);
    });
  });

  group('ConfirmReservationUseCase', () {
    test('should call repository confirm', () async {
      await ConfirmReservationUseCase(repo).call('sr-1');
      expect(repo.confirmCalled, isTrue);
    });
  });

  group('RejectReservationUseCase', () {
    test('should call repository reject', () async {
      await RejectReservationUseCase(repo).call('sr-1');
      expect(repo.rejectCalled, isTrue);
    });
  });

  group('CheckInReservationUseCase', () {
    test('should call repository checkIn', () async {
      await CheckInReservationUseCase(repo).call('sr-1');
      expect(repo.checkInCalled, isTrue);
    });
  });

  group('CompleteReservationUseCase', () {
    test('should call repository complete', () async {
      await CompleteReservationUseCase(repo).call('sr-1');
      expect(repo.completeCalled, isTrue);
    });
  });

  group('GetRestaurantTablesUseCase', () {
    test('should return tables list', () async {
      final result = await GetRestaurantTablesUseCase(repo).call();
      expect(result, hasLength(1));
      expect(result.first.label, 'T1');
    });

    test('should pass restaurantId when provided', () async {
      final result = await GetRestaurantTablesUseCase(repo).call(restaurantId: _restId);
      expect(result.isNotEmpty, isTrue);
    });
  });

  group('ProposeChangeUseCase', () {
    test('should delegate to repository with correct args', () async {
      await ProposeChangeUseCase(repo).call('sr-1', startTime: '19:00', tableId: 'tbl-2');
      expect(repo.lastProposedStartTime, '19:00');
      expect(repo.lastProposedTableId, 'tbl-2');
    });

    test('should work with only startTime', () async {
      await ProposeChangeUseCase(repo).call('sr-1', startTime: '20:00');
      expect(repo.lastProposedStartTime, '20:00');
      expect(repo.lastProposedTableId, isNull);
    });
  });

  group('ExtendReservationUseCase', () {
    test('should delegate to repository with endTime', () async {
      await ExtendReservationUseCase(repo).call('sr-1', '21:00');
      expect(repo.lastExtendedEndTime, '21:00');
    });
  });
}
