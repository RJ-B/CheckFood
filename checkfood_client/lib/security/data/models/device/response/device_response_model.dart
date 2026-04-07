import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../config/security_json_keys.dart';
import '../../../../domain/entities/device.dart';

part 'device_response_model.freezed.dart';
part 'device_response_model.g.dart';

/// Datový model pro zařízení vrácené z backendu.
@freezed
class DeviceResponseModel with _$DeviceResponseModel {
  const DeviceResponseModel._();

  const factory DeviceResponseModel({
    @JsonKey(name: SecurityJsonKeys.id) required int id,
    @JsonKey(name: SecurityJsonKeys.deviceName) required String? deviceName,
    @JsonKey(name: SecurityJsonKeys.deviceType) required String? deviceType,
    @JsonKey(name: SecurityJsonKeys.deviceIdentifier)
    required String deviceIdentifier,
    @JsonKey(name: SecurityJsonKeys.lastLogin) required DateTime? lastLogin,
    @JsonKey(name: SecurityJsonKeys.isCurrentDevice)
    @Default(false)
    bool isCurrentDevice,
    @JsonKey(name: SecurityJsonKeys.deviceActive)
    @Default(true)
    bool active,
  }) = _DeviceResponseModel;

  factory DeviceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceResponseModelFromJson(json);

  Device toEntity() {
    return Device(
      id: id,
      deviceName: deviceName ?? 'Neznámé zařízení',
      deviceType: deviceType ?? 'Unknown',
      deviceIdentifier: deviceIdentifier,
      lastLogin: lastLogin ?? DateTime.now(),
      isCurrentDevice: isCurrentDevice,
      isActive: active,
    );
  }
}
