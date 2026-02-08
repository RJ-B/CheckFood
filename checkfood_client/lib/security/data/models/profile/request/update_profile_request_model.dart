import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request_model.freezed.dart';
part 'update_profile_request_model.g.dart';

@freezed
class UpdateProfileRequestModel with _$UpdateProfileRequestModel {
  const factory UpdateProfileRequestModel({
    @JsonKey(name: 'firstName') required String firstName,
    @JsonKey(name: 'lastName') required String lastName,
    // Zde můžete přidat další pole, která backend dovoluje měnit
    // např. @JsonKey(name: 'phoneNumber') String? phoneNumber,
  }) = _UpdateProfileRequestModel;

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestModelFromJson(json);
}
