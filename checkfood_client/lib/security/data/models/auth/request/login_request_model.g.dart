// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestModelImpl _$$LoginRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$LoginRequestModelImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  deviceIdentifier: json['deviceIdentifier'] as String,
  deviceName: json['deviceName'] as String,
  deviceType: json['deviceType'] as String,
);

Map<String, dynamic> _$$LoginRequestModelImplToJson(
  _$LoginRequestModelImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'deviceIdentifier': instance.deviceIdentifier,
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
};
