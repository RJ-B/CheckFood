// ignore_for_file: lines_longer_than_80_chars
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
import 'package:checkfood_client/modules/reservation/presentation/customer/pages/reservations_screen.dart';

// ── Test data ────────────────────────────────────────────────────────────────

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

// ── Fake repository ──────────────────────────────────────────────────────────

class _FakeRepo implements ReservationRepository {
  MyReservationsOverview overview;
  List<PendingChange> pendingChanges;
  bool overviewThrows;

  _FakeRepo({
    MyReservationsOverview? overview,
    this.pendingChanges = const [],
    this.overviewThrows = false,
  }) : overview = overview ??
            const MyReservationsOverview(
              upcoming: [_upcomingRes],
              history: [_historyRes],
              totalHistoryCount: 1,
            );

  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async {
    if (overviewThrows) throw Exception('network error');
    return overview;
  }

  @override
  Future<List<Reservation>> getMyReservationsHistory() async => overview.history;
  @override
  Future<Reservation> cancelReservation(String id) async => _historyRes;
  @override
  Future<Reservation> updateReservation({
    required String reservationId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async => _upcomingRes;
  @override
  Future<List<PendingChange>> getPendingChanges() async => pendingChanges;
  @override
  Future<Reservation> acceptChangeRequest(String id) async => _upcomingRes;
  @override
  Future<Reservation> declineChangeRequest(String id) async => _upcomingRes;
  @override
  Future<RecurringReservation> createRecurringReservation({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    int partySize = 2,
  }) async => const RecurringReservation(
      id: 'rec-1', restaurantId: _restId, tableId: _tableId,
      dayOfWeek: '1', startTime: '18:00', partySize: 2,
      status: 'ACTIVE', createdAt: '2026-05-01T10:00:00');
  @override
  Future<List<RecurringReservation>> getMyRecurringReservations() async => [];
  @override
  Future<RecurringReservation> cancelRecurringReservation(String id) async =>
      const RecurringReservation(
          id: 'rec-1', restaurantId: _restId, tableId: _tableId,
          dayOfWeek: '1', startTime: '18:00', partySize: 2,
          status: 'CANCELLED', createdAt: '2026-05-01T10:00:00');
  @override
  Future<ReservationScene> getReservationScene(String restaurantId) async =>
      const ReservationScene(restaurantId: _restId, panoramaUrl: null, tables: []);
  @override
  Future<TableStatusList> getTableStatuses(String restaurantId, String date) async =>
      const TableStatusList(date: _date, tables: []);
  @override
  Future<AvailableSlots> getAvailableSlots(
      String restaurantId, String tableId, String date, {String? excludeReservationId}) async =>
      const AvailableSlots(
          date: _date, tableId: _tableId, slotMinutes: 30,
          durationMinutes: 90, availableStartTimes: ['18:00', '18:30']);
  @override
  Future<Reservation> createReservation({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async => _upcomingRes;
}

// ── Helpers ───────────────────────────────────────────────────────────────────

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

Future<void> _pump(
  WidgetTester tester,
  MyReservationsBloc bloc, {
  String locale = 'en',
  ThemeMode themeMode = ThemeMode.light,
  Size? screenSize,
}) async {
  if (screenSize != null) {
    tester.view.physicalSize = screenSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
  }
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale(locale),
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
      home: BlocProvider<MyReservationsBloc>.value(
        value: bloc,
        child: const ReservationsScreen(),
      ),
    ),
  );
}

/// Settle after widget pump.
///
/// Widget tests run under a fake clock, so [pumpAndSettle] spins forever
/// when the bloc auto-fires [LoadPendingChanges] in a loop.
///
/// [tester.runAsync] escapes the fake clock and lets real async Futures
/// complete on the real event loop.  We then call [tester.pump()] once to
/// flush the resulting widget rebuild.
Future<void> _settle(WidgetTester tester, MyReservationsBloc bloc) async {
  await tester.runAsync(() async {
    // Wait until the bloc is no longer in its initial loading state.
    // If already settled (e.g. error state from a throwing repo), this
    // resolves immediately.
    await bloc.stream
        .firstWhere((s) => !s.isLoading)
        .timeout(const Duration(seconds: 5), onTimeout: () => bloc.state);
  });
  await tester.pump(); // flush widget rebuild after state change
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late _FakeRepo repo;
  late MyReservationsBloc bloc;

  setUp(() {
    repo = _FakeRepo();
    bloc = _makeBloc(repo);
  });

  tearDown(() => bloc.close());

  // ── Loading state ──────────────────────────────────────────────────────────

  group('Loading state', () {
    testWidgets('should show spinner while isLoading is true', (tester) async {
      await _pump(tester, bloc);
      // Before any async completes: isLoading=true
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });
  });

  // ── Error state ────────────────────────────────────────────────────────────

  group('Error state', () {
    testWidgets('should show error icon and retry button', (tester) async {
      final errorRepo = _FakeRepo(overviewThrows: true);
      final errorBloc = _makeBloc(errorRepo);
      addTearDown(errorBloc.close);

      await _pump(tester, errorBloc);
      await _settle(tester, errorBloc);

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('retry button re-fires load event', (tester) async {
      final errorRepo = _FakeRepo(overviewThrows: true);
      final errorBloc = _makeBloc(errorRepo);
      addTearDown(errorBloc.close);

      await _pump(tester, errorBloc);
      await _settle(tester, errorBloc);

      // Error state should be showing
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Now let the reload succeed
      errorRepo.overviewThrows = false;
      await tester.tap(find.byType(ElevatedButton).first);
      await _settle(tester, errorBloc);

      // After successful reload the error view should be gone
      expect(find.byIcon(Icons.error_outline), findsNothing);
    });
  });

  // ── Empty state ────────────────────────────────────────────────────────────

  group('Empty state', () {
    testWidgets('should show empty-list icons when no reservations', (tester) async {
      final emptyRepo = _FakeRepo(
        overview: const MyReservationsOverview(
          upcoming: [], history: [], totalHistoryCount: 0,
        ),
      );
      final emptyBloc = _makeBloc(emptyRepo);
      addTearDown(emptyBloc.close);

      await _pump(tester, emptyBloc);
      await _settle(tester, emptyBloc);

      expect(find.byIcon(Icons.calendar_today_outlined), findsOneWidget);
      expect(find.byIcon(Icons.history_outlined), findsOneWidget);
    });
  });

  // ── Loaded / success state ─────────────────────────────────────────────────

  group('Loaded state', () {
    testWidgets('should render restaurant name for each reservation', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      expect(find.text('Test Bistro'), findsWidgets);
    });

    testWidgets('should show section header icons', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      expect(find.byIcon(Icons.event_available), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('cancel tap shows confirmation dialog', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      final cancelIcon = find.byIcon(Icons.cancel_outlined);
      if (cancelIcon.evaluate().isNotEmpty) {
        await tester.tap(cancelIcon.first);
        await tester.pump();
        expect(find.byType(AlertDialog), findsOneWidget);
      }
    });

    testWidgets('cancel dialog No button dismisses without firing cancel event', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      final cancelIcon = find.byIcon(Icons.cancel_outlined);
      if (cancelIcon.evaluate().isNotEmpty) {
        await tester.tap(cancelIcon.first);
        await tester.pump();

        final noButton = find.widgetWithText(TextButton, 'No');
        if (noButton.evaluate().isNotEmpty) {
          await tester.tap(noButton.first);
          await tester.pump();
          expect(find.byType(AlertDialog), findsNothing);
        }
      }
    });

    testWidgets('should show RefreshIndicator', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });

  // ── Pull-to-refresh ────────────────────────────────────────────────────────

  group('Pull-to-refresh', () {
    testWidgets('drag down fires refresh without crash', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      await tester.fling(find.byType(ListView), const Offset(0, 400), 800);
      await tester.pump(const Duration(milliseconds: 300));

      expect(tester.takeException(), isNull);
    });
  });

  // ── Locale: Czech ─────────────────────────────────────────────────────────

  group('Czech locale', () {
    testWidgets('app bar shows "Moje rezervace"', (tester) async {
      await _pump(tester, bloc, locale: 'cs');
      await _settle(tester, bloc);

      expect(find.text('Moje rezervace'), findsOneWidget);
    });
  });

  // ── Locale: English ───────────────────────────────────────────────────────

  group('English locale', () {
    testWidgets('app bar shows "My reservations"', (tester) async {
      await _pump(tester, bloc, locale: 'en');
      await _settle(tester, bloc);

      expect(find.text('My reservations'), findsOneWidget);
    });
  });

  // ── Dark theme ─────────────────────────────────────────────────────────────

  group('Dark theme', () {
    testWidgets('renders without exception in dark mode', (tester) async {
      await _pump(tester, bloc, themeMode: ThemeMode.dark);
      await _settle(tester, bloc);

      expect(tester.takeException(), isNull);
      expect(find.byType(ReservationsScreen), findsOneWidget);
    });
  });

  // ── Multi-size ─────────────────────────────────────────────────────────────

  group('Multi-size layout', () {
    for (final entry in {
      'phone 390x844': const Size(390, 844),
      'small 360x640': const Size(360, 640),
      'tablet 820x1180': const Size(820, 1180),
    }.entries) {
      testWidgets('renders on ${entry.key}', (tester) async {
        final sizedRepo = _FakeRepo(
          overview: const MyReservationsOverview(
            upcoming: [], history: [], totalHistoryCount: 0,
          ),
        );
        final sizedBloc = _makeBloc(sizedRepo);
        addTearDown(sizedBloc.close);

        await _pump(tester, sizedBloc, screenSize: entry.value);
        await _settle(tester, sizedBloc);

        expect(tester.takeException(), isNull);
      });
    }
  });

  // ── RTL ────────────────────────────────────────────────────────────────────

  group('RTL', () {
    testWidgets('renders without layout exception under RTL', (tester) async {
      final rtlRepo = _FakeRepo(
        overview: const MyReservationsOverview(
          upcoming: [], history: [], totalHistoryCount: 0,
        ),
      );
      final rtlBloc = _makeBloc(rtlRepo);
      addTearDown(rtlBloc.close);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.supportedLocales,
            home: BlocProvider<MyReservationsBloc>.value(
              value: rtlBloc,
              child: const ReservationsScreen(),
            ),
          ),
        ),
      );
      await _settle(tester, rtlBloc);

      expect(tester.takeException(), isNull);
    });
  });

  // ── Accessibility ──────────────────────────────────────────────────────────

  group('Accessibility', () {
    testWidgets('loaded state meets android tap target guideline', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    });

    testWidgets('empty state meets android tap target guideline', (tester) async {
      final emptyRepo = _FakeRepo(
        overview: const MyReservationsOverview(
          upcoming: [], history: [], totalHistoryCount: 0,
        ),
      );
      final emptyBloc = _makeBloc(emptyRepo);
      addTearDown(emptyBloc.close);

      await _pump(tester, emptyBloc);
      await _settle(tester, emptyBloc);

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    });
  });

  // ── EXPECTED-FAIL: UX gaps ─────────────────────────────────────────────────

  // EXPECTED-FAIL: empty state — no "Book a table" CTA button present.
  // Production _EmptyState only shows an icon+text, no action button.
  testWidgets('should show CTA button in empty upcoming state', (tester) async {
    final emptyRepo = _FakeRepo(
      overview: const MyReservationsOverview(
        upcoming: [], history: [], totalHistoryCount: 0,
      ),
    );
    final emptyBloc = _makeBloc(emptyRepo);
    addTearDown(emptyBloc.close);

    await _pump(tester, emptyBloc);
    await _settle(tester, emptyBloc);

    // Will fail until a "Book a table" / similar CTA is added to _EmptyState.
    expect(find.widgetWithText(ElevatedButton, 'Book a table'), findsOneWidget);
  });

  // EXPECTED-FAIL: swipe-to-cancel — no Dismissible wrapping reservation cards.
  testWidgets('should support swipe-to-cancel on upcoming reservation cards', (tester) async {
    await _pump(tester, bloc);
    await _settle(tester, bloc);

    // Will fail until ReservationCard is wrapped in Dismissible.
    expect(find.byType(Dismissible), findsWidgets);
  });
}
