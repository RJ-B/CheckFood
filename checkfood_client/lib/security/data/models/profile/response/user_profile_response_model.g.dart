// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileResponseModelImpl _$$UserProfileResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileResponseModelImpl(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  devices:
      (json['devices'] as List<dynamic>)
          .map((e) => DeviceResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$UserProfileResponseModelImplToJson(
  _$UserProfileResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'roles': instance.roles,
  'devices': instance.devices,
};
