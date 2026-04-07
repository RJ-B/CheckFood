import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/panorama_session.dart';

part 'panorama_session_response_model.freezed.dart';
part 'panorama_session_response_model.g.dart';

/// API response model for a panorama stitching session.
@freezed
class PanoramaSessionResponseModel with _$PanoramaSessionResponseModel {
  const PanoramaSessionResponseModel._();

  const factory PanoramaSessionResponseModel({
    String? id,
    String? status,
    @Default(0) int photoCount,
    String? resultUrl,
    String? createdAt,
    String? completedAt,
  }) = _PanoramaSessionResponseModel;

  factory PanoramaSessionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PanoramaSessionResponseModelFromJson(json);

  PanoramaSession toEntity() => PanoramaSession(
        id: id ?? '',
        status: status ?? 'UPLOADING',
        photoCount: photoCount,
        resultUrl: resultUrl,
        createdAt: createdAt,
        completedAt: completedAt,
      );
}
