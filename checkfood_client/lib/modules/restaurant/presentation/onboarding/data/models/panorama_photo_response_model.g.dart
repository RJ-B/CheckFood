// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panorama_photo_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PanoramaPhotoResponseModelImpl _$$PanoramaPhotoResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PanoramaPhotoResponseModelImpl(
  id: json['id'] as String?,
  angleIndex: (json['angleIndex'] as num?)?.toInt() ?? 0,
  targetAngle: (json['targetAngle'] as num?)?.toDouble() ?? 0.0,
  actualAngle: (json['actualAngle'] as num?)?.toDouble() ?? 0.0,
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$$PanoramaPhotoResponseModelImplToJson(
  _$PanoramaPhotoResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'angleIndex': instance.angleIndex,
  'targetAngle': instance.targetAngle,
  'actualAngle': instance.actualAngle,
  'photoUrl': instance.photoUrl,
};
