import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/get_current_orders_usecase.dart';
import '../../domain/usecases/get_dining_context_usecase.dart';
import '../../domain/usecases/get_menu_usecase.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetDiningContextUseCase _getDiningContextUseCase;
  final GetMenuUseCase _getMenuUseCase;
  final CreateOrderUseCase _createOrderUseCase;
  final GetCurrentOrdersUseCase _getCurrentOrdersUseCase;

  OrdersBloc({
    required GetDiningContextUseCase getDiningContextUseCase,
    required GetMenuUseCase getMenuUseCase,
    required CreateOrderUseCase createOrderUseCase,
    required GetCurrentOrdersUseCase getCurrentOrdersUseCase,
  })  : _getDiningContextUseCase = getDiningContextUseCase,
        _getMenuUseCase = getMenuUseCase,
        _createOrderUseCase = createOrderUseCase,
        _getCurrentOrdersUseCase = getCurrentOrdersUseCase,
        super(const OrdersState()) {
    on<LoadContext>(_onLoadContext);
    on<LoadMenu>(_onLoadMenu);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<ClearCart>(_onClearCart);
    on<SubmitOrder>(_onSubmitOrder);
    on<LoadCurrentOrders>(_onLoadCurrentOrders);
    on<RefreshOrders>(_onRefresh);
  }

  // ── Load dining context → auto-cascade to menu + orders ──

  Future<void> _onLoadContext(
    LoadContext event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(
      contextLoading: true,
      contextError: null,
      noActiveContext: false,
    ));

    try {
      final context = await _getDiningContextUseCase();
      emit(state.copyWith(
        contextLoading: false,
        diningContext: context,
      ));

      // Auto-cascade: load menu and current orders
      add(LoadMenu(restaurantId: context.restaurantId));
      add(const LoadCurrentOrders());
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        emit(state.copyWith(
          contextLoading: false,
          noActiveContext: true,
        ));
      } else {
        emit(state.copyWith(
          contextLoading: false,
          contextError: 'Nepodařilo se načíst kontext.',
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        contextLoading: false,
        contextError: 'Nepodařilo se načíst kontext.',
      ));
    }
  }

  // ── Load menu ──

  Future<void> _onLoadMenu(
    LoadMenu event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(menuLoading: true, menuError: null));

    try {
      final categories = await _getMenuUseCase(event.restaurantId);
      emit(state.copyWith(
        menuLoading: false,
        menuCategories: categories,
      ));
    } catch (_) {
      emit(state.copyWith(
        menuLoading: false,
        menuError: 'Nepodařilo se načíst menu.',
      ));
    }
  }

  // ── Cart operations ──

  void _onAddToCart(AddToCart event, Emitter<OrdersState> emit) {
    final existing = state.cartItems.indexWhere(
      (item) => item.menuItemId == event.menuItem.id,
    );

    final updatedCart = List<CartItem>.from(state.cartItems);

    if (existing >= 0) {
      final old = updatedCart[existing];
      updatedCart[existing] = old.copyWith(quantity: old.quantity + 1);
    } else {
      updatedCart.add(CartItem(
        menuItemId: event.menuItem.id,
        itemName: event.menuItem.name,
        unitPriceMinor: event.menuItem.priceMinor,
        quantity: 1,
        currency: event.menuItem.currency,
      ));
    }

    emit(state.copyWith(cartItems: updatedCart, submitSuccess: false));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<OrdersState> emit) {
    final existing = state.cartItems.indexWhere(
      (item) => item.menuItemId == event.menuItemId,
    );

    if (existing < 0) return;

    final updatedCart = List<CartItem>.from(state.cartItems);
    final old = updatedCart[existing];

    if (old.quantity > 1) {
      updatedCart[existing] = old.copyWith(quantity: old.quantity - 1);
    } else {
      updatedCart.removeAt(existing);
    }

    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onUpdateCartQuantity(
      UpdateCartQuantity event, Emitter<OrdersState> emit) {
    final existing = state.cartItems.indexWhere(
      (item) => item.menuItemId == event.menuItemId,
    );

    if (existing < 0) return;

    final updatedCart = List<CartItem>.from(state.cartItems);

    if (event.quantity <= 0) {
      updatedCart.removeAt(existing);
    } else {
      updatedCart[existing] =
          updatedCart[existing].copyWith(quantity: event.quantity);
    }

    emit(state.copyWith(cartItems: updatedCart));
  }

  void _onClearCart(ClearCart event, Emitter<OrdersState> emit) {
    emit(state.copyWith(cartItems: []));
  }

  // ── Submit order ──

  Future<void> _onSubmitOrder(
    SubmitOrder event,
    Emitter<OrdersState> emit,
  ) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(submitting: true, submitError: null, submitSuccess: false));

    try {
      final items = state.cartItems
          .map((item) => (menuItemId: item.menuItemId, quantity: item.quantity))
          .toList();

      await _createOrderUseCase(items: items, note: event.note);

      emit(state.copyWith(
        submitting: false,
        submitSuccess: true,
        cartItems: [],
      ));

      // Reload current orders
      add(const LoadCurrentOrders());
    } on DioException catch (e) {
      final message = switch (e.response?.statusCode) {
        404 => 'Položka nebyla nalezena.',
        409 => 'Kontext objednávky se změnil.',
        422 => 'Neplatná objednávka.',
        _ => 'Nepodařilo se odeslat objednávku.',
      };
      emit(state.copyWith(submitting: false, submitError: message));
    } catch (_) {
      emit(state.copyWith(
        submitting: false,
        submitError: 'Nepodařilo se odeslat objednávku.',
      ));
    }
  }

  // ── Load current orders ──

  Future<void> _onLoadCurrentOrders(
    LoadCurrentOrders event,
    Emitter<OrdersState> emit,
  ) async {
    emit(state.copyWith(ordersLoading: true));

    try {
      final orders = await _getCurrentOrdersUseCase();
      emit(state.copyWith(ordersLoading: false, currentOrders: orders));
    } catch (_) {
      emit(state.copyWith(ordersLoading: false));
    }
  }

  // ── Refresh all ──

  Future<void> _onRefresh(
    RefreshOrders event,
    Emitter<OrdersState> emit,
  ) async {
    add(const LoadContext());
  }
}
