import '../entities/onboarding_menu_item.dart';
import '../repositories/onboarding_repository.dart';

/// Aktualizuje název, popis, cenu a dostupnost existující položky menu.
class UpdateMenuItemUseCase {
  final OnboardingRepository _repository;

  UpdateMenuItemUseCase(this._repository);

  Future<OnboardingMenuItem> call(
    String id, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  }) =>
      _repository.updateItem(
        id,
        name: name,
        description: description,
        priceMinor: priceMinor,
        currency: currency,
        imageUrl: imageUrl,
        available: available,
        sortOrder: sortOrder,
      );
}
