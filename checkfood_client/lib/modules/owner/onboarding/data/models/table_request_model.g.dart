// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableRequestModelImpl _$$TableRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$TableRequestModelImpl(
  label: json['label'] as String,
  capacity: (json['capacity'] as num).toInt(),
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$$TableRequestModelImplToJson(
  _$TableRequestModelImpl instance,
) => <String, dynamic>{
  'label': instance.label,
  'capacity': instance.capacity,
  'active': instance.active,
};
