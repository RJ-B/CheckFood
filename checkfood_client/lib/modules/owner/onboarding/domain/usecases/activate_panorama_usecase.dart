import '../repositories/onboarding_repository.dart';

class ActivatePanoramaUseCase {
  final OnboardingRepository _repository;

  ActivatePanoramaUseCase(this._repository);

  Future<void> call(String sessionId) => _repository.activatePanorama(sessionId);
}
