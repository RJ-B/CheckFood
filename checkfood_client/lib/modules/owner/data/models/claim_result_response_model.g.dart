// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_result_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClaimResultResponseModelImpl _$$ClaimResultResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$ClaimResultResponseModelImpl(
  success: json['success'] as bool? ?? false,
  matched: json['matched'] as bool? ?? false,
  membershipCreated: json['membershipCreated'] as bool? ?? false,
  emailFallbackAvailable: json['emailFallbackAvailable'] as bool? ?? false,
  emailHint: json['emailHint'] as String?,
);

Map<String, dynamic> _$$ClaimResultResponseModelImplToJson(
  _$ClaimResultResponseModelImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'matched': instance.matched,
  'membershipCreated': instance.membershipCreated,
  'emailFallbackAvailable': instance.emailFallbackAvailable,
  'emailHint': instance.emailHint,
};
