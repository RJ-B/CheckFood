import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'oauth_login_request_model.freezed.dart';
part 'oauth_login_request_model.g.dart';

/// Datový model pro OAuth přihlašovací požadavek (Google nebo Apple).
@freezed
class OAuthLoginRequestModel with _$OAuthLoginRequestModel {
  const factory OAuthLoginRequestModel({
    @JsonKey(name: SecurityJsonKeys.idToken) required String idToken,
    @JsonKey(name: SecurityJsonKeys.provider) required String provider,
    @JsonKey(name: SecurityJsonKeys.email) required String email,
    @JsonKey(name: SecurityJsonKeys.firstName) String? firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String? lastName,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.deviceName) required String deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) required String deviceType,
  }) = _OAuthLoginRequestModel;

  factory OAuthLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OAuthLoginRequestModelFromJson(json);
}
