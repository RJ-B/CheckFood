import '../entities/onboarding_menu_category.dart';
import '../repositories/onboarding_repository.dart';

/// Returns the full menu (categories with items) for the owner's restaurant.
class GetOwnerMenuUseCase {
  final OnboardingRepository _repository;

  GetOwnerMenuUseCase(this._repository);

  Future<List<OnboardingMenuCategory>> call() => _repository.getMenu();
}
