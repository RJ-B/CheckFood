import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_error_response_model.freezed.dart';
part 'auth_error_response_model.g.dart';

@freezed
class AuthErrorResponseModel with _$AuthErrorResponseModel {
  // Privátní konstruktor pro umožnění definice vlastních metod (jako toEntity)
  const AuthErrorResponseModel._();

  @JsonSerializable(explicitToJson: true)
  const factory AuthErrorResponseModel({
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'isExpired') @Default(false) bool isExpired,
  }) = _AuthErrorResponseModel;

  factory AuthErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthErrorResponseModelFromJson(json);

  /// Volitelně: Pokud byste chtěli chybu převádět na doménovou Failure entitu,
  /// můžete zde implementovat toEntity() podobně jako u AuthResponseModel.
}
