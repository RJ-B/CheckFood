import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/dining_context.dart';
import '../../domain/entities/dining_session.dart';
import '../../domain/entities/menu_category.dart';
import '../../domain/entities/order_summary.dart';
import '../../domain/entities/session_order_item.dart';

part 'orders_state.freezed.dart';

/// Neměnný state pro [OrdersBloc] obsahující všechny dílčí stavy flow objednávek.
@freezed
class OrdersState with _$OrdersState {
  const OrdersState._();

  const factory OrdersState({
    @Default(true) bool contextLoading,
    DiningContext? diningContext,
    @Default(false) bool noActiveContext,
    String? contextError,

    @Default(false) bool menuLoading,
    @Default([]) List<MenuCategory> menuCategories,
    String? menuError,

    @Default([]) List<CartItem> cartItems,

    @Default(false) bool submitting,
    @Default(false) bool submitSuccess,
    String? submitError,

    @Default(false) bool ordersLoading,
    @Default([]) List<OrderSummary> currentOrders,

    @Default(false) bool paymentInitiating,
    String? paymentError,
    String? paymentRedirectUrl,
    @Default({}) Map<String, String> paymentStatuses,

    DiningSession? session,
    @Default([]) List<SessionOrderItem> sessionItems,
    @Default({}) Set<String> selectedItemIds,
    @Default(false) bool sessionLoading,
    String? sessionError,
    @Default(0) int sessionTotalMinor,
    @Default(0) int sessionPaidMinor,
    @Default(0) int sessionRemainingMinor,
    String? sessionInviteCode,
    @Default(false) bool sessionJoining,
    String? sessionJoinError,
  }) = _OrdersState;

  bool get hasContext => diningContext != null;
  bool get hasSession => session != null;

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

  int get selectedTotalMinor {
    return sessionItems
        .where((item) => selectedItemIds.contains(item.id))
        .fold(0, (sum, item) => sum + item.totalPriceMinor);
  }

  String get selectedTotalFormatted {
    final crowns = selectedTotalMinor ~/ 100;
    final hellers = selectedTotalMinor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '$crowns,${hellers.toString().padLeft(2, '0')} Kč';
  }

  static String _formatMinor(int minor) {
    final crowns = minor ~/ 100;
    final hellers = minor % 100;
    if (hellers == 0) return '$crowns Kč';
    return '$crowns,${hellers.toString().padLeft(2, '0')} Kč';
  }

  String get sessionTotalFormatted => _formatMinor(sessionTotalMinor);
  String get sessionPaidFormatted => _formatMinor(sessionPaidMinor);
  String get sessionRemainingFormatted => _formatMinor(sessionRemainingMinor);
}
