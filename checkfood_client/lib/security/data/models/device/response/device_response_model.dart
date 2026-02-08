import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/device.dart';

part 'device_response_model.freezed.dart';
part 'device_response_model.g.dart';

@freezed
class DeviceResponseModel with _$DeviceResponseModel {
  // Prázdný konstruktor pro definici metod
  const DeviceResponseModel._();

  const factory DeviceResponseModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'deviceIdentifier') required String deviceIdentifier,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'ipAddress') required String ipAddress,
    @JsonKey(name: 'lastActive') required DateTime lastActive,
    @JsonKey(name: 'isCurrent') required bool isCurrent,
  }) = _DeviceResponseModel;

  factory DeviceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceResponseModelFromJson(json);

  /// Mapování na tvoji Freezed entitu Device
  Device toEntity() {
    return Device(
      id: id,
      deviceName: name,
      deviceType: type ?? 'Unknown',
      lastLogin: lastActive,
      isCurrentDevice: isCurrent,
    );
  }
}
