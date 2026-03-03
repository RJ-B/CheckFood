import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

@freezed
class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    @JsonKey(name: SecurityJsonKeys.email) required String email,
    @JsonKey(name: SecurityJsonKeys.password) required String password,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.deviceName) required String deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) required String deviceType,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}
