// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_info_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingInfoRequestModelImpl _$$OnboardingInfoRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$OnboardingInfoRequestModelImpl(
  name: json['name'] as String,
  description: json['description'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  address:
      json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
  cuisineType: json['cuisineType'] as String?,
);

Map<String, dynamic> _$$OnboardingInfoRequestModelImplToJson(
  _$OnboardingInfoRequestModelImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'phone': instance.phone,
  'email': instance.email,
  'address': instance.address,
  'cuisineType': instance.cuisineType,
};
