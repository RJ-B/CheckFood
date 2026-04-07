import '../entities/onboarding_table.dart';
import '../repositories/onboarding_repository.dart';

/// Returns all tables configured for the owner's restaurant.
class GetTablesUseCase {
  final OnboardingRepository _repository;

  GetTablesUseCase(this._repository);

  Future<List<OnboardingTable>> call() => _repository.getTables();
}
