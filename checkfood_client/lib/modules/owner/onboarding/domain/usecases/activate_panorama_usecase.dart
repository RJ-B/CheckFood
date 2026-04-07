import '../repositories/onboarding_repository.dart';

/// Aktivuje dokončenou panorama session a nastaví ji jako živé panorama restaurace.
class ActivatePanoramaUseCase {
  final OnboardingRepository _repository;

  ActivatePanoramaUseCase(this._repository);

  Future<void> call(String sessionId) => _repository.activatePanorama(sessionId);
}
