import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'register_request_model.freezed.dart';
part 'register_request_model.g.dart';

@freezed
class RegisterRequestModel with _$RegisterRequestModel {
  const factory RegisterRequestModel({
    @JsonKey(name: SecurityJsonKeys.email) required String email,
    @JsonKey(name: SecurityJsonKeys.password) required String password,
    @JsonKey(name: SecurityJsonKeys.firstName) required String firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) required String lastName,
  }) = _RegisterRequestModel;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);
}
