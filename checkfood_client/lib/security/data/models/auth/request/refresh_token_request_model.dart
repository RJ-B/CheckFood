import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'refresh_token_request_model.freezed.dart';
part 'refresh_token_request_model.g.dart';

/// Datový model pro požadavek obnovy přístupového tokenu.
@freezed
class RefreshTokenRequestModel with _$RefreshTokenRequestModel {
  const factory RefreshTokenRequestModel({
    @JsonKey(name: SecurityJsonKeys.refreshToken) required String refreshToken,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required String deviceIdentifier,
  }) = _RefreshTokenRequestModel;

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestModelFromJson(json);
}
