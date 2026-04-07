import '../entities/onboarding_status.dart';
import '../repositories/onboarding_repository.dart';

/// Vrátí aktuální postup onboardingu majitele s informací o tom, které kroky byly dokončeny.
class GetOnboardingStatusUseCase {
  final OnboardingRepository _repository;

  GetOnboardingStatusUseCase(this._repository);

  Future<OnboardingStatus> call() => _repository.getOnboardingStatus();
}
