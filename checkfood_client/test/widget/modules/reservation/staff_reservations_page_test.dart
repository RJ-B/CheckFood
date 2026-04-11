// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/l10n/generated/app_localizations.dart';
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
import 'package:checkfood_client/modules/reservation/presentation/staff/presentation/pages/staff_reservations_page.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/presentation/bloc/my_restaurant_bloc.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/repositories/my_restaurant_repository.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/get_my_restaurant_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/get_my_restaurants_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/update_restaurant_info_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/get_employees_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/add_employee_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/update_employee_role_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/remove_employee_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/update_employee_permissions_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/data/models/request/add_employee_request_model.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/data/models/request/update_employee_role_request_model.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/data/models/request/update_restaurant_request_model.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/entities/employee.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/entities/my_restaurant.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/address.dart';

// ── Test data ────────────────────────────────────────────────────────────────

const _date = '2026-06-01';
const _restId = 'rest-1';

StaffReservation _makeRes({
  String id = 'sr-1',
  String status = 'RESERVED',
  bool canConfirm = true,
  bool canReject = true,
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
      canCheckIn: false,
      canComplete: false,
    );

const _table = StaffTable(id: 'tbl-1', label: 'T1', capacity: 4, active: true);

// ── Fake repositories ────────────────────────────────────────────────────────

class _FakeStaffRepo implements StaffReservationRepository {
  List<StaffReservation> reservations;
  bool getThrows;

  _FakeStaffRepo({List<StaffReservation>? reservations, this.getThrows = false})
      : reservations = reservations ?? [_makeRes()];

  @override
  Future<List<StaffReservation>> getReservations(String date, {String? restaurantId}) async {
    if (getThrows) throw Exception('network error');
    return reservations;
  }

  @override
  Future<void> confirmReservation(String id) async {}
  @override
  Future<void> rejectReservation(String id) async {}
  @override
  Future<void> checkInReservation(String id) async {}
  @override
  Future<void> completeReservation(String id) async {}
  @override
  Future<List<StaffTable>> getRestaurantTables({String? restaurantId}) async => [_table];
  @override
  Future<void> proposeChange(String reservationId, {String? startTime, String? tableId}) async {}
  @override
  Future<void> extendReservation(String reservationId, String endTime) async {}
}

class _FakeMyRestaurantRepo implements MyRestaurantRepository {
  @override
  Future<List<MyRestaurant>> getMyRestaurants() async => [];
  @override
  Future<MyRestaurant> getMyRestaurant({String? restaurantId}) async =>
      MyRestaurant(
        id: _restId,
        name: 'Test Bistro',
        description: '',
        address: const Address(street: '', city: '', country: ''),
        openingHours: [],
        status: 'ACTIVE',
        isActive: true,
      );
  @override
  Future<MyRestaurant> updateMyRestaurant(UpdateRestaurantRequestModel request, {String? restaurantId}) async =>
      getMyRestaurant();
  @override
  Future<List<Employee>> getEmployees({String? restaurantId}) async => [];
  @override
  Future<Employee> addEmployee(AddEmployeeRequestModel request, {String? restaurantId}) async =>
      const Employee(id: 1, userId: 1, name: '', email: '', role: 'STAFF');
  @override
  Future<Employee> updateEmployeeRole(int employeeId, UpdateEmployeeRoleRequestModel request, {String? restaurantId}) async =>
      const Employee(id: 1, userId: 1, name: '', email: '', role: 'STAFF');
  @override
  Future<void> removeEmployee(int employeeId, {String? restaurantId}) async {}
  @override
  Future<List<String>> getEmployeePermissions(int employeeId, {String? restaurantId}) async => [];
  @override
  Future<List<String>> updateEmployeePermissions(int employeeId, List<String> permissions, {String? restaurantId}) async => permissions;
}

// ── Bloc factories ────────────────────────────────────────────────────────────

StaffReservationsBloc _makeStaffBloc(_FakeStaffRepo repo) =>
    StaffReservationsBloc(
      getReservations: GetStaffReservationsUseCase(repo),
      confirm: ConfirmReservationUseCase(repo),
      reject: RejectReservationUseCase(repo),
      checkIn: CheckInReservationUseCase(repo),
      complete: CompleteReservationUseCase(repo),
      getTables: GetRestaurantTablesUseCase(repo),
      proposeChange: ProposeChangeUseCase(repo),
      extendReservation: ExtendReservationUseCase(repo),
    );

MyRestaurantBloc _makeMyRestaurantBloc() {
  final repo = _FakeMyRestaurantRepo();
  return MyRestaurantBloc(
    getMyRestaurantUseCase: GetMyRestaurantUseCase(repo),
    getMyRestaurantsUseCase: GetMyRestaurantsUseCase(repo),
    updateRestaurantInfoUseCase: UpdateRestaurantInfoUseCase(repo),
    getEmployeesUseCase: GetEmployeesUseCase(repo),
    addEmployeeUseCase: AddEmployeeUseCase(repo),
    updateEmployeeRoleUseCase: UpdateEmployeeRoleUseCase(repo),
    removeEmployeeUseCase: RemoveEmployeeUseCase(repo),
    updateEmployeePermissionsUseCase: UpdateEmployeePermissionsUseCase(repo),
  );
}

Future<void> _pump(
  WidgetTester tester,
  StaffReservationsBloc staffBloc, {
  MyRestaurantBloc? myRestBloc,
  String locale = 'en',
  ThemeMode themeMode = ThemeMode.light,
  Size? screenSize,
}) async {
  if (screenSize != null) {
    tester.view.physicalSize = screenSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
  }

  final myBloc = myRestBloc ?? _makeMyRestaurantBloc();

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<StaffReservationsBloc>.value(value: staffBloc),
        BlocProvider<MyRestaurantBloc>.value(value: myBloc),
      ],
      child: MaterialApp(
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
        home: const Scaffold(body: StaffReservationsPage()),
      ),
    ),
  );
}

/// Settle the staff widget tree after pump.
///
/// [StaffReservationsPage.initState] calls [StaffReservationsBloc.startPolling]
/// which schedules a periodic [Timer].  [pumpAndSettle] never returns because
/// the timer keeps firing.
///
/// Strategy: use [tester.runAsync] to escape the fake clock, wait for the
/// bloc's first non-loading state, then stop polling and pump one frame so
/// the widget tree rebuilds.
Future<void> _settle(WidgetTester tester, StaffReservationsBloc staffBloc) async {
  await tester.runAsync(() async {
    await staffBloc.stream
        .firstWhere((s) => !s.isLoading)
        .timeout(const Duration(seconds: 5), onTimeout: () => staffBloc.state);
  });
  staffBloc.stopPolling(); // cancel the periodic timer
  await tester.pump(); // flush widget rebuild
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late _FakeStaffRepo repo;
  late StaffReservationsBloc bloc;

  setUp(() {
    repo = _FakeStaffRepo();
    bloc = _makeStaffBloc(repo);
  });

  tearDown(() => bloc.close());

  // ── Loading state ──────────────────────────────────────────────────────────

  group('Loading state', () {
    testWidgets('should show spinner when loading and no reservations', (tester) async {
      // Trigger load so isLoading=true is in flight when widget mounts
      bloc.add(LoadStaffReservations(_date));
      await _pump(tester, bloc);
      // Before settle: isLoading=true → spinner visible
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Must settle to stop the polling timer before test ends
      await _settle(tester, bloc);
    });
  });

  // ── Error state ────────────────────────────────────────────────────────────

  group('Error state', () {
    testWidgets('page stays mounted when load fails', (tester) async {
      final errorRepo = _FakeStaffRepo(getThrows: true);
      final errorBloc = _makeStaffBloc(errorRepo);
      addTearDown(errorBloc.close);

      await _pump(tester, errorBloc);
      await _settle(tester, errorBloc);

      expect(find.byType(StaffReservationsPage), findsOneWidget);
    });
  });

  // ── Daily list view ────────────────────────────────────────────────────────

  group('Daily list view', () {
    testWidgets('shows reservation with user name when list view is active', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      // Switch to list view by tapping list toggle icon if present
      final toggleButton = find.byIcon(Icons.list);
      if (toggleButton.evaluate().isNotEmpty) {
        await tester.tap(toggleButton.first);
        await tester.pump();
      }

      expect(find.text('Jan Novak'), findsWidgets);
    });

    testWidgets('shows "Žádné rezervace" text when list is empty', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      // Switch to list view
      final toggleButton = find.byIcon(Icons.list);
      if (toggleButton.evaluate().isNotEmpty) {
        await tester.tap(toggleButton.first);
        await tester.pump();
      }

      expect(find.textContaining('Žádné rezervace'), findsOneWidget);
    });

    testWidgets('tapping reservation opens detail or bottom sheet', (tester) async {
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      // Switch to list view
      final toggleButton = find.byIcon(Icons.list);
      if (toggleButton.evaluate().isNotEmpty) {
        await tester.tap(toggleButton.first);
        await tester.pump();
      }

      final cards = find.byType(Card);
      if (cards.evaluate().isNotEmpty) {
        await tester.tap(cards.first);
        await tester.pump();
        // Either BottomSheet or AlertDialog should be present
        final hasSheet = find.byType(BottomSheet).evaluate().isNotEmpty;
        final hasDialog = find.byType(AlertDialog).evaluate().isNotEmpty;
        expect(hasSheet || hasDialog, isTrue);
      }
    });
  });

  // ── Date navigation ────────────────────────────────────────────────────────

  group('Date navigation', () {
    testWidgets('chevron_right moves date forward without crash', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pump();

      expect(find.byType(StaffReservationsPage), findsOneWidget);
    });

    testWidgets('chevron_left moves date back without crash', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pump();

      expect(find.byType(StaffReservationsPage), findsOneWidget);
    });
  });

  // ── Locale: Czech ─────────────────────────────────────────────────────────

  group('Czech locale', () {
    testWidgets('renders without exception in Czech', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc, locale: 'cs');
      await _settle(tester, bloc);

      expect(tester.takeException(), isNull);
    });
  });

  // ── Locale: English ───────────────────────────────────────────────────────

  group('English locale', () {
    testWidgets('renders without exception in English', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc, locale: 'en');
      await _settle(tester, bloc);

      expect(tester.takeException(), isNull);
    });
  });

  // ── Dark theme ─────────────────────────────────────────────────────────────

  group('Dark theme', () {
    testWidgets('renders without exception in dark mode', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc, themeMode: ThemeMode.dark);
      await _settle(tester, bloc);

      expect(tester.takeException(), isNull);
    });
  });

  // ── Multi-size ─────────────────────────────────────────────────────────────

  group('Multi-size layout', () {
    for (final entry in {
      'phone 390x844': const Size(390, 844),
      'small 360x640': const Size(360, 640),
      'tablet 820x1180': const Size(820, 1180),
    }.entries) {
      // EXPECTED-FAIL (phone/small): date row RenderFlex overflows on narrow
      // screens — production code does not yet use Flexible/Expanded on the
      // date navigation row.  Tablet passes.
      testWidgets('renders without overflow on ${entry.key}', (tester) async {
        final sizedRepo = _FakeStaffRepo(reservations: []);
        final sizedBloc = _makeStaffBloc(sizedRepo);
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
      repo.reservations = [];
      final myBloc = _makeMyRestaurantBloc();
      addTearDown(myBloc.close);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<StaffReservationsBloc>.value(value: bloc),
              BlocProvider<MyRestaurantBloc>.value(value: myBloc),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.supportedLocales,
              home: const Scaffold(body: StaffReservationsPage()),
            ),
          ),
        ),
      );
      await _settle(tester, bloc);

      expect(tester.takeException(), isNull);
    });
  });

  // ── Accessibility ──────────────────────────────────────────────────────────

  group('Accessibility', () {
    testWidgets('meets android tap target guideline', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    });

    testWidgets('meets iOS tap target guideline', (tester) async {
      repo.reservations = [];
      await _pump(tester, bloc);
      await _settle(tester, bloc);

      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    });
  });

  // ── EXPECTED-FAIL: UX gaps ─────────────────────────────────────────────────

  // EXPECTED-FAIL: confirm/reject — list view cards currently only open a
  // bottom sheet on tap; there are no inline confirm/reject action buttons
  // directly on the card for quick access without opening the detail sheet.
  testWidgets('should show inline confirm/reject buttons on pending card', (tester) async {
    await _pump(tester, bloc);
    await _settle(tester, bloc);

    // Switch to list view
    final toggleButton = find.byIcon(Icons.list);
    if (toggleButton.evaluate().isNotEmpty) {
      await tester.tap(toggleButton.first);
      await tester.pump();
    }

    // Will fail until inline confirm/reject buttons are added to staff list cards
    expect(find.text('Confirm'), findsWidgets);
    expect(find.text('Reject'), findsWidgets);
  });

  // EXPECTED-FAIL: pull-to-refresh in list view is not discoverable —
  // the RefreshIndicator exists but there is no visible swipe-to-refresh hint.
  testWidgets('list view should show pull-to-refresh indicator hint text', (tester) async {
    repo.reservations = [];
    await _pump(tester, bloc);
    await _settle(tester, bloc);

    // Switch to list view
    final toggleButton = find.byIcon(Icons.list);
    if (toggleButton.evaluate().isNotEmpty) {
      await tester.tap(toggleButton.first);
      await tester.pump();
    }

    // Will fail until a "Pull to refresh" hint is shown
    expect(find.textContaining('refresh'), findsOneWidget);
  });
}
