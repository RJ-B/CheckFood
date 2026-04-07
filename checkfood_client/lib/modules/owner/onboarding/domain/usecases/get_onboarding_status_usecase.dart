import '../entities/onboarding_status.dart';
import '../repositories/onboarding_repository.dart';

/// Returns the owner's current onboarding progress, indicating which steps have been completed.
class GetOnboardingStatusUseCase {
  final OnboardingRepository _repository;

  GetOnboardingStatusUseCase(this._repository);

  Future<OnboardingStatus> call() => _repository.getOnboardingStatus();
}
