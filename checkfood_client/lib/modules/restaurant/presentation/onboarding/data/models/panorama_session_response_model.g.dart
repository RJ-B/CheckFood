// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panorama_session_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PanoramaSessionResponseModelImpl _$$PanoramaSessionResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PanoramaSessionResponseModelImpl(
  id: json['id'] as String?,
  status: json['status'] as String?,
  photoCount: (json['photoCount'] as num?)?.toInt() ?? 0,
  resultUrl: json['resultUrl'] as String?,
  createdAt: json['createdAt'] as String?,
  completedAt: json['completedAt'] as String?,
);

Map<String, dynamic> _$$PanoramaSessionResponseModelImplToJson(
  _$PanoramaSessionResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'photoCount': instance.photoCount,
  'resultUrl': instance.resultUrl,
  'createdAt': instance.createdAt,
  'completedAt': instance.completedAt,
};
