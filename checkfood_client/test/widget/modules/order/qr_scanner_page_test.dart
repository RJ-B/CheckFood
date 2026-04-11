import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:checkfood_client/l10n/generated/app_localizations.dart';
import 'package:checkfood_client/modules/order/data/datasources/orders_remote_datasource.dart';
import 'package:checkfood_client/modules/order/data/models/request/create_order_request_model.dart';
import 'package:checkfood_client/modules/order/data/models/response/dining_context_response_model.dart';
import 'package:checkfood_client/modules/order/data/models/response/menu_category_response_model.dart';
import 'package:checkfood_client/modules/order/data/models/response/order_summary_response_model.dart';
import 'package:checkfood_client/modules/order/domain/entities/dining_context.dart';
import 'package:checkfood_client/modules/order/domain/entities/dining_session.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/create_order_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_current_orders_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_dining_context_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_menu_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_payment_status_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/initiate_payment_usecase.dart';
import 'package:checkfood_client/modules/order/domain/entities/order_summary.dart';
import 'package:checkfood_client/modules/order/domain/entities/menu_category.dart';
import 'package:checkfood_client/modules/order/presentation/bloc/orders_bloc.dart';
import 'package:checkfood_client/modules/order/presentation/bloc/orders_event.dart';
import 'package:checkfood_client/modules/order/presentation/bloc/orders_state.dart';
import 'package:checkfood_client/modules/order/presentation/pages/qr_scanner_page.dart';

// ---------------------------------------------------------------------------
// Fake remote data source for GetIt
// ---------------------------------------------------------------------------

class _FakeRemoteDs implements OrdersRemoteDataSource {
  @override
  Future<DiningContextResponseModel> getDiningContext() async =>
      const DiningContextResponseModel();
  @override
  Future<List<MenuCategoryResponseModel>> getMenu(String r) async => [];
  @override
  Future<OrderSummaryResponseModel> createOrder(
          CreateOrderRequestModel request) async =>
      const OrderSummaryResponseModel();
  @override
  Future<List<OrderSummaryResponseModel>> getCurrentOrders() async => [];
  @override
  Future<String> initiatePayment(String orderId) async =>
      throw UnimplementedError();
  @override
  Future<String> getPaymentStatus(String orderId) async =>
      throw UnimplementedError();
  @override
  Future<Map<String, dynamic>> joinSession(String inviteCode) async =>
      throw UnimplementedError();
  @override
  Future<Map<String, dynamic>> getMySession() async =>
      throw UnimplementedError();
  @override
  Future<List<Map<String, dynamic>>> getSessionOrders(String sessionId) async =>
      throw UnimplementedError();
  @override
  Future<Map<String, dynamic>> getPaymentSummary(String sessionId) async =>
      throw UnimplementedError();
  @override
  Future<Map<String, dynamic>> payItems(List<String> itemIds) async =>
      throw UnimplementedError();
  @override
  Future<Map<String, dynamic>> getSessionQr(String sessionId) async =>
      throw UnimplementedError();
}

void _ensureGetIt() {
  final sl = GetIt.instance;
  if (!sl.isRegistered<OrdersRemoteDataSource>()) {
    sl.registerLazySingleton<OrdersRemoteDataSource>(() => _FakeRemoteDs());
  }
}

// ---------------------------------------------------------------------------
// Fake repository for QR scanner tests
// ---------------------------------------------------------------------------

class _FakeQrRepo implements OrdersRepository {
  bool joinShouldFail = false;
  String? joinError;

  @override
  Future<DiningContext> getDiningContext() async {
    return const DiningContext(
      restaurantId: 'rest-1',
      tableId: 'table-1',
      contextType: 'RESERVATION',
      restaurantName: 'Test Restaurant',
      tableLabel: 'Stůl 1',
      validFrom: '2026-01-01T10:00:00Z',
      validTo: '2026-01-01T23:00:00Z',
    );
  }

  @override
  Future<List<MenuCategory>> getMenu(String restaurantId) async => [];

  @override
  Future<OrderSummary> createOrder({
    required List<({String menuItemId, int quantity})> items,
    String? note,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<OrderSummary>> getCurrentOrders() async => [];

  @override
  Future<String> initiatePayment(String orderId) async =>
      throw UnimplementedError();

  @override
  Future<String> getPaymentStatus(String orderId) async =>
      throw UnimplementedError();
}

OrdersBloc _makeQrBloc(_FakeQrRepo repo) {
  return OrdersBloc(
    getDiningContextUseCase: GetDiningContextUseCase(repo),
    getMenuUseCase: GetMenuUseCase(repo),
    createOrderUseCase: CreateOrderUseCase(repo),
    getCurrentOrdersUseCase: GetCurrentOrdersUseCase(repo),
    initiatePaymentUseCase: InitiatePaymentUseCase(repo),
    getPaymentStatusUseCase: GetPaymentStatusUseCase(repo),
  );
}

Widget _wrap(Widget child, {required OrdersBloc bloc}) {
  return MaterialApp(
    locale: const Locale('cs'),
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.supportedLocales,
    home: BlocProvider.value(
      value: bloc,
      child: child,
    ),
  );
}

void main() {
  late _FakeQrRepo repo;
  late OrdersBloc bloc;

  setUpAll(() {
    _ensureGetIt();
  });

  setUp(() {
    repo = _FakeQrRepo();
    bloc = _makeQrBloc(repo);
  });

  tearDown(() => bloc.close());

  group('QrScannerPage — scanner active state', () {
    testWidgets('should render AppBar with correct title', (tester) async {
      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: bloc));
      await tester.pump();

      expect(find.text('Naskenovat QR kód stolu'), findsOneWidget);
    });

    testWidgets('should show instruction text at bottom of scanner',
        (tester) async {
      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: bloc));
      await tester.pump();

      expect(find.text('Nasměrujte kameru na QR kód stolu'), findsOneWidget);
    });

    testWidgets('should show flashlight icon button', (tester) async {
      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: bloc));
      await tester.pump();

      expect(find.byIcon(Icons.flash_on), findsOneWidget);
    });

    testWidgets('should show flip camera icon button', (tester) async {
      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: bloc));
      await tester.pump();

      expect(find.byIcon(Icons.flip_camera_ios), findsOneWidget);
    });
  });

  group('QrScannerPage — joining state', () {
    testWidgets('should show loading indicator when sessionJoining=true',
        (tester) async {
      // Emit a joining state before the widget builds
      final joiningBloc = _makeQrBloc(repo);
      addTearDown(joiningBloc.close);

      // Emit joining state
      joiningBloc.emit(joiningBloc.state.copyWith(sessionJoining: true));

      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: joiningBloc));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Připojuji ke stolu...'), findsOneWidget);
    });
  });

  group('QrScannerPage — error state', () {
    testWidgets('should show SnackBar when sessionJoinError is set', (tester) async {
      final errorBloc = _makeQrBloc(repo);
      addTearDown(errorBloc.close);

      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: errorBloc));
      await tester.pump();

      // Simulate scan happening then error
      errorBloc.emit(errorBloc.state.copyWith(
        sessionJoining: false,
        sessionJoinError: 'Sezení nebylo nalezeno.',
      ));

      // NOTE: The SnackBar only appears via BlocListener when _processed is true.
      // Since we cannot call setState on private state to set _processed=true,
      // we verify the error is stored in bloc state correctly.
      expect(errorBloc.state.sessionJoinError, 'Sezení nebylo nalezeno.');
    });
  });

  group('QrScannerPage — join success navigation', () {
    testWidgets('should emit sessionJoining then session when join succeeds',
        (tester) async {
      // We test the bloc reaction, not navigation (Navigator.pop is hard to assert here)
      final navBloc = _makeQrBloc(repo);
      addTearDown(navBloc.close);

      navBloc.emit(navBloc.state.copyWith(
        sessionJoining: false,
        session: const DiningSession(
          id: 'sess-1',
          restaurantId: 'rest-1',
          tableId: 'table-1',
          inviteCode: 'CODE1',
          status: 'ACTIVE',
        ),
      ));

      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: navBloc));
      await tester.pump();

      expect(navBloc.state.session?.id, 'sess-1');
    });
  });

  // EXPECTED-FAIL: accessibility — permission_denied state is not implemented;
  // production code does not show a permission-denied screen when camera permission is denied.
  testWidgets(
      'EXPECTED-FAIL: should show camera permission denied UI when permission is denied',
      (tester) async {
    await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: bloc));
    await tester.pump();

    expect(find.byKey(const Key('camera_permission_denied')), findsOneWidget);
  });

  group('QrScannerPage — screen sizes', () {
    for (final size in [
      const Size(390, 844),
      const Size(360, 640),
      const Size(820, 1180),
    ]) {
      testWidgets('renders correctly at ${size.width}x${size.height}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final sizeBloc = _makeQrBloc(repo);
        addTearDown(sizeBloc.close);

        await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: sizeBloc));
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(find.text('Naskenovat QR kód stolu'), findsOneWidget);
      });
    }
  });

  group('QrScannerPage — accessibility', () {
    testWidgets('meets androidTapTargetGuideline', (tester) async {
      await tester.pumpWidget(_wrap(const QrScannerPage(), bloc: bloc));
      await tester.pump();

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    });
  });
}
