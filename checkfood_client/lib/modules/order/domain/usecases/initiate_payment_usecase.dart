import '../repositories/orders_repository.dart';

/// Zahájí platební flow pro zadanou objednávku a vrátí URL pro přesměrování.
class InitiatePaymentUseCase {
  final OrdersRepository _repository;

  InitiatePaymentUseCase(this._repository);

  Future<String> call(String orderId) async {
    return await _repository.initiatePayment(orderId);
  }
}
