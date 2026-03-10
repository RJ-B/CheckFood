import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/profile/request/update_profile_request_model.dart';
import '../../../data/models/profile/request/change_password_request_model.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  // Načtení profilu (GET /me)
  const factory UserEvent.profileRequested() = ProfileRequested;

  // ✅ Načtení zařízení (GET /devices)
  const factory UserEvent.devicesRequested() = DevicesRequested;

  const factory UserEvent.profileUpdated(UpdateProfileRequestModel request) =
      ProfileUpdated;

  const factory UserEvent.passwordChangeRequested(
    ChangePasswordRequestModel request,
  ) = PasswordChangeRequested;

  const factory UserEvent.allDevicesLogoutRequested() =
      AllDevicesLogoutRequested;

  // ✅ ID je int
  const factory UserEvent.deviceLoggedOut(int deviceId) = DeviceLoggedOut;

  // 🧹 ✅ NOVÝ EVENT: Vyčištění dat při odhlášení (aby nezůstala v paměti)
  const factory UserEvent.clearDataRequested() = ClearDataRequested;

  // Push notifikace
  const factory UserEvent.notificationPreferenceRequested() = NotificationPreferenceRequested;
  const factory UserEvent.notificationToggled(bool enabled) = NotificationToggled;

  // Profile photo upload
  const factory UserEvent.profilePhotoUploadRequested(
    Uint8List imageBytes,
    String filename,
  ) = ProfilePhotoUploadRequested;
}
