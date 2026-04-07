import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:checkfood_client/modules/reservation/domain/entities/available_slots.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/reservation.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/reservation_scene.dart';
import 'package:checkfood_client/modules/reservation/domain/entities/table_status.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_available_slots_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_reservation_scene_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_table_statuses_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/reservation_bloc.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/reservation_event.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/reservation_state.dart';

// ── Mocks ────────────────────────────────────────────────────────────────

class MockGetReservationSceneUseCase extends Mock
    implements GetReservationSceneUseCase {}

class MockGetTableStatusesUseCase extends Mock
    implements GetTableStatusesUseCase {}

class MockGetAvailableSlotsUseCase extends Mock
    implements GetAvailableSlotsUseCase {}

class MockCreateReservationUseCase extends Mock
    implements CreateReservationUseCase {}

// ── Test Data ────────────────────────────────────────────────────────────

const _restaurantId = 'rest-001';
const _tableId = 'table-001';
const _date = '2026-03-10';

const _scene = ReservationScene(
  restaurantId: _restaurantId,
  panoramaUrl: '/panoramas/test.jpg',
  tables: [
    SceneTable(
      tableId: _tableId,
      label: 'T1',
      yaw: 0.5,
      pitch: -0.1,
      capacity: 4,
    ),
    SceneTable(
      tableId: 'table-002',
      label: 'T2',
      yaw: 1.2,
      pitch: 0.0,
      capacity: 2,
    ),
  ],
);

const _statusList = TableStatusList(
  date: _date,
  tables: [
    TableStatus(tableId: _tableId, status: 'FREE'),
    TableStatus(tableId: 'table-002', status: 'RESERVED'),
  ],
);

const _slots = AvailableSlots(
  date: _date,
  tableId: _tableId,
  slotMinutes: 30,
  durationMinutes: 90,
  availableStartTimes: ['10:00', '10:30', '11:00', '11:30', '12:00'],
);

const _reservation = Reservation(
  id: 'res-001',
  restaurantId: _restaurantId,
  tableId: _tableId,
  date: _date,
  startTime: '10:00',
  endTime: '11:30',
  status: 'RESERVED',
  partySize: 2,
);

// ── Tests ────────────────────────────────────────────────────────────────

void main() {
  late MockGetReservationSceneUseCase mockGetScene;
  late MockGetTableStatusesUseCase mockGetStatuses;
  late MockGetAvailableSlotsUseCase mockGetSlots;
  late MockCreateReservationUseCase mockCreateReservation;

  setUp(() {
    mockGetScene = MockGetReservationSceneUseCase();
    mockGetStatuses = MockGetTableStatusesUseCase();
    mockGetSlots = MockGetAvailableSlotsUseCase();
    mockCreateReservation = MockCreateReservationUseCase();

    // Default stubs — individual tests override as needed
    when(() => mockGetStatuses.call(any(), any()))
        .thenAnswer((_) async => _statusList);
    when(() => mockGetSlots.call(any(), any(), any()))
        .thenAnswer((_) async => _slots);
  });

  ReservationBloc buildBloc() => ReservationBloc(
        getSceneUseCase: mockGetScene,
        getStatusesUseCase: mockGetStatuses,
        getSlotsUseCase: mockGetSlots,
        createReservationUseCase: mockCreateReservation,
      );

  group('initial state', () {
    test('has correct defaults', () {
      final bloc = buildBloc();
      final state = bloc.state;

      expect(state.sceneLoading, false);
      expect(state.scene, isNull);
      expect(state.sceneError, isNull);
      expect(state.selectedTableId, isNull);
      expect(state.submitting, false);
      expect(state.submitSuccess, false);
      expect(state.submitConflict, false);
      expect(state.canSubmit, false);

      bloc.close();
    });
  });

  // ── LoadScene ────────────────────────────────────────────────────────

  group('LoadScene', () {
    blocTest<ReservationBloc, ReservationState>(
      'emits sceneLoading then scene on success',
      build: () {
        when(() => mockGetScene.call(_restaurantId))
            .thenAnswer((_) async => _scene);
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const ReservationEvent.loadScene(restaurantId: _restaurantId),
      ),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // 1) loading started
        isA<ReservationState>()
            .having((s) => s.sceneLoading, 'sceneLoading', true)
            .having((s) => s.sceneError, 'sceneError', isNull),
        // 2) scene loaded
        isA<ReservationState>()
            .having((s) => s.sceneLoading, 'sceneLoading', false)
            .having((s) => s.scene, 'scene', _scene),
        // 3) statuses loaded (auto-triggered by LoadScene)
        isA<ReservationState>()
            .having((s) => s.tableStatuses, 'tableStatuses', isNotEmpty),
      ],
      verify: (_) {
        verify(() => mockGetScene.call(_restaurantId)).called(1);
        verify(() => mockGetStatuses.call(_restaurantId, any())).called(1);
      },
    );

    blocTest<ReservationBloc, ReservationState>(
      'emits sceneError on failure',
      build: () {
        when(() => mockGetScene.call(_restaurantId))
            .thenThrow(Exception('Network error'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const ReservationEvent.loadScene(restaurantId: _restaurantId),
      ),
      expect: () => [
        isA<ReservationState>()
            .having((s) => s.sceneLoading, 'sceneLoading', true),
        isA<ReservationState>()
            .having((s) => s.sceneLoading, 'sceneLoading', false)
            .having((s) => s.sceneError, 'sceneError', isNotNull),
      ],
    );
  });

  // ── SelectTable ──────────────────────────────────────────────────────

  group('SelectTable', () {
    blocTest<ReservationBloc, ReservationState>(
      'sets selectedTable and triggers slot loading',
      build: () {
        when(() => mockGetScene.call(_restaurantId))
            .thenAnswer((_) async => _scene);
        return buildBloc();
      },
      seed: () => const ReservationState(
        selectedDate: _date,
        scene: _scene,
      ),
      act: (bloc) {
        // Set restaurantId by loading scene first, then select table
        bloc.add(const ReservationEvent.loadScene(restaurantId: _restaurantId));
        // Wait for scene to load, then select table
        Future.delayed(const Duration(milliseconds: 50), () {
          bloc.add(const ReservationEvent.selectTable(
            tableId: _tableId,
            label: 'T1',
            capacity: 4,
          ));
        });
      },
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        // Verify slots were loaded for the selected table
        verify(() => mockGetSlots.call(_restaurantId, _tableId, any()))
            .called(greaterThanOrEqualTo(1));

        // Verify the final state has table selected + slots
        expect(bloc.state.selectedTableId, _tableId);
        expect(bloc.state.selectedTableLabel, 'T1');
        expect(bloc.state.selectedTableCapacity, 4);
        expect(bloc.state.availableSlots, isNotNull);
      },
    );
  });

  // ── ChangeDate ───────────────────────────────────────────────────────

  group('ChangeDate', () {
    blocTest<ReservationBloc, ReservationState>(
      'updates date and reloads statuses + slots for selected table',
      build: () {
        when(() => mockGetScene.call(_restaurantId))
            .thenAnswer((_) async => _scene);
        return buildBloc();
      },
      act: (bloc) {
        // Load scene to set restaurantId
        bloc.add(const ReservationEvent.loadScene(restaurantId: _restaurantId));
        // Select table
        Future.delayed(const Duration(milliseconds: 50), () {
          bloc.add(const ReservationEvent.selectTable(
            tableId: _tableId,
            label: 'T1',
            capacity: 4,
          ));
        });
        // Change date
        Future.delayed(const Duration(milliseconds: 100), () {
          bloc.add(const ReservationEvent.changeDate(date: '2026-03-15'));
        });
      },
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        expect(bloc.state.selectedDate, '2026-03-15');
        // Statuses reloaded for new date
        verify(() => mockGetStatuses.call(_restaurantId, '2026-03-15'))
            .called(1);
        // Slots reloaded for selected table + new date
        verify(() => mockGetSlots.call(_restaurantId, _tableId, '2026-03-15'))
            .called(1);
      },
    );
  });

  // ── SelectTime ───────────────────────────────────────────────────────

  group('SelectTime', () {
    blocTest<ReservationBloc, ReservationState>(
      'sets selectedStartTime and enables canSubmit',
      build: buildBloc,
      seed: () => const ReservationState(
        selectedDate: _date,
        scene: _scene,
        selectedTableId: _tableId,
        selectedTableLabel: 'T1',
        selectedTableCapacity: 4,
        availableSlots: _slots,
      ),
      act: (bloc) =>
          bloc.add(const ReservationEvent.selectTime(startTime: '10:00')),
      expect: () => [
        isA<ReservationState>()
            .having((s) => s.selectedStartTime, 'selectedStartTime', '10:00')
            .having((s) => s.canSubmit, 'canSubmit', true),
      ],
    );
  });

  // ── SubmitReservation ────────────────────────────────────────────────

  group('SubmitReservation', () {
    blocTest<ReservationBloc, ReservationState>(
      'emits submitSuccess on successful creation',
      build: () {
        when(() => mockGetScene.call(_restaurantId))
            .thenAnswer((_) async => _scene);
        when(() => mockCreateReservation.call(
              restaurantId: any(named: 'restaurantId'),
              tableId: any(named: 'tableId'),
              date: any(named: 'date'),
              startTime: any(named: 'startTime'),
              partySize: any(named: 'partySize'),
            )).thenAnswer((_) async => _reservation);
        return buildBloc();
      },
      act: (bloc) {
        // Setup: load scene → select table → select time → submit
        bloc.add(const ReservationEvent.loadScene(restaurantId: _restaurantId));
        Future.delayed(const Duration(milliseconds: 50), () {
          bloc.add(const ReservationEvent.selectTable(
            tableId: _tableId,
            label: 'T1',
            capacity: 4,
          ));
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          bloc.add(const ReservationEvent.selectTime(startTime: '10:00'));
        });
        Future.delayed(const Duration(milliseconds: 150), () {
          bloc.add(const ReservationEvent.submitReservation());
        });
      },
      wait: const Duration(milliseconds: 400),
      verify: (bloc) {
        verify(() => mockCreateReservation.call(
              restaurantId: _restaurantId,
              tableId: _tableId,
              date: any(named: 'date'),
              startTime: '10:00',
              partySize: any(named: 'partySize'),
            )).called(1);
        expect(bloc.state.submitSuccess, true);
        expect(bloc.state.submitting, false);
      },
    );

    blocTest<ReservationBloc, ReservationState>(
      'emits submitConflict on 409 and refreshes slots',
      build: () {
        when(() => mockGetScene.call(_restaurantId))
            .thenAnswer((_) async => _scene);
        when(() => mockCreateReservation.call(
              restaurantId: any(named: 'restaurantId'),
              tableId: any(named: 'tableId'),
              date: any(named: 'date'),
              startTime: any(named: 'startTime'),
              partySize: any(named: 'partySize'),
            )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/api/v1/reservations'),
          response: Response(
            statusCode: 409,
            requestOptions: RequestOptions(path: '/api/v1/reservations'),
            data: {'code': 'SLOT_CONFLICT', 'message': 'Slot conflict'},
          ),
          type: DioExceptionType.badResponse,
        ));
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(const ReservationEvent.loadScene(restaurantId: _restaurantId));
        Future.delayed(const Duration(milliseconds: 50), () {
          bloc.add(const ReservationEvent.selectTable(
            tableId: _tableId,
            label: 'T1',
            capacity: 4,
          ));
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          bloc.add(const ReservationEvent.selectTime(startTime: '10:00'));
        });
        Future.delayed(const Duration(milliseconds: 150), () {
          bloc.add(const ReservationEvent.submitReservation());
        });
      },
      wait: const Duration(milliseconds: 400),
      verify: (bloc) {
        expect(bloc.state.submitConflict, true);
        expect(bloc.state.submitting, false);
        // Slots should have been refreshed after conflict
        // (at least 2 calls: initial select + post-conflict refresh)
        verify(() => mockGetSlots.call(_restaurantId, _tableId, any()))
            .called(greaterThanOrEqualTo(2));
      },
    );

    blocTest<ReservationBloc, ReservationState>(
      'emits submitError on non-409 DioException',
      build: () {
        when(() => mockGetScene.call(_restaurantId))
            .thenAnswer((_) async => _scene);
        when(() => mockCreateReservation.call(
              restaurantId: any(named: 'restaurantId'),
              tableId: any(named: 'tableId'),
              date: any(named: 'date'),
              startTime: any(named: 'startTime'),
              partySize: any(named: 'partySize'),
            )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/api/v1/reservations'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/api/v1/reservations'),
            data: {'message': 'Internal server error'},
          ),
          type: DioExceptionType.badResponse,
        ));
        return buildBloc();
      },
      act: (bloc) {
        bloc.add(const ReservationEvent.loadScene(restaurantId: _restaurantId));
        Future.delayed(const Duration(milliseconds: 50), () {
          bloc.add(const ReservationEvent.selectTable(
            tableId: _tableId,
            label: 'T1',
            capacity: 4,
          ));
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          bloc.add(const ReservationEvent.selectTime(startTime: '10:00'));
        });
        Future.delayed(const Duration(milliseconds: 150), () {
          bloc.add(const ReservationEvent.submitReservation());
        });
      },
      wait: const Duration(milliseconds: 400),
      verify: (bloc) {
        expect(bloc.state.submitError, 'Internal server error');
        expect(bloc.state.submitConflict, false);
        expect(bloc.state.submitting, false);
      },
    );

    blocTest<ReservationBloc, ReservationState>(
      'does nothing if no table or time selected',
      build: buildBloc,
      seed: () => ReservationState(selectedDate: _date),
      act: (bloc) =>
          bloc.add(const ReservationEvent.submitReservation()),
      expect: () => <ReservationState>[],
      verify: (_) {
        verifyNever(() => mockCreateReservation.call(
              restaurantId: any(named: 'restaurantId'),
              tableId: any(named: 'tableId'),
              date: any(named: 'date'),
              startTime: any(named: 'startTime'),
              partySize: any(named: 'partySize'),
            ));
      },
    );
  });
}
