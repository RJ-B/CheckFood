import '../entities/onboarding_menu_category.dart';
import '../repositories/onboarding_repository.dart';

/// Aktualizuje název a pořadí existující kategorie menu.
class UpdateCategoryUseCase {
  final OnboardingRepository _repository;

  UpdateCategoryUseCase(this._repository);

  Future<OnboardingMenuCategory> call(String id, {required String name, int sortOrder = 0}) =>
      _repository.updateCategory(id, name: name, sortOrder: sortOrder);
}
