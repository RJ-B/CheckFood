import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
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
import 'package:checkfood_client/modules/order/presentation/bloc/orders_event.dart';
import 'package:checkfood_client/modules/order/presentation/bloc/orders_state.dart';

// ---------------------------------------------------------------------------
// Fake remote data source (registered in GetIt so OrdersBloc constructor works)
// ---------------------------------------------------------------------------

class _FakeRemoteDataSource implements OrdersRemoteDataSource {
  @override
  Future<DiningContextResponseModel> getDiningContext() async =>
      const DiningContextResponseModel(
        restaurantId: 'rest-1',
        tableId: 'table-1',
        contextType: 'RESERVATION',
        restaurantName: 'Test Restaurant',
        tableLabel: 'Stůl 1',
        validFrom: '2026-01-01T10:00:00Z',
        validTo: '2026-01-01T23:00:00Z',
      );

  @override
  Future<List<MenuCategoryResponseModel>> getMenu(String restaurantId) async =>
      [];

  @override
  Future<OrderSummaryResponseModel> createOrder(
          CreateOrderRequestModel request) async =>
      const OrderSummaryResponseModel(
        id: 'ord-1',
        status: 'PENDING',
        totalPriceMinor: 25000,
        currency: 'CZK',
        itemCount: 1,
        createdAt: '2026-01-01T12:00:00Z',
      );

  @override
  Future<List<OrderSummaryResponseModel>> getCurrentOrders() async => [];

  @override
  Future<String> initiatePayment(String orderId) async =>
      'https://pay.example.com/$orderId';

  @override
  Future<String> getPaymentStatus(String orderId) async => 'PAID';

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

void _registerFakeDataSource() {
  final sl = GetIt.instance;
  if (!sl.isRegistered<OrdersRemoteDataSource>()) {
    sl.registerLazySingleton<OrdersRemoteDataSource>(
        () => _FakeRemoteDataSource());
  }
}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

const _kContext = DiningContext(
  restaurantId: 'rest-1',
  tableId: 'table-1',
  contextType: 'RESERVATION',
  restaurantName: 'Test Restaurant',
  tableLabel: 'Stůl 1',
  validFrom: '2026-01-01T10:00:00Z',
  validTo: '2026-01-01T23:00:00Z',
);

final _kMenuCategories = [
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

final _kOrders = [
  const OrderSummary(
    id: 'ord-1',
    status: 'PENDING',
    totalPriceMinor: 25000,
    currency: 'CZK',
    itemCount: 1,
    createdAt: '2026-01-01T12:00:00Z',
  ),
];

// ---------------------------------------------------------------------------
// Fake Repository
// ---------------------------------------------------------------------------

class FakeOrdersRepository implements OrdersRepository {
  bool shouldThrowOnContext = false;
  bool shouldReturn404OnContext = false;
  bool shouldThrowOnMenu = false;
  bool shouldThrowOnCreateOrder = false;
  DioException? createOrderDioError;

  @override
  Future<DiningContext> getDiningContext() async {
    if (shouldReturn404OnContext) {
      throw DioException(
        requestOptions: RequestOptions(path: '/dining-context'),
        response: Response(
          requestOptions: RequestOptions(path: '/dining-context'),
          statusCode: 404,
        ),
      );
    }
    if (shouldThrowOnContext) throw Exception('network error');
    return _kContext;
  }

  @override
  Future<List<MenuCategory>> getMenu(String restaurantId) async {
    if (shouldThrowOnMenu) throw Exception('menu error');
    return _kMenuCategories;
  }

  @override
  Future<OrderSummary> createOrder({
    required List<({String menuItemId, int quantity})> items,
    String? note,
  }) async {
    if (createOrderDioError != null) throw createOrderDioError!;
    if (shouldThrowOnCreateOrder) throw Exception('submit error');
    return _kOrders.first;
  }

  @override
  Future<List<OrderSummary>> getCurrentOrders() async => _kOrders;

  @override
  Future<String> initiatePayment(String orderId) async =>
      'https://pay.example.com/$orderId';

  @override
  Future<String> getPaymentStatus(String orderId) async => 'PAID';
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

OrdersBloc _makeBloc(OrdersRepository repo) {
  return OrdersBloc(
    getDiningContextUseCase: GetDiningContextUseCase(repo),
    getMenuUseCase: GetMenuUseCase(repo),
    createOrderUseCase: CreateOrderUseCase(repo),
    getCurrentOrdersUseCase: GetCurrentOrdersUseCase(repo),
    initiatePaymentUseCase: InitiatePaymentUseCase(repo),
    getPaymentStatusUseCase: GetPaymentStatusUseCase(repo),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late FakeOrdersRepository repo;
  late OrdersBloc bloc;

  setUpAll(() {
    _registerFakeDataSource();
  });

  setUp(() {
    repo = FakeOrdersRepository();
    bloc = _makeBloc(repo);
  });

  tearDown(() => bloc.close());

  group('OrdersBloc — initial state', () {
    test('should start with contextLoading=true and empty cart', () {
      expect(bloc.state.contextLoading, isTrue);
      expect(bloc.state.cartItems, isEmpty);
      expect(bloc.state.menuCategories, isEmpty);
    });
  });

  group('OrdersBloc — LoadContext', () {
    test('should emit loaded state with context when repository succeeds', () async {
      bloc.add(const OrdersEvent.loadContext());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) =>
                !s.contextLoading &&
                s.diningContext?.restaurantId == 'rest-1' &&
                s.diningContext?.tableLabel == 'Stůl 1',
            'has loaded context',
          ),
        ),
      );
    });

    test('should emit noActiveContext=true when 404 is returned', () async {
      repo.shouldReturn404OnContext = true;
      bloc.add(const OrdersEvent.loadContext());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => !s.contextLoading && s.noActiveContext,
            'noActiveContext',
          ),
        ),
      );
    });

    test('should emit contextError when generic error is thrown', () async {
      repo.shouldThrowOnContext = true;
      bloc.add(const OrdersEvent.loadContext());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => !s.contextLoading && s.contextError != null,
            'contextError set',
          ),
        ),
      );
    });

    test('should also load menu after successful context load', () async {
      bloc.add(const OrdersEvent.loadContext());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => s.menuCategories.isNotEmpty,
            'menu categories loaded',
          ),
        ),
      );
    });
  });

  group('OrdersBloc — AddToCart / RemoveFromCart / UpdateCartQuantity', () {
    const menuItem = MenuItem(
      id: 'item-1',
      name: 'Svíčková',
      priceMinor: 25000,
      currency: 'CZK',
      available: true,
    );

    test('should add new item to cart', () async {
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));

      await expectLater(
        bloc.stream,
        emits(
          predicate<OrdersState>(
            (s) => s.cartItemCount == 1 && s.cartTotalMinor == 25000,
            'one item in cart',
          ),
        ),
      );
    });

    test('should increment quantity when same item added twice', () async {
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => s.cartItemCount == 2 && s.cartItems.first.quantity == 2,
            'quantity incremented',
          ),
        ),
      );
    });

    test('should decrement quantity on RemoveFromCart', () async {
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      bloc.add(const OrdersEvent.removeFromCart(menuItemId: 'item-1'));

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => s.cartItemCount == 1 && s.cartItems.first.quantity == 1,
            'decremented',
          ),
        ),
      );
    });

    test('should remove item from cart when quantity reaches 0', () async {
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      bloc.add(const OrdersEvent.removeFromCart(menuItemId: 'item-1'));

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => s.cartItems.isEmpty,
            'cart empty after remove',
          ),
        ),
      );
    });

    test('should remove item when UpdateCartQuantity sets 0', () async {
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      bloc.add(
          const OrdersEvent.updateCartQuantity(menuItemId: 'item-1', quantity: 0));

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>((s) => s.cartItems.isEmpty, 'cart empty'),
        ),
      );
    });

    test('should clear all items on ClearCart', () async {
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      bloc.add(const OrdersEvent.clearCart());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>((s) => s.cartItems.isEmpty, 'cart cleared'),
        ),
      );
    });
  });

  group('OrdersBloc — cartTotalFormatted', () {
    test('should format minor units to Kč without hellers', () {
      // 25000 minor = 250 Kč
      final state = OrdersState(
        cartItems: [
          const CartItem(
            menuItemId: 'x',
            itemName: 'X',
            unitPriceMinor: 25000,
            quantity: 1,
            currency: 'CZK',
          ),
        ],
      );
      expect(state.cartTotalFormatted, '250 Kč');
    });

    test('should format minor units to Kč with hellers', () {
      final state = OrdersState(
        cartItems: [
          const CartItem(
            menuItemId: 'x',
            itemName: 'X',
            unitPriceMinor: 25050,
            quantity: 1,
            currency: 'CZK',
          ),
        ],
      );
      expect(state.cartTotalFormatted, '250.50 Kč');
    });
  });

  group('OrdersBloc — SubmitOrder', () {
    const menuItem = MenuItem(
      id: 'item-1',
      name: 'Svíčková',
      priceMinor: 25000,
      currency: 'CZK',
      available: true,
    );

    test('should not submit when cart is empty (canSubmit = false)', () async {
      // Load context to set hasContext
      bloc.add(const OrdersEvent.loadContext());
      await bloc.stream.firstWhere((s) => s.diningContext != null);

      // Try to submit with empty cart
      bloc.add(const OrdersEvent.submitOrder());
      // No new state change expected — submitting remains false
      await Future.delayed(const Duration(milliseconds: 50));
      expect(bloc.state.submitting, isFalse);
      expect(bloc.state.submitSuccess, isFalse);
    });

    test('should emit submitting=true then success and clear cart', () async {
      bloc.add(const OrdersEvent.loadContext());
      await bloc.stream.firstWhere((s) => s.diningContext != null);

      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      await bloc.stream.firstWhere((s) => s.cartItems.isNotEmpty);

      bloc.add(const OrdersEvent.submitOrder());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => s.submitSuccess && s.cartItems.isEmpty && !s.submitting,
            'submit success, cart cleared',
          ),
        ),
      );
    });

    test('should emit submitError on 409 DioException', () async {
      repo.createOrderDioError = DioException(
        requestOptions: RequestOptions(path: '/orders'),
        response: Response(
          requestOptions: RequestOptions(path: '/orders'),
          statusCode: 409,
        ),
      );

      bloc.add(const OrdersEvent.loadContext());
      await bloc.stream.firstWhere((s) => s.diningContext != null);
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      await bloc.stream.firstWhere((s) => s.cartItems.isNotEmpty);
      bloc.add(const OrdersEvent.submitOrder());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => !s.submitting && s.submitError == 'Kontext objednávky se změnil.',
            'conflict error message',
          ),
        ),
      );
    });

    test('should emit generic submitError on unexpected exception', () async {
      repo.shouldThrowOnCreateOrder = true;

      bloc.add(const OrdersEvent.loadContext());
      await bloc.stream.firstWhere((s) => s.diningContext != null);
      bloc.add(const OrdersEvent.addToCart(menuItem: menuItem));
      await bloc.stream.firstWhere((s) => s.cartItems.isNotEmpty);
      bloc.add(const OrdersEvent.submitOrder());

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => !s.submitting && s.submitError != null,
            'generic submit error',
          ),
        ),
      );
    });
  });

  group('OrdersBloc — LoadMenu', () {
    test('should emit menuError when repository throws', () async {
      repo.shouldThrowOnMenu = true;
      bloc.add(const OrdersEvent.loadMenu(restaurantId: 'rest-1'));

      await expectLater(
        bloc.stream,
        emitsThrough(
          predicate<OrdersState>(
            (s) => !s.menuLoading && s.menuError != null,
            'menu error',
          ),
        ),
      );
    });
  });

  group('OrdersBloc — ToggleItemSelection / SelectAllMyItems', () {
    test('bloc does not crash on SelectAllMyItems with empty session', () async {
      // With no session items, selectAllMyItems yields empty set
      bloc.add(const OrdersEvent.selectAllMyItems());
      await expectLater(
        bloc.stream,
        emits(
          predicate<OrdersState>(
            (s) => s.selectedItemIds.isEmpty,
            'no items selected',
          ),
        ),
      );
    });
  });
}
