import 'package:freezed_annotation/freezed_annotation.dart';

part 'panorama_session.freezed.dart';

@freezed
class PanoramaSession with _$PanoramaSession {
  const factory PanoramaSession({
    required String id,
    required String status,
    @Default(0) int photoCount,
    String? resultUrl,
    String? createdAt,
    String? completedAt,
  }) = _PanoramaSession;
}
