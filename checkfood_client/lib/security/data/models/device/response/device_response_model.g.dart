// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceResponseModelImpl _$$DeviceResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$DeviceResponseModelImpl(
  id: (json['id'] as num).toInt(),
  deviceName: json['deviceName'] as String?,
  deviceType: json['deviceType'] as String?,
  deviceIdentifier: json['deviceIdentifier'] as String,
  lastLogin:
      json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
  isCurrentDevice: json['currentDevice'] as bool? ?? false,
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$$DeviceResponseModelImplToJson(
  _$DeviceResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
  'deviceIdentifier': instance.deviceIdentifier,
  'lastLogin': instance.lastLogin?.toIso8601String(),
  'currentDevice': instance.isCurrentDevice,
  'active': instance.active,
};
