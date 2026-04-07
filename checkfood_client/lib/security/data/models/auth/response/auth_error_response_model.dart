import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'auth_error_response_model.freezed.dart';
part 'auth_error_response_model.g.dart';

/// Datový model pro chybovou odpověď z autentizačních endpointů.
@freezed
class AuthErrorResponseModel with _$AuthErrorResponseModel {
  const AuthErrorResponseModel._();

  @JsonSerializable(explicitToJson: true)
  const factory AuthErrorResponseModel({
    @JsonKey(name: SecurityJsonKeys.message) required String message,
    @JsonKey(name: SecurityJsonKeys.email) String? email,
    @JsonKey(name: SecurityJsonKeys.isExpired) @Default(false) bool isExpired,
  }) = _AuthErrorResponseModel;

  factory AuthErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthErrorResponseModelFromJson(json);
}
