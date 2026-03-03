import '../entities/panorama_session.dart';
import '../repositories/onboarding_repository.dart';

class CreatePanoramaSessionUseCase {
  final OnboardingRepository _repository;

  CreatePanoramaSessionUseCase(this._repository);

  Future<PanoramaSession> call() => _repository.createPanoramaSession();
}
