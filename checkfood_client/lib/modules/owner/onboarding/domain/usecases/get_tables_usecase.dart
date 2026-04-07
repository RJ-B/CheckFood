import '../entities/onboarding_table.dart';
import '../repositories/onboarding_repository.dart';

/// Vrátí všechny nakonfigurované stoly restaurace majitele.
class GetTablesUseCase {
  final OnboardingRepository _repository;

  GetTablesUseCase(this._repository);

  Future<List<OnboardingTable>> call() => _repository.getTables();
}
