import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';

part 'logout_request_model.freezed.dart';
part 'logout_request_model.g.dart';

@freezed
class LogoutRequestModel with _$LogoutRequestModel {
  const factory LogoutRequestModel({
    @JsonKey(name: SecurityJsonKeys.refreshToken) required String refreshToken,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required String deviceIdentifier,
  }) = _LogoutRequestModel;

  factory LogoutRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestModelFromJson(json);
}
