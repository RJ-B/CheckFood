import '../repositories/onboarding_repository.dart';

/// Trvale odstraní kategorii menu a všechny její položky.
class DeleteCategoryUseCase {
  final OnboardingRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<void> call(String id) => _repository.deleteCategory(id);
}
