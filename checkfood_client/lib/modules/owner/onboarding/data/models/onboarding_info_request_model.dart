import 'package:freezed_annotation/freezed_annotation.dart';
import 'address_model.dart';

part 'onboarding_info_request_model.freezed.dart';
part 'onboarding_info_request_model.g.dart';

/// Request payload pro uložení základních informací o restauraci v průběhu onboarding kroku 1.
@freezed
class OnboardingInfoRequestModel with _$OnboardingInfoRequestModel {
  const factory OnboardingInfoRequestModel({
    required String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  }) = _OnboardingInfoRequestModel;

  factory OnboardingInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingInfoRequestModelFromJson(json);
}
