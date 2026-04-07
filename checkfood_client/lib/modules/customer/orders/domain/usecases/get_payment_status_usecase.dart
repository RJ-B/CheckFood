import '../repositories/orders_repository.dart';

/// Returns the current payment status string for the given order.
class GetPaymentStatusUseCase {
  final OrdersRepository _repository;

  GetPaymentStatusUseCase(this._repository);

  Future<String> call(String orderId) async {
    return await _repository.getPaymentStatus(orderId);
  }
}
