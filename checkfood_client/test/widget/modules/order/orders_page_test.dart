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
import 'package:checkfood_client/modules/order/domain/entities/cart_item.dart';
import 'package:checkfood_client/modules/order/domain/entities/dining_context.dart';
import 'package:checkfood_client/modules/order/domain/entities/menu_category.dart';
import 'package:checkfood_client/modules/order/domain/entities/menu_item.dart';
import 'package:checkfood_client/modules/order/domain/entities/order_summary.dart';
import 'package:checkfood_client/modules/order/domain/repositories/orders_repository.dart';
import 'package:checkfood_client/modules/order/domain/usecases/create_order_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_current_orders_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_dining_context_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_menu_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/get_payment_status_usecase.dart';
import 'package:checkfood_client/modules/order/domain/usecases/initiate_payment_usecase.dart';
import 'package:checkfood_client/modules/order/presentation/bloc/orders_bloc.dart';
import 'package:checkfood_client/modules/order/presentation/bloc/orders_state.dart';
import 'package:checkfood_client/modules/order/presentation/pages/orders_page.dart';
import 'package:dio/dio.dart';

// ---------------------------------------------------------------------------
// Fake remote data source for GetIt registration (required by OrdersBloc ctor)
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
// Fake repository
// ---------------------------------------------------------------------------

class _FakeRepo implements OrdersRepository {
  @override
  Future<DiningContext> getDiningContext() async => const DiningContext(
        restaurantId: 'rest-1',
        tableId: 'table-1',
        contextType: 'RESERVATION',
        restaurantName: 'Test Restaurant',
        tableLabel: 'Stůl 1',
        validFrom: '2026-01-01T10:00:00Z',
        validTo: '2026-01-01T23:00:00Z',
      );

  @override
  Future<List<MenuCategory>> getMenu(String r) async => [];

  @override
  Future<OrderSummary> createOrder({
    required List<({String menuItemId, int quantity})> items,
    String? note,
  }) async =>
      const OrderSummary(
        id: 'ord-1',
        status: 'PENDING',
        totalPriceMinor: 25000,
        currency: 'CZK',
        itemCount: 1,
        createdAt: '2026-01-01T12:00:00Z',
      );

  @override
  Future<List<OrderSummary>> getCurrentOrders() async => [];

  @override
  Future<String> initiatePayment(String orderId) async =>
      'https://pay.example.com/$orderId';

  @override
  Future<String> getPaymentStatus(String orderId) async => 'PAID';
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

OrdersBloc _makeBloc() {
  final repo = _FakeRepo();
  return OrdersBloc(
    getDiningContextUseCase: GetDiningContextUseCase(repo),
    getMenuUseCase: GetMenuUseCase(repo),
    createOrderUseCase: CreateOrderUseCase(repo),
    getCurrentOrdersUseCase: GetCurrentOrdersUseCase(repo),
    initiatePaymentUseCase: InitiatePaymentUseCase(repo),
    getPaymentStatusUseCase: GetPaymentStatusUseCase(repo),
  );
}

Widget _wrap(
  Widget child, {
  required OrdersBloc bloc,
  String locale = 'cs',
  ThemeMode themeMode = ThemeMode.light,
}) {
  return MaterialApp(
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
    home: BlocProvider.value(
      value: bloc,
      child: child,
    ),
  );
}

// Pre-baked states. These are emitted AFTER the first pump() so that
// OrdersPage.initState fires first, then we override with our test state.
const _kContext = DiningContext(
  restaurantId: 'rest-1',
  tableId: 'table-1',
  contextType: 'RESERVATION',
  restaurantName: 'Test Restaurant',
  tableLabel: 'Stůl 1',
  validFrom: '2026-01-01T10:00:00Z',
  validTo: '2026-01-01T23:00:00Z',
);

final _loadingState = const OrdersState(contextLoading: true);

final _noContextState = const OrdersState(
  contextLoading: false,
  noActiveContext: true,
);

final _errorState = const OrdersState(
  contextLoading: false,
  contextError: 'Nepodařilo se načíst kontext.',
);

final _loadedState = OrdersState(
  contextLoading: false,
  diningContext: _kContext,
  menuLoading: false,
  menuCategories: [
    MenuCategory(
      id: 'cat-1',
      name: 'Hlavní jídla',
      items: [
        const MenuItem(
          id: 'item-1',
          name: 'Svíčková',
          priceMinor: 25000,
          currency: 'CZK',
          available: true,
        ),
      ],
    ),
  ],
  currentOrders: const [],
);

final _emptyMenuState = OrdersState(
  contextLoading: false,
  diningContext: _kContext,
  menuLoading: false,
  menuCategories: const [],
);

final _menuErrorState = OrdersState(
  contextLoading: false,
  diningContext: _kContext,
  menuLoading: false,
  menuError: 'Nepodařilo se načíst menu.',
);

final _loadedWithOrdersState = OrdersState(
  contextLoading: false,
  diningContext: _kContext,
  menuCategories: const [],
  currentOrders: const [
    OrderSummary(
      id: 'ord-1',
      status: 'PENDING',
      totalPriceMinor: 25000,
      currency: 'CZK',
      itemCount: 1,
      createdAt: '2026-01-01T12:00:00Z',
    ),
  ],
);

final _cartState = OrdersState(
  contextLoading: false,
  diningContext: _kContext,
  menuCategories: const [],
  cartItems: const [
    CartItem(
      menuItemId: 'item-1',
      itemName: 'Svíčková',
      unitPriceMinor: 25000,
      quantity: 1,
      currency: 'CZK',
    ),
  ],
);

/// Pumps the widget then emits [state] and pumps again.
/// This lets initState run first, then we override the bloc state.
Future<void> _pumpWithState(
  WidgetTester tester,
  Widget widget,
  OrdersBloc bloc,
  OrdersState state,
) async {
  await tester.pumpWidget(widget);
  await tester.pump(); // let initState fire
  bloc.emit(state);   // override with desired test state
  await tester.pump(); // rebuild widget
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    _ensureGetIt();
  });

  // ---- Loading state -------------------------------------------------------

  group('OrdersPage — loading state', () {
    testWidgets('should show CircularProgressIndicator in loading state',
        (WidgetTester tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadingState);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(TabBar), findsNothing);
    });
  });

  // ---- No context state ----------------------------------------------------

  group('OrdersPage — no active context state', () {
    testWidgets('should show NoContextWidget when noActiveContext=true',
        (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _noContextState);

      expect(find.text('Nemáte aktivní rezervaci'), findsOneWidget);
    });

    testWidgets('should show refresh button in no-context state', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _noContextState);

      expect(find.text('Zkontrolovat znovu'), findsOneWidget);
    });

    testWidgets('refresh button re-fires LoadContext and changes state',
        (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _noContextState);

      // Tap — LoadContext is added to bloc; FakeRepo resolves immediately so
      // state transitions through loading → loaded in the same microtask batch.
      await tester.tap(find.text('Zkontrolovat znovu'));
      await tester.pump();
      await tester.pump();

      // After the fake repo resolves, noActiveContext is cleared
      expect(b.state.noActiveContext, isFalse);
    });
  });

  // ---- Error state ---------------------------------------------------------

  group('OrdersPage — error state', () {
    testWidgets('should show error message and retry button', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _errorState);

      expect(find.text('Nepodařilo se načíst kontext.'), findsOneWidget);
      expect(find.text('Zkusit znovu'), findsOneWidget);
    });

    testWidgets('retry button fires LoadContext and clears error', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _errorState);

      await tester.tap(find.text('Zkusit znovu'));
      await tester.pump();
      await tester.pump();

      // FakeRepo resolves immediately — error is cleared after successful load
      expect(b.state.contextError, isNull);
    });
  });

  // ---- Loaded state --------------------------------------------------------

  group('OrdersPage — loaded state', () {
    testWidgets('should show tab bar with three tabs on success', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadedState);

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
      expect(find.byIcon(Icons.receipt_long), findsOneWidget);
    });

    testWidgets('should display restaurant name and table label in AppBar',
        (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadedState);

      expect(find.text('Test Restaurant'), findsOneWidget);
      expect(find.text('Stůl 1'), findsOneWidget);
    });

    testWidgets('should display menu items on Menu tab', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadedState);

      expect(find.text('Svíčková'), findsOneWidget);
    });

    testWidgets('should display empty orders placeholder on My Orders tab',
        (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadedState);

      // Drag TabBarView left to navigate to the My Orders tab (index 1)
      await tester.drag(find.byType(TabBarView), const Offset(-400, 0));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Zatím žádné objednávky'), findsOneWidget);
    });

    testWidgets('should display orders list when orders exist', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(
          tester, _wrap(const OrdersPage(), bloc: b), b, _loadedWithOrdersState);

      await tester.drag(find.byType(TabBarView), const Offset(-400, 0));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Čeká na potvrzení'), findsOneWidget);
    });
  });

  // ---- Empty menu ----------------------------------------------------------

  group('OrdersPage — empty menu', () {
    testWidgets('should show menuEmpty label when menu has no categories',
        (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(
          tester, _wrap(const OrdersPage(), bloc: b), b, _emptyMenuState);

      expect(find.text('Menu je prázdné.'), findsOneWidget);
    });
  });

  // ---- Menu error ----------------------------------------------------------

  group('OrdersPage — menu error state', () {
    testWidgets('should show menu error text and retry button', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(
          tester, _wrap(const OrdersPage(), bloc: b), b, _menuErrorState);

      expect(find.text('Nepodařilo se načíst menu.'), findsOneWidget);
      expect(find.text('Zkusit znovu'), findsOneWidget);
    });
  });

  // ---- Cart interaction ----------------------------------------------------

  group('OrdersPage — cart', () {
    testWidgets('should show CartSummaryBar when cart has items', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _cartState);

      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('cart bar shows correct total formatted', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _cartState);

      expect(find.text('250 Kč'), findsOneWidget);
    });

    testWidgets('cart bar FilledButton is enabled when not submitting', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _cartState);

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('cart bar FilledButton is disabled when submitting=true', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b,
          _cartState.copyWith(submitting: true));

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('cart is empty after submitSuccess=true → no CartSummaryBar',
        (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b,
          _loadedState.copyWith(submitSuccess: true));

      // Cart is empty in loadedState → CartSummaryBar not visible
      expect(find.byType(FilledButton), findsNothing);
    });
  });

  // ---- Localisation --------------------------------------------------------

  group('OrdersPage — localisation', () {
    testWidgets('shows ordersTitle in Czech locale when no context', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(
          tester,
          _wrap(const OrdersPage(), bloc: b, locale: 'cs'),
          b,
          _noContextState);

      expect(find.text('Orders'), findsOneWidget);
    });

    testWidgets('shows ordersTitle in English locale when no context', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(
          tester,
          _wrap(const OrdersPage(), bloc: b, locale: 'en'),
          b,
          _noContextState);

      expect(find.text('Orders'), findsOneWidget);
    });
  });

  // ---- Dark theme ----------------------------------------------------------

  group('OrdersPage — themes', () {
    testWidgets('renders without overflow in dark theme — no context', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(
          tester,
          _wrap(const OrdersPage(), bloc: b, themeMode: ThemeMode.dark),
          b,
          _noContextState);

      expect(tester.takeException(), isNull);
      expect(find.text('Nemáte aktivní rezervaci'), findsOneWidget);
    });

    testWidgets('renders without overflow in dark theme — loaded', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(
          tester,
          _wrap(const OrdersPage(), bloc: b, themeMode: ThemeMode.dark),
          b,
          _loadedState);

      expect(tester.takeException(), isNull);
      expect(find.byType(TabBar), findsOneWidget);
    });
  });

  // ---- Multi-size ----------------------------------------------------------

  group('OrdersPage — screen sizes', () {
    for (final size in [
      const Size(390, 844), // phone
      const Size(360, 640), // small phone
      const Size(820, 1180), // tablet
    ]) {
      testWidgets('renders correctly at ${size.width}x${size.height}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final b = _makeBloc();
        addTearDown(b.close);

        await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadedState);

        expect(tester.takeException(), isNull);
        expect(find.byType(TabBar), findsOneWidget);
      });
    }
  });

  // ---- RTL -----------------------------------------------------------------

  group('OrdersPage — RTL', () {
    testWidgets('should render without errors in RTL direction', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: _wrap(const OrdersPage(), bloc: b),
        ),
      );
      await tester.pump();
      b.emit(_noContextState);
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });

  // ---- Accessibility -------------------------------------------------------

  group('OrdersPage — accessibility', () {
    testWidgets('no-context state meets textContrastGuideline', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _noContextState);

      await expectLater(tester, meetsGuideline(textContrastGuideline));
    });

    testWidgets('no-context state meets androidTapTargetGuideline', (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _noContextState);

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    });

    // EXPECTED-FAIL: accessibility — retry button on error state lacks Semantics label
    testWidgets('error state retry button meets labeledTapTargetGuideline',
        (tester) async {
      final b = _makeBloc();
      addTearDown(b.close);

      await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _errorState);

      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    });
  });

  // ---- EXPECTED-FAIL tests revealing UX gaps -------------------------------

  // EXPECTED-FAIL: loading state — no shimmer placeholder shown during context load;
  // production code shows a plain CircularProgressIndicator with no content skeleton.
  testWidgets('EXPECTED-FAIL: should show loading shimmer during context fetch',
      (tester) async {
    final b = _makeBloc();
    addTearDown(b.close);

    await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadingState);

    // Shimmer widget is not yet implemented — this will fail
    expect(find.byKey(const Key('orders_loading_shimmer')), findsOneWidget);
  });

  // EXPECTED-FAIL: empty orders — empty state has no CTA to browse menu
  testWidgets('EXPECTED-FAIL: empty orders tab should have a "Browse menu" CTA',
      (tester) async {
    final b = _makeBloc();
    addTearDown(b.close);

    await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, _loadedState);

    await tester.drag(find.byType(TabBarView), const Offset(-400, 0));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const Key('orders_browse_menu_cta')), findsOneWidget);
  });

  // EXPECTED-FAIL: submit success — no success SnackBar/banner shown after order placed
  testWidgets('EXPECTED-FAIL: should show success snackbar after order submitted',
      (tester) async {
    final b = _makeBloc();
    addTearDown(b.close);

    final successState = _cartState.copyWith(submitSuccess: true, cartItems: []);
    await _pumpWithState(tester, _wrap(const OrdersPage(), bloc: b), b, successState);

    expect(find.byKey(const Key('order_success_snackbar')), findsOneWidget);
  });
}
