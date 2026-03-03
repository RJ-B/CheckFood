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
}
