// ignore_for_file: lines_longer_than_80_chars
//
// Run with: flutter test --update-goldens
// Golden files are stored at: test/golden/modules/reservation/goldens/
//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
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
import 'package:checkfood_client/modules/reservation/domain/usecases/decline_change_request_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_available_slots_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_recurring_reservations_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_reservations_history_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_my_reservations_overview_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_pending_changes_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/get_reservation_scene_usecase.dart';
import 'package:checkfood_client/modules/reservation/domain/usecases/update_reservation_usecase.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/my_reservations_bloc.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/bloc/my_reservations_state.dart';
import 'package:checkfood_client/modules/reservation/presentation/customer/pages/reservations_screen.dart';

// ── Test data ─────────────────────────────────────────────────────────────────

const _restId = 'rest-1';
const _tableId = 'tbl-1';
const _date = '2026-06-01';

const _upcomingRes = Reservation(
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
  restaurantName: 'Test Bistro',
  tableLabel: 'T1',
  date: '2026-05-01',
  startTime: '12:00',
  status: 'COMPLETED',
  partySize: 2,
);

// ── Fake repo ─────────────────────────────────────────────────────────────────

class _FakeRepo implements ReservationRepository {
  final MyReservationsOverview overview;
  _FakeRepo(this.overview);

  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async => overview;
  @override
  Future<List<Reservation>> getMyReservationsHistory() async => overview.history;
  @override
  Future<Reservation> cancelReservation(String id) async => _historyRes;
  @override
  Future<Reservation> updateReservation({required String reservationId, required String tableId, required String date, required String startTime, int partySize = 2}) async => _upcomingRes;
  @override
  Future<List<PendingChange>> getPendingChanges() async => [];
  @override
  Future<Reservation> acceptChangeRequest(String id) async => _upcomingRes;
  @override
  Future<Reservation> declineChangeRequest(String id) async => _upcomingRes;
  @override
  Future<RecurringReservation> createRecurringReservation({required String restaurantId, required String tableId, required String dayOfWeek, required String startTime, int partySize = 2}) async =>
      const RecurringReservation(id: 'rec-1', restaurantId: _restId, tableId: _tableId, dayOfWeek: '1', startTime: '18:00', partySize: 2, status: 'ACTIVE', createdAt: '2026-05-01T10:00:00');
  @override
  Future<List<RecurringReservation>> getMyRecurringReservations() async => [];
  @override
  Future<RecurringReservation> cancelRecurringReservation(String id) async =>
      const RecurringReservation(id: 'rec-1', restaurantId: _restId, tableId: _tableId, dayOfWeek: '1', startTime: '18:00', partySize: 2, status: 'CANCELLED', createdAt: '2026-05-01T10:00:00');
  @override
  Future<ReservationScene> getReservationScene(String restaurantId) async =>
      const ReservationScene(restaurantId: _restId, panoramaUrl: null, tables: []);
  @override
  Future<TableStatusList> getTableStatuses(String restaurantId, String date) async =>
      const TableStatusList(date: _date, tables: []);
  @override
  Future<AvailableSlots> getAvailableSlots(String restaurantId, String tableId, String date, {String? excludeReservationId}) async =>
      const AvailableSlots(date: _date, tableId: _tableId, slotMinutes: 30, durationMinutes: 90, availableStartTimes: []);
  @override
  Future<Reservation> createReservation({required String restaurantId, required String tableId, required String date, required String startTime, int partySize = 2}) async => _upcomingRes;
}

// ── Helper ────────────────────────────────────────────────────────────────────

MyReservationsBloc _makeBloc(_FakeRepo repo) => MyReservationsBloc(
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

Widget _buildApp(MyReservationsBloc bloc, {ThemeMode themeMode = ThemeMode.light}) =>
    MultiBlocProvider(
      providers: [
        BlocProvider<MyReservationsBloc>.value(value: bloc),
      ],
      child: MaterialApp(
        themeMode: themeMode,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
        home: const ReservationsScreen(),
      ),
    );

// ── Golden tests ──────────────────────────────────────────────────────────────

void main() {
  // Pin viewport to avoid host-dpi variance
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('ReservationsScreen golden', () {
    testWidgets('reservations_screen_loading_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = _FakeRepo(const MyReservationsOverview(upcoming: [], history: [], totalHistoryCount: 0));
      final bloc = _makeBloc(repo);
      addTearDown(bloc.close);

      await tester.pumpWidget(_buildApp(bloc));
      // First pump — isLoading=true spinner visible
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/reservations_screen_loading_light.png'),
      );
    });

    testWidgets('reservations_screen_empty_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = _FakeRepo(const MyReservationsOverview(upcoming: [], history: [], totalHistoryCount: 0));
      final bloc = _makeBloc(repo);
      addTearDown(bloc.close);

      await tester.pumpWidget(_buildApp(bloc));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/reservations_screen_empty_light.png'),
      );
    });

    testWidgets('reservations_screen_loaded_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = _FakeRepo(const MyReservationsOverview(
        upcoming: [_upcomingRes],
        history: [_historyRes],
        totalHistoryCount: 1,
      ));
      final bloc = _makeBloc(repo);
      addTearDown(bloc.close);

      await tester.pumpWidget(_buildApp(bloc));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/reservations_screen_loaded_light.png'),
      );
    });

    testWidgets('reservations_screen_loaded_dark', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = _FakeRepo(const MyReservationsOverview(
        upcoming: [_upcomingRes],
        history: [_historyRes],
        totalHistoryCount: 1,
      ));
      final bloc = _makeBloc(repo);
      addTearDown(bloc.close);

      await tester.pumpWidget(_buildApp(bloc, themeMode: ThemeMode.dark));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/reservations_screen_loaded_dark.png'),
      );
    });

    testWidgets('reservations_screen_empty_dark', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repo = _FakeRepo(const MyReservationsOverview(upcoming: [], history: [], totalHistoryCount: 0));
      final bloc = _makeBloc(repo);
      addTearDown(bloc.close);

      await tester.pumpWidget(_buildApp(bloc, themeMode: ThemeMode.dark));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/reservations_screen_empty_dark.png'),
      );
    });

    testWidgets('reservations_screen_error_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      // Use a repo that throws so the bloc ends in error state
      final repo = _ThrowingRepo();
      final bloc = _makeBloc(repo);
      addTearDown(bloc.close);

      await tester.pumpWidget(_buildApp(bloc));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/reservations_screen_error_light.png'),
      );
    });
  });
}

class _ThrowingRepo extends _FakeRepo {
  _ThrowingRepo() : super(const MyReservationsOverview(upcoming: [], history: [], totalHistoryCount: 0));

  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async {
    throw Exception('network error');
  }
}
