// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateProfileRequestModelImpl _$$UpdateProfileRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProfileRequestModelImpl(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  profileImageUrl: json['profileImageUrl'] as String?,
  phone: json['phone'] as String?,
  addressStreet: json['addressStreet'] as String?,
  addressCity: json['addressCity'] as String?,
  addressPostalCode: json['addressPostalCode'] as String?,
  addressCountry: json['addressCountry'] as String?,
);

Map<String, dynamic> _$$UpdateProfileRequestModelImplToJson(
  _$UpdateProfileRequestModelImpl instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profileImageUrl': instance.profileImageUrl,
  'phone': instance.phone,
  'addressStreet': instance.addressStreet,
  'addressCity': instance.addressCity,
  'addressPostalCode': instance.addressPostalCode,
  'addressCountry': instance.addressCountry,
};
