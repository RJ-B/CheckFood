import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/auth_tokens.dart';
import '../../../../utils/converters/duration_epoch_converter.dart';

part 'token_response_model.freezed.dart';
part 'token_response_model.g.dart';

@freezed
class TokenResponseModel with _$TokenResponseModel {
  const TokenResponseModel._(); // Nutné pro definování metod

  const factory TokenResponseModel({
    @JsonKey(name: 'accessToken') required String accessToken,
    @JsonKey(name: 'refreshToken') required String refreshToken,

    @JsonKey(name: 'expiresIn')
    @DurationEpochConverter()
    required Duration expiresIn,
  }) = _TokenResponseModel;

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseModelFromJson(json);

  /// Mapování na doménovou entitu AuthTokens.
  /// UI ani BLoC nepoznají, zda tokeny přišly z loginu nebo z refreshe,
  /// protože oba modely vrací stejnou čistou entitu.
  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
