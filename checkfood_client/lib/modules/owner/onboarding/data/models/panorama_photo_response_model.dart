import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/panorama_photo.dart';

part 'panorama_photo_response_model.freezed.dart';
part 'panorama_photo_response_model.g.dart';

@freezed
class PanoramaPhotoResponseModel with _$PanoramaPhotoResponseModel {
  const PanoramaPhotoResponseModel._();

  const factory PanoramaPhotoResponseModel({
    String? id,
    @Default(0) int angleIndex,
    @Default(0.0) double targetAngle,
    @Default(0.0) double actualAngle,
    String? photoUrl,
  }) = _PanoramaPhotoResponseModel;

  factory PanoramaPhotoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PanoramaPhotoResponseModelFromJson(json);

  PanoramaPhoto toEntity() => PanoramaPhoto(
        id: id ?? '',
        angleIndex: angleIndex,
        targetAngle: targetAngle,
        actualAngle: actualAngle,
        photoUrl: photoUrl,
      );
}
