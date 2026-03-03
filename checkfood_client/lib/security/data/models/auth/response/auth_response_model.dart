import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';
import '../../../../domain/entities/auth_tokens.dart';
import '../../../../utils/converters/duration_epoch_converter.dart';
import 'user_response_model.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const AuthResponseModel._();

  @JsonSerializable(explicitToJson: true)
  const factory AuthResponseModel({
    @JsonKey(name: SecurityJsonKeys.accessToken) required String accessToken,
    @JsonKey(name: SecurityJsonKeys.refreshToken) required String refreshToken,
    @JsonKey(name: SecurityJsonKeys.expiresIn)
    @DurationEpochConverter()
    required Duration expiresIn,

    @JsonKey(name: SecurityJsonKeys.user) required UserResponseModel user,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
