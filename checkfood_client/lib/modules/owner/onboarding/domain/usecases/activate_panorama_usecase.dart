import '../repositories/onboarding_repository.dart';

/// Activates a completed panorama session, making it the live panorama for the restaurant.
class ActivatePanoramaUseCase {
  final OnboardingRepository _repository;

  ActivatePanoramaUseCase(this._repository);

  Future<void> call(String sessionId) => _repository.activatePanorama(sessionId);
}
