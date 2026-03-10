import 'dart:typed_data';

import '../entities/user_profile.dart';
import '../entities/device.dart';
import '../../data/models/profile/request/update_profile_request_model.dart';
import '../../data/models/profile/request/change_password_request_model.dart';

abstract class ProfileRepository {
  /// Načte personu uživatele.
  Future<UserProfile> getUserProfile();

  /// Aktualizuje údaje persony.
  Future<UserProfile> updateProfile(UpdateProfileRequestModel request);

  /// Provede změnu hesla.
  Future<void> changePassword(ChangePasswordRequestModel request);

  /// Načte seznam zařízení spojených s účtem.
  Future<List<Device>> getActiveDevices();

  /// Odhlásí konkrétní zařízení podle jeho technického ID.
  Future<void> logoutDevice(int deviceId);

  /// Odhlásí všechna zařízení kromě aktuálního.
  Future<void> logoutAllDevices();

  /// Aktualizuje preferenci push notifikaci.
  Future<Map<String, dynamic>> updateNotificationPreference({
    required String deviceIdentifier,
    required bool notificationsEnabled,
    String? fcmToken,
  });

  /// Nacte stav push notifikaci pro dane zarizeni.
  Future<Map<String, dynamic>> getNotificationPreference({
    required String deviceIdentifier,
  });

  /// Uploaduje profilovou fotku a vraci URL.
  Future<String> uploadProfilePhoto(Uint8List imageBytes, String filename);
}
