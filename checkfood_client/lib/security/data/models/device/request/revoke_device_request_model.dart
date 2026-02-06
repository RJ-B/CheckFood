import 'package:freezed_annotation/freezed_annotation.dart';

part 'revoke_device_request_model.freezed.dart';
part 'revoke_device_request_model.g.dart';

@freezed
class RevokeDeviceRequestModel with _$RevokeDeviceRequestModel {
  const factory RevokeDeviceRequestModel({
    // Backend potřebuje vědět, KTERÉ zařízení má odstřihnout.
    // Může to být 'id' (z databáze) nebo 'deviceIdentifier', záleží na backendu.
    // Většinou je bezpečnější používat ID záznamu.
    @JsonKey(name: 'deviceId') required String deviceId,

    // Volitelně: Můžeš chtít poslat heslo pro potvrzení, pokud je to citlivá akce
    // @JsonKey(name: 'password') String? password,
  }) = _RevokeDeviceRequestModel;

  factory RevokeDeviceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RevokeDeviceRequestModelFromJson(json);
}
