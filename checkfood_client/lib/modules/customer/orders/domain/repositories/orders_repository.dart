import '../entities/dining_context.dart';
import '../entities/menu_category.dart';
import '../entities/order_summary.dart';

/// Doménový kontrakt pro repozitář objednávek.
abstract class OrdersRepository {
  Future<DiningContext> getDiningContext();

  Future<List<MenuCategory>> getMenu(String restaurantId);

  Future<OrderSummary> createOrder({
    required List<({String menuItemId, int quantity})> items,
    String? note,
  });

  Future<List<OrderSummary>> getCurrentOrders();

  Future<String> initiatePayment(String orderId);

  Future<String> getPaymentStatus(String orderId);
}
