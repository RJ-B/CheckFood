import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'update_profile_request_model.freezed.dart';
part 'update_profile_request_model.g.dart';

@freezed
class UpdateProfileRequestModel with _$UpdateProfileRequestModel {
  const factory UpdateProfileRequestModel({
    @JsonKey(name: SecurityJsonKeys.firstName) required String firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) required String lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) String? profileImageUrl,
  }) = _UpdateProfileRequestModel;

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestModelFromJson(json);
}
