import '../entities/onboarding_menu_category.dart';
import '../repositories/onboarding_repository.dart';

/// Creates a new menu category for the owner's restaurant.
class CreateCategoryUseCase {
  final OnboardingRepository _repository;

  CreateCategoryUseCase(this._repository);

  Future<OnboardingMenuCategory> call({required String name, int sortOrder = 0}) =>
      _repository.createCategory(name: name, sortOrder: sortOrder);
}
