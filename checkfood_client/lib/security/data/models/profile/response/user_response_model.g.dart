// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserResponseModelImpl _$$UserResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserResponseModelImpl(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  role: json['role'] as String,
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$$UserResponseModelImplToJson(
  _$UserResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'role': instance.role,
  'isActive': instance.isActive,
};
