// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableResponseModelImpl _$$TableResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$TableResponseModelImpl(
  id: json['id'] as String?,
  label: json['label'] as String?,
  capacity: (json['capacity'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
  yaw: (json['yaw'] as num?)?.toDouble(),
  pitch: (json['pitch'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$TableResponseModelImplToJson(
  _$TableResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'capacity': instance.capacity,
  'active': instance.active,
  'yaw': instance.yaw,
  'pitch': instance.pitch,
};
