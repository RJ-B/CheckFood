import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_status.freezed.dart';

@freezed
class OnboardingStatus with _$OnboardingStatus {
  const factory OnboardingStatus({
    @Default(false) bool onboardingCompleted,
    @Default(false) bool hasInfo,
    @Default(false) bool hasHours,
    @Default(false) bool hasTables,
    @Default(false) bool hasMenu,
    @Default(false) bool hasPanorama,
  }) = _OnboardingStatus;
}
