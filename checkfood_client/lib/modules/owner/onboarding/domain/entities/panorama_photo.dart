import 'package:freezed_annotation/freezed_annotation.dart';

part 'panorama_photo.freezed.dart';

@freezed
class PanoramaPhoto with _$PanoramaPhoto {
  const factory PanoramaPhoto({
    required String id,
    @Default(0) int angleIndex,
    @Default(0.0) double targetAngle,
    @Default(0.0) double actualAngle,
    String? photoUrl,
  }) = _PanoramaPhoto;
}
