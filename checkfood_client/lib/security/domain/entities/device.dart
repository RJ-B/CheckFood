import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';

@freezed
class Device with _$Device {
  const factory Device({
    required int id,
    required String deviceName,
    required String deviceType,
    required String deviceIdentifier,
    required DateTime lastLogin,
    required bool isCurrentDevice,
  }) = _Device;
}
