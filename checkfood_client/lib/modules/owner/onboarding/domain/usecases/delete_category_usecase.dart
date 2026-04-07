import '../repositories/onboarding_repository.dart';

/// Permanently removes a menu category and all its items.
class DeleteCategoryUseCase {
  final OnboardingRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<void> call(String id) => _repository.deleteCategory(id);
}
