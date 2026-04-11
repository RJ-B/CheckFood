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

// ---------------------------------------------------------------------------
// Fake repos
// ---------------------------------------------------------------------------

class _LoadingRepo implements OrdersRepository {
  @override
  Future<DiningContext> getDiningContext() async =>
      Future.delayed(const Duration(seconds: 30), () => throw Exception());
  @override
  Future<List<MenuCategory>> getMenu(String r) async => [];
  @override
  Future<OrderSummary> createOrder({required items, String? note}) =>
      throw UnimplementedError();
  @override
  Future<List<OrderSummary>> getCurrentOrders() async => [];
  @override
  Future<String> initiatePayment(String orderId) => throw UnimplementedError();
  @override
  Future<String> getPaymentStatus(String orderId) => throw UnimplementedError();
}

class _NoContextRepo implements OrdersRepository {
  @override
  Future<DiningContext> getDiningContext() async => throw DioException(
        requestOptions: RequestOptions(path: '/dining-context'),
        response: Response(
          requestOptions: RequestOptions(path: '/dining-context'),
          statusCode: 404,
        ),
      );
  @override
  Future<List<MenuCategory>> getMenu(String r) async => [];
  @override
  Future<OrderSummary> createOrder({required items, String? note}) =>
      throw UnimplementedError();
  @override
  Future<List<OrderSummary>> getCurrentOrders() async => [];
  @override
  Future<String> initiatePayment(String orderId) => throw UnimplementedError();
  @override
  Future<String> getPaymentStatus(String orderId) => throw UnimplementedError();
}

class _ErrorRepo implements OrdersRepository {
  @override
  Future<DiningContext> getDiningContext() async => throw Exception('network error');
  @override
  Future<List<MenuCategory>> getMenu(String r) async => [];
  @override
  Future<OrderSummary> createOrder({required items, String? note}) =>
      throw UnimplementedError();
  @override
  Future<List<OrderSummary>> getCurrentOrders() async => [];
  @override
  Future<String> initiatePayment(String orderId) => throw UnimplementedError();
  @override
  Future<String> getPaymentStatus(String orderId) => throw UnimplementedError();
}

class _LoadedRepo implements OrdersRepository {
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
  Future<List<MenuCategory>> getMenu(String r) async => [
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
      ];

  @override
  Future<OrderSummary> createOrder({required items, String? note}) =>
      throw UnimplementedError();
  @override
  Future<List<OrderSummary>> getCurrentOrders() async => [];
  @override
  Future<String> initiatePayment(String orderId) => throw UnimplementedError();
  @override
  Future<String> getPaymentStatus(String orderId) => throw UnimplementedError();
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

OrdersBloc _bloc(OrdersRepository repo) => OrdersBloc(
      getDiningContextUseCase: GetDiningContextUseCase(repo),
      getMenuUseCase: GetMenuUseCase(repo),
      createOrderUseCase: CreateOrderUseCase(repo),
      getCurrentOrdersUseCase: GetCurrentOrdersUseCase(repo),
      initiatePaymentUseCase: InitiatePaymentUseCase(repo),
      getPaymentStatusUseCase: GetPaymentStatusUseCase(repo),
    );

Widget _wrap(
  Widget child, {
  required OrdersBloc bloc,
  ThemeMode themeMode = ThemeMode.light,
}) {
  return MaterialApp(
    locale: const Locale('cs'),
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
    home: BlocProvider.value(value: bloc, child: child),
  );
}

// ---------------------------------------------------------------------------
// Golden tests
// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    final sl = GetIt.instance;
    if (!sl.isRegistered<OrdersRemoteDataSource>()) {
      sl.registerLazySingleton<OrdersRemoteDataSource>(() => _FakeRemoteDs());
    }
  });

  group('OrdersPage golden — loading state', () {
    testWidgets('orders_page_loading_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      // Use a simple repo that resolves immediately so the bloc constructor
      // doesn't hang; then emit loading state directly to get the golden.
      final b = _bloc(_NoContextRepo());
      addTearDown(b.close);

      await tester.pumpWidget(_wrap(const OrdersPage(), bloc: b));
      await tester.pump();
      b.emit(const OrdersState(contextLoading: true));
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_loading_light.png'),
      );
    });

    testWidgets('orders_page_loading_dark', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final b = _bloc(_NoContextRepo());
      addTearDown(b.close);

      await tester.pumpWidget(
          _wrap(const OrdersPage(), bloc: b, themeMode: ThemeMode.dark));
      await tester.pump();
      b.emit(const OrdersState(contextLoading: true));
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_loading_dark.png'),
      );
    });
  });

  group('OrdersPage golden — no-context / empty state', () {
    testWidgets('orders_page_empty_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final b = _bloc(_NoContextRepo());
      addTearDown(b.close);

      await tester.pumpWidget(_wrap(const OrdersPage(), bloc: b));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_empty_light.png'),
      );
    });

    testWidgets('orders_page_empty_dark', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final b = _bloc(_NoContextRepo());
      addTearDown(b.close);

      await tester.pumpWidget(
          _wrap(const OrdersPage(), bloc: b, themeMode: ThemeMode.dark));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_empty_dark.png'),
      );
    });
  });

  group('OrdersPage golden — error state', () {
    testWidgets('orders_page_error_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final b = _bloc(_ErrorRepo());
      addTearDown(b.close);

      await tester.pumpWidget(_wrap(const OrdersPage(), bloc: b));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_error_light.png'),
      );
    });

    testWidgets('orders_page_error_dark', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final b = _bloc(_ErrorRepo());
      addTearDown(b.close);

      await tester.pumpWidget(
          _wrap(const OrdersPage(), bloc: b, themeMode: ThemeMode.dark));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_error_dark.png'),
      );
    });
  });

  group('OrdersPage golden — success/loaded state', () {
    testWidgets('orders_page_success_light', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final b = _bloc(_LoadedRepo());
      addTearDown(b.close);

      await tester.pumpWidget(_wrap(const OrdersPage(), bloc: b));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_success_light.png'),
      );
    });

    testWidgets('orders_page_success_dark', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final b = _bloc(_LoadedRepo());
      addTearDown(b.close);

      await tester.pumpWidget(
          _wrap(const OrdersPage(), bloc: b, themeMode: ThemeMode.dark));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/orders_page_success_dark.png'),
      );
    });
  });
}
