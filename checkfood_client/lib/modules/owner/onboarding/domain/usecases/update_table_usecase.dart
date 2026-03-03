import '../entities/onboarding_table.dart';
import '../repositories/onboarding_repository.dart';

class UpdateTableUseCase {
  final OnboardingRepository _repository;

  UpdateTableUseCase(this._repository);

  Future<OnboardingTable> call(
    String id, {
    required String label,
    required int capacity,
    bool active = true,
  }) =>
      _repository.updateTable(id, label: label, capacity: capacity, active: active);
}
