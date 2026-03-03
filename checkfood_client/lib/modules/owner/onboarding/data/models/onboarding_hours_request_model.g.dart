// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_hours_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingHoursRequestModelImpl _$$OnboardingHoursRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$OnboardingHoursRequestModelImpl(
  openingHours:
      (json['openingHours'] as List<dynamic>)
          .map((e) => OpeningHoursModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$OnboardingHoursRequestModelImplToJson(
  _$OnboardingHoursRequestModelImpl instance,
) => <String, dynamic>{'openingHours': instance.openingHours};
