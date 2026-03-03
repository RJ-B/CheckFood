import '../entities/menu_category.dart';
import '../repositories/orders_repository.dart';

class GetMenuUseCase {
  final OrdersRepository _repository;

  GetMenuUseCase(this._repository);

  Future<List<MenuCategory>> call(String restaurantId) async {
    return await _repository.getMenu(restaurantId);
  }
}
