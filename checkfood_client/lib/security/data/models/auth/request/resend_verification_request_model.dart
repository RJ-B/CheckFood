import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'resend_verification_request_model.freezed.dart';
part 'resend_verification_request_model.g.dart';

/// Datový model pro požadavek opětovného odeslání verifikačního kódu.
@freezed
class ResendVerificationRequestModel with _$ResendVerificationRequestModel {
  const factory ResendVerificationRequestModel({
    @JsonKey(name: SecurityJsonKeys.email) required String email,
  }) = _ResendVerificationRequestModel;

  factory ResendVerificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResendVerificationRequestModelFromJson(json);
}
