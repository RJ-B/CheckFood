import '../repositories/orders_repository.dart';

/// Initiates the payment flow for the given order and returns the redirect URL.
class InitiatePaymentUseCase {
  final OrdersRepository _repository;

  InitiatePaymentUseCase(this._repository);

  Future<String> call(String orderId) async {
    return await _repository.initiatePayment(orderId);
  }
}
