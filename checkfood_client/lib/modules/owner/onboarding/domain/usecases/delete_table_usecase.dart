import '../repositories/onboarding_repository.dart';

/// Permanently removes a table from the restaurant's floor plan.
class DeleteTableUseCase {
  final OnboardingRepository _repository;

  DeleteTableUseCase(this._repository);

  Future<void> call(String id) => _repository.deleteTable(id);
}
