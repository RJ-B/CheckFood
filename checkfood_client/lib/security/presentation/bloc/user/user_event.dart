import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/profile/request/change_password_request_model.dart';
import '../../../data/models/profile/request/update_profile_request_model.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  /// Požadavek na načtení profilu.
  const factory UserEvent.profileRequested() = ProfileRequested;

  /// Aktualizace profilu pomocí Request Modelu.
  const factory UserEvent.profileUpdated(UpdateProfileRequestModel request) =
      ProfileUpdated;

  /// Změna hesla pomocí Request Modelu.
  const factory UserEvent.passwordChangeRequested(
    ChangePasswordRequestModel request,
  ) = PasswordChangeRequested;

  /// Odhlášení ze všech zařízení.
  const factory UserEvent.allDevicesLogoutRequested() =
      AllDevicesLogoutRequested;

  /// Odhlášení konkrétního zařízení (ID je String).
  const factory UserEvent.deviceLoggedOut(String deviceId) = DeviceLoggedOut;
}
