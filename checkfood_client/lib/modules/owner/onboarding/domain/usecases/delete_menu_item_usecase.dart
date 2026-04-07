import '../repositories/onboarding_repository.dart';

/// Permanently removes a single menu item.
class DeleteMenuItemUseCase {
  final OnboardingRepository _repository;

  DeleteMenuItemUseCase(this._repository);

  Future<void> call(String id) => _repository.deleteItem(id);
}
