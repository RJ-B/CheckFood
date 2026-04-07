import '../entities/onboarding_menu_category.dart';
import '../repositories/onboarding_repository.dart';

/// Vytvoří novou kategorii menu pro restauraci majitele.
class CreateCategoryUseCase {
  final OnboardingRepository _repository;

  CreateCategoryUseCase(this._repository);

  Future<OnboardingMenuCategory> call({required String name, int sortOrder = 0}) =>
      _repository.createCategory(name: name, sortOrder: sortOrder);
}
