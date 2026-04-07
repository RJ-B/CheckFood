import 'package:freezed_annotation/freezed_annotation.dart';
import 'opening_hours_model.dart';

part 'onboarding_hours_request_model.freezed.dart';
part 'onboarding_hours_request_model.g.dart';

/// Request payload pro uložení otevíracích dob restaurace v průběhu onboarding kroku 2.
@freezed
class OnboardingHoursRequestModel with _$OnboardingHoursRequestModel {
  const factory OnboardingHoursRequestModel({
    required List<OpeningHoursModel> openingHours,
  }) = _OnboardingHoursRequestModel;

  factory OnboardingHoursRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingHoursRequestModelFromJson(json);
}
