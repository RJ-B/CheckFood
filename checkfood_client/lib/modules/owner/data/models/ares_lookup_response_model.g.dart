// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ares_lookup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AresLookupResponseModelImpl _$$AresLookupResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AresLookupResponseModelImpl(
  ico: json['ico'] as String,
  companyName: json['companyName'] as String,
  restaurantId: json['restaurantId'] as String?,
  requiresIdentityVerification:
      json['requiresIdentityVerification'] as bool? ?? true,
  statutoryPersons:
      (json['statutoryPersons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AresLookupResponseModelImplToJson(
  _$AresLookupResponseModelImpl instance,
) => <String, dynamic>{
  'ico': instance.ico,
  'companyName': instance.companyName,
  'restaurantId': instance.restaurantId,
  'requiresIdentityVerification': instance.requiresIdentityVerification,
  'statutoryPersons': instance.statutoryPersons,
};
