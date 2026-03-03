import '../../domain/entities/dining_context.dart';
import '../../domain/entities/menu_category.dart';
import '../../domain/entities/order_summary.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_datasource.dart';
import '../models/request/create_order_request_model.dart';
import '../models/request/order_item_request_model.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<DiningContext> getDiningContext() async {
    final model = await _remoteDataSource.getDiningContext();
    return model.toEntity();
  }

  @override
  Future<List<MenuCategory>> getMenu(String restaurantId) async {
    final models = await _remoteDataSource.getMenu(restaurantId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<OrderSummary> createOrder({
    required List<({String menuItemId, int quantity})> items,
    String? note,
  }) async {
    final request = CreateOrderRequestModel(
      items: items
          .map((i) => OrderItemRequestModel(
                menuItemId: i.menuItemId,
                quantity: i.quantity,
              ))
          .toList(),
      note: note,
    );
    final model = await _remoteDataSource.createOrder(request);
    return model.toEntity();
  }

  @override
  Future<List<OrderSummary>> getCurrentOrders() async {
    final models = await _remoteDataSource.getCurrentOrders();
    return models.map((m) => m.toEntity()).toList();
  }
}
