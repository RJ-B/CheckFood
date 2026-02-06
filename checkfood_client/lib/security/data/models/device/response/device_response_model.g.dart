// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceResponseModelImpl _$$DeviceResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$DeviceResponseModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  deviceIdentifier: json['deviceIdentifier'] as String,
  type: json['type'] as String,
  ipAddress: json['ipAddress'] as String,
  lastActive: DateTime.parse(json['lastActive'] as String),
  isCurrent: json['isCurrent'] as bool,
);

Map<String, dynamic> _$$DeviceResponseModelImplToJson(
  _$DeviceResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'deviceIdentifier': instance.deviceIdentifier,
  'type': instance.type,
  'ipAddress': instance.ipAddress,
  'lastActive': instance.lastActive.toIso8601String(),
  'isCurrent': instance.isCurrent,
};
