import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';
import '../../../../domain/entities/auth_tokens.dart';
import '../../../../utils/converters/duration_epoch_converter.dart';

part 'token_response_model.freezed.dart';
part 'token_response_model.g.dart';

@freezed
class TokenResponseModel with _$TokenResponseModel {
  const TokenResponseModel._();

  const factory TokenResponseModel({
    @JsonKey(name: SecurityJsonKeys.accessToken) required String accessToken,
    @JsonKey(name: SecurityJsonKeys.refreshToken) required String refreshToken,
    @JsonKey(name: SecurityJsonKeys.expiresIn)
    @DurationEpochConverter()
    required Duration expiresIn,
  }) = _TokenResponseModel;

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseModelFromJson(json);

  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
