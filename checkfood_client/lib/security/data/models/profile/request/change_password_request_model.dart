import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'change_password_request_model.freezed.dart';
part 'change_password_request_model.g.dart';

/// Datový model pro požadavek změny hesla.
@freezed
class ChangePasswordRequestModel with _$ChangePasswordRequestModel {
  const factory ChangePasswordRequestModel({
    @JsonKey(name: SecurityJsonKeys.currentPassword)
    required String currentPassword,
    @JsonKey(name: SecurityJsonKeys.newPassword) required String newPassword,
    @JsonKey(name: SecurityJsonKeys.confirmPassword)
    required String confirmPassword,
  }) = _ChangePasswordRequestModel;

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestModelFromJson(json);
}
