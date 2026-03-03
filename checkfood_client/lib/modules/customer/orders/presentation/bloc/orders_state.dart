import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/dining_context.dart';
import '../../domain/entities/menu_category.dart';
import '../../domain/entities/order_summary.dart';

part 'orders_state.freezed.dart';

@freezed
class OrdersState with _$OrdersState {
  const OrdersState._();

  const factory OrdersState({
    // Context
    @Default(true) bool contextLoading,
    DiningContext? diningContext,
    @Default(false) bool noActiveContext,
    String? contextError,

    // Menu
    @Default(false) bool menuLoading,
    @Default([]) List<MenuCategory> menuCategories,
    String? menuError,

    // Cart
    @Default([]) List<CartItem> cartItems,

    // Order submission
    @Default(false) bool submitting,
    @Default(false) bool submitSuccess,
    String? submitError,

    // Current orders
    @Default(false) bool ordersLoading,
    @Default([]) List<OrderSummary> currentOrders,
  }) = _OrdersState;

  bool get hasContext => diningContext != null;

  int get cartItemCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  int get cartTotalMinor =>
      cartItems.fold(0, (sum, item) => sum + item.totalPriceMinor);

  String get cartTotalFormatted {
    final crowns = cartTotalMinor ~/ 100;
    final hellers = cartTotalMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '${crowns}.${hellers.toString().padLeft(2, '0')} Kč';
  }

  bool get canSubmit => cartItems.isNotEmpty && !submitting && hasContext;
}
