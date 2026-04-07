import '../entities/menu_category.dart';
import '../repositories/orders_repository.dart';

/// Načte kategorie menu a položky pro zadanou restauraci.
class GetMenuUseCase {
  final OrdersRepository _repository;

  GetMenuUseCase(this._repository);

  Future<List<MenuCategory>> call(String restaurantId) async {
    return await _repository.getMenu(restaurantId);
  }
}
