import '../entities/onboarding_table.dart';
import '../repositories/onboarding_repository.dart';

/// Updates a table's label, capacity, active state, and optional panorama placement.
class UpdateTableUseCase {
  final OnboardingRepository _repository;

  UpdateTableUseCase(this._repository);

  Future<OnboardingTable> call(
    String id, {
    required String label,
    required int capacity,
    bool active = true,
    double? yaw,
    double? pitch,
  }) =>
      _repository.updateTable(id, label: label, capacity: capacity, active: active, yaw: yaw, pitch: pitch);
}
