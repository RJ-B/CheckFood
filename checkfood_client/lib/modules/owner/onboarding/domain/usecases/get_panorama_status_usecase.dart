import '../entities/panorama_session.dart';
import '../repositories/onboarding_repository.dart';

/// Dotazuje se na aktuální stav zpracování panorama stitching session.
class GetPanoramaStatusUseCase {
  final OnboardingRepository _repository;

  GetPanoramaStatusUseCase(this._repository);

  Future<PanoramaSession> call(String sessionId) =>
      _repository.getPanoramaSessionStatus(sessionId);
}
