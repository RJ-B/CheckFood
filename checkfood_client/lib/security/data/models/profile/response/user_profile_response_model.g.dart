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
  profileImageUrl: json['profileImageUrl'] as String?,
  isActive: json['isActive'] as bool? ?? false,
  lastLogin:
      json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  role: json['role'] as String,
  authProvider: json['authProvider'] as String? ?? 'LOCAL',
);

Map<String, dynamic> _$$UserProfileResponseModelImplToJson(
  _$UserProfileResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profileImageUrl': instance.profileImageUrl,
  'isActive': instance.isActive,
  'lastLogin': instance.lastLogin?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'role': instance.role,
  'authProvider': instance.authProvider,
};
