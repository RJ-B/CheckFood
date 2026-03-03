// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OAuthLoginRequestModelImpl _$$OAuthLoginRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$OAuthLoginRequestModelImpl(
  idToken: json['idToken'] as String,
  provider: json['provider'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  deviceIdentifier: json['deviceIdentifier'] as String,
  deviceName: json['deviceName'] as String,
  deviceType: json['deviceType'] as String,
);

Map<String, dynamic> _$$OAuthLoginRequestModelImplToJson(
  _$OAuthLoginRequestModelImpl instance,
) => <String, dynamic>{
  'idToken': instance.idToken,
  'provider': instance.provider,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'deviceIdentifier': instance.deviceIdentifier,
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
};
