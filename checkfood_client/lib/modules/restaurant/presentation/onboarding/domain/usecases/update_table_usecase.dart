import '../entities/onboarding_table.dart';
import '../repositories/onboarding_repository.dart';

/// Aktualizuje označení stolu, kapacitu, aktivní stav a volitelné umístění v panoramatu.
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
