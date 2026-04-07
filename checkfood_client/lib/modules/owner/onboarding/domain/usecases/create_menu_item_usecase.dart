import '../entities/onboarding_menu_item.dart';
import '../repositories/onboarding_repository.dart';

/// Vytvoří novou položku menu uvnitř zadané kategorie.
class CreateMenuItemUseCase {
  final OnboardingRepository _repository;

  CreateMenuItemUseCase(this._repository);

  Future<OnboardingMenuItem> call(
    String categoryId, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  }) =>
      _repository.createItem(
        categoryId,
        name: name,
        description: description,
        priceMinor: priceMinor,
        currency: currency,
        imageUrl: imageUrl,
        available: available,
        sortOrder: sortOrder,
      );
}
