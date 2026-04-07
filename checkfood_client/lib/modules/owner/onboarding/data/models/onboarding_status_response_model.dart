import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/onboarding_status.dart';

part 'onboarding_status_response_model.freezed.dart';
part 'onboarding_status_response_model.g.dart';

/// API response model indicating which onboarding steps the owner has completed.
@freezed
class OnboardingStatusResponseModel with _$OnboardingStatusResponseModel {
  const OnboardingStatusResponseModel._();

  const factory OnboardingStatusResponseModel({
    @Default(false) bool onboardingCompleted,
    @Default(false) bool hasInfo,
    @Default(false) bool hasHours,
    @Default(false) bool hasTables,
    @Default(false) bool hasMenu,
    @Default(false) bool hasPanorama,
  }) = _OnboardingStatusResponseModel;

  factory OnboardingStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStatusResponseModelFromJson(json);

  OnboardingStatus toEntity() => OnboardingStatus(
        onboardingCompleted: onboardingCompleted,
        hasInfo: hasInfo,
        hasHours: hasHours,
        hasTables: hasTables,
        hasMenu: hasMenu,
        hasPanorama: hasPanorama,
      );
}
