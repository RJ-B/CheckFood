import '../entities/onboarding_table.dart';
import '../repositories/onboarding_repository.dart';

/// Přidá nový stůl do půdorysu restaurace.
class AddTableUseCase {
  final OnboardingRepository _repository;

  AddTableUseCase(this._repository);

  Future<OnboardingTable> call({
    required String label,
    required int capacity,
    bool active = true,
  }) =>
      _repository.addTable(label: label, capacity: capacity, active: active);
}
