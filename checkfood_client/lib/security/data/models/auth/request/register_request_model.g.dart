// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRequestModelImpl _$$RegisterRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestModelImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirmPassword'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  deviceIdentifier: json['deviceIdentifier'] as String,
  deviceName: json['deviceName'] as String,
  deviceType: json['deviceType'] as String,
);

Map<String, dynamic> _$$RegisterRequestModelImplToJson(
  _$RegisterRequestModelImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'confirmPassword': instance.confirmPassword,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'deviceIdentifier': instance.deviceIdentifier,
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
};
