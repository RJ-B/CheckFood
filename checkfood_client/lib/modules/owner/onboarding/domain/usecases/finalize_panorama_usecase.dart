import '../entities/panorama_session.dart';
import '../repositories/onboarding_repository.dart';

class FinalizePanoramaUseCase {
  final OnboardingRepository _repository;

  FinalizePanoramaUseCase(this._repository);

  Future<PanoramaSession> call(String sessionId) =>
      _repository.finalizePanoramaSession(sessionId);
}
