import 'dart:typed_data';

import '../../../../../panorama/domain/entities/panorama_photo.dart';
import '../repositories/onboarding_repository.dart';

/// Nahraje jeden snímek pro panorama session pod zadaným úhlem.
class UploadPanoramaPhotoUseCase {
  final OnboardingRepository _repository;

  UploadPanoramaPhotoUseCase(this._repository);

  Future<PanoramaPhoto> call({
    required String sessionId,
    required int angleIndex,
    required double actualAngle,
    double? actualPitch,
    required Uint8List fileBytes,
    required String filename,
  }) =>
      _repository.uploadPhoto(sessionId, angleIndex, actualAngle, actualPitch, fileBytes, filename);
}
