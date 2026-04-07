import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/profile/request/update_profile_request_model.dart';
import '../../../data/models/profile/request/change_password_request_model.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.profileRequested() = ProfileRequested;
  const factory UserEvent.devicesRequested() = DevicesRequested;

  const factory UserEvent.profileUpdated(UpdateProfileRequestModel request) =
      ProfileUpdated;

  const factory UserEvent.passwordChangeRequested(
    ChangePasswordRequestModel request,
  ) = PasswordChangeRequested;

  const factory UserEvent.allDevicesLogoutRequested() =
      AllDevicesLogoutRequested;

  const factory UserEvent.deviceLoggedOut(int deviceId) = DeviceLoggedOut;
  const factory UserEvent.deviceDeleted(int deviceId) = DeviceDeleted;

  const factory UserEvent.allDevicesDeleteRequested() =
      AllDevicesDeleteRequested;

  const factory UserEvent.clearDataRequested() = ClearDataRequested;

  const factory UserEvent.notificationPreferenceRequested() = NotificationPreferenceRequested;
  const factory UserEvent.notificationToggled(bool enabled) = NotificationToggled;

  const factory UserEvent.profilePhotoUploadRequested(
    Uint8List imageBytes,
    String filename,
  ) = ProfilePhotoUploadRequested;
}
