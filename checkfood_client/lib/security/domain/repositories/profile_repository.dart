import 'dart:typed_data';

import '../entities/user_profile.dart';
import '../entities/device.dart';
import '../../data/models/profile/request/update_profile_request_model.dart';
import '../../data/models/profile/request/change_password_request_model.dart';

/// Abstraktní kontrakt pro správu profilu uživatele a jeho zařízení.
abstract class ProfileRepository {
  /// Načte personu uživatele.
  Future<UserProfile> getUserProfile();

  /// Aktualizuje údaje persony.
  Future<UserProfile> updateProfile(UpdateProfileRequestModel request);

  /// Provede změnu hesla.
  Future<void> changePassword(ChangePasswordRequestModel request);

  /// Načte seznam zařízení spojených s účtem.
  Future<List<Device>> getActiveDevices();

  /// Odhlásí (deaktivuje) konkrétní zařízení podle jeho technického ID.
  Future<void> logoutDevice(int deviceId);

  /// Smaže konkrétní zařízení z DB.
  Future<void> deleteDevice(int deviceId);

  /// Odhlásí všechna zařízení kromě aktuálního.
  Future<void> logoutAllDevices();

  /// Smaže všechna zařízení kromě aktuálního z DB.
  Future<void> deleteAllDevices();

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

  /// Smaže soubor z úložiště podle relativní cesty (tiché selhání — nový upload proběhne i bez mazání).
  Future<void> deleteStorageFile(String path);

  /// Trvale smaže účet přihlášeného uživatele a všechna jeho data (GDPR).
  Future<void> deleteAccount();
}
