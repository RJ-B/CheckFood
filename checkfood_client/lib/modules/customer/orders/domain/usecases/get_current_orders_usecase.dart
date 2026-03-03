import '../entities/order_summary.dart';
import '../repositories/orders_repository.dart';

class GetCurrentOrdersUseCase {
  final OrdersRepository _repository;

  GetCurrentOrdersUseCase(this._repository);

  Future<List<OrderSummary>> call() async {
    return await _repository.getCurrentOrders();
  }
}
