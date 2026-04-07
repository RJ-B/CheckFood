import '../entities/order_summary.dart';
import '../repositories/orders_repository.dart';

/// Odešle novou objednávku s danými položkami košíku a volitelnou poznámkou.
class CreateOrderUseCase {
  final OrdersRepository _repository;

  CreateOrderUseCase(this._repository);

  Future<OrderSummary> call({
    required List<({String menuItemId, int quantity})> items,
    String? note,
  }) async {
    return await _repository.createOrder(items: items, note: note);
  }
}
