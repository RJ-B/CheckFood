import '../entities/dining_context.dart';
import '../repositories/orders_repository.dart';

/// Načte aktivní stravovací kontext (stůl, restaurace, rezervace) pro aktuálního uživatele.
class GetDiningContextUseCase {
  final OrdersRepository _repository;

  GetDiningContextUseCase(this._repository);

  Future<DiningContext> call() async {
    return await _repository.getDiningContext();
  }
}
