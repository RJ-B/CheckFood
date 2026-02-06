import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/auth_tokens.dart';
import '../../../../utils/converters/duration_epoch_converter.dart';
import '../../profile/response/user_response_model.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const AuthResponseModel._();

  @JsonSerializable(explicitToJson: true)
  const factory AuthResponseModel({
    @JsonKey(name: 'accessToken') required String accessToken,
    @JsonKey(name: 'refreshToken') required String refreshToken,
    @JsonKey(name: 'expiresIn')
    @DurationEpochConverter()
    required Duration expiresIn,

    // Používáme UserResponseModel místo UserModel
    @JsonKey(name: 'user') required UserResponseModel user,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  /// Mapování na doménovou entitu AuthTokens.
  /// Umožňuje Repozitáři snadno extrahovat tokeny v čisté formě.
  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
