import '../repositories/orders_repository.dart';

/// Vrátí aktuální stav platby pro zadanou objednávku.
class GetPaymentStatusUseCase {
  final OrdersRepository _repository;

  GetPaymentStatusUseCase(this._repository);

  Future<String> call(String orderId) async {
    return await _repository.getPaymentStatus(orderId);
  }
}
