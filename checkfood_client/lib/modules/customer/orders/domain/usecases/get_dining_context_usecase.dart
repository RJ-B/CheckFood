import '../entities/dining_context.dart';
import '../repositories/orders_repository.dart';

/// Retrieves the active dining context (table, restaurant, reservation) for the current user.
class GetDiningContextUseCase {
  final OrdersRepository _repository;

  GetDiningContextUseCase(this._repository);

  Future<DiningContext> call() async {
    return await _repository.getDiningContext();
  }
}
