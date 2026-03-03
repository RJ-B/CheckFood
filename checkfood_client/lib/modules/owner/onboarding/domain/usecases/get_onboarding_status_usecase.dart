import '../entities/onboarding_status.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingStatusUseCase {
  final OnboardingRepository _repository;

  GetOnboardingStatusUseCase(this._repository);

  Future<OnboardingStatus> call() => _repository.getOnboardingStatus();
}
