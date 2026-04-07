// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_status_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingStatusResponseModelImpl
_$$OnboardingStatusResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$OnboardingStatusResponseModelImpl(
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      hasInfo: json['hasInfo'] as bool? ?? false,
      hasHours: json['hasHours'] as bool? ?? false,
      hasTables: json['hasTables'] as bool? ?? false,
      hasMenu: json['hasMenu'] as bool? ?? false,
      hasPanorama: json['hasPanorama'] as bool? ?? false,
    );

Map<String, dynamic> _$$OnboardingStatusResponseModelImplToJson(
  _$OnboardingStatusResponseModelImpl instance,
) => <String, dynamic>{
  'onboardingCompleted': instance.onboardingCompleted,
  'hasInfo': instance.hasInfo,
  'hasHours': instance.hasHours,
  'hasTables': instance.hasTables,
  'hasMenu': instance.hasMenu,
  'hasPanorama': instance.hasPanorama,
};
