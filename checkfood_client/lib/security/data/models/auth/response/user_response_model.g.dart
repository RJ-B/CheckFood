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
  authorities:
      (json['authorities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  needsRestaurantClaim: json['needsRestaurantClaim'] as bool? ?? false,
  needsOnboarding: json['needsOnboarding'] as bool? ?? false,
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
);

Map<String, dynamic> _$$UserResponseModelImplToJson(
  _$UserResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'role': instance.role,
  'isActive': instance.isActive,
  'authorities': instance.authorities,
  'needsRestaurantClaim': instance.needsRestaurantClaim,
  'needsOnboarding': instance.needsOnboarding,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phone': instance.phone,
};
