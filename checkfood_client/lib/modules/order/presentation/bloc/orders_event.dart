import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/menu_item.dart';

part 'orders_event.freezed.dart';

@freezed
class OrdersEvent with _$OrdersEvent {
  const factory OrdersEvent.loadContext() = LoadContext;
  const factory OrdersEvent.loadMenu({required String restaurantId}) = LoadMenu;
  const factory OrdersEvent.addToCart({required MenuItem menuItem}) = AddToCart;
  const factory OrdersEvent.removeFromCart({required String menuItemId}) =
      RemoveFromCart;
  const factory OrdersEvent.updateCartQuantity({
    required String menuItemId,
    required int quantity,
  }) = UpdateCartQuantity;
  const factory OrdersEvent.clearCart() = ClearCart;
  const factory OrdersEvent.submitOrder({String? note}) = SubmitOrder;
  const factory OrdersEvent.loadCurrentOrders() = LoadCurrentOrders;
  const factory OrdersEvent.refresh() = RefreshOrders;
  const factory OrdersEvent.payOrder({required String orderId}) = PayOrder;
  const factory OrdersEvent.checkPaymentStatus({required String orderId}) =
      CheckPaymentStatus;

  const factory OrdersEvent.loadSession() = LoadSession;
  const factory OrdersEvent.loadSessionOrders() = LoadSessionOrders;
  const factory OrdersEvent.toggleItemSelection({required String itemId}) =
      ToggleItemSelection;
  const factory OrdersEvent.selectAllMyItems() = SelectAllMyItems;
  const factory OrdersEvent.paySelectedItems() = PaySelectedItems;
  const factory OrdersEvent.joinSession({required String inviteCode}) =
      JoinSession;
  const factory OrdersEvent.showSessionQr() = ShowSessionQr;
}
