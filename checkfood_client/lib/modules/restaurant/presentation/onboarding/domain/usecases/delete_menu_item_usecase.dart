import '../repositories/onboarding_repository.dart';

/// Trvale odstraní jednu položku menu.
class DeleteMenuItemUseCase {
  final OnboardingRepository _repository;

  DeleteMenuItemUseCase(this._repository);

  Future<void> call(String id) => _repository.deleteItem(id);
}
