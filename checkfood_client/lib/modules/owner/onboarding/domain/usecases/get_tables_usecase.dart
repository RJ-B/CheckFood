import '../entities/onboarding_table.dart';
import '../repositories/onboarding_repository.dart';

class GetTablesUseCase {
  final OnboardingRepository _repository;

  GetTablesUseCase(this._repository);

  Future<List<OnboardingTable>> call() => _repository.getTables();
}
