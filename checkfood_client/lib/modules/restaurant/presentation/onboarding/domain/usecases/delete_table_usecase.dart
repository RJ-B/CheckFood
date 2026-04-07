import '../repositories/onboarding_repository.dart';

/// Trvale odstraní stůl z půdorysu restaurace.
class DeleteTableUseCase {
  final OnboardingRepository _repository;

  DeleteTableUseCase(this._repository);

  Future<void> call(String id) => _repository.deleteTable(id);
}
