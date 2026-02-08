import '../entities/user_profile.dart';
import '../entities/device.dart';
import '../../data/models/profile/request/update_profile_request_model.dart';
import '../../data/models/profile/request/change_password_request_model.dart';

abstract class ProfileRepository {
  /// Načte profil uživatele.
  Future<UserProfile> getUserProfile();

  /// Aktualizuje profil pomocí Request modelu.
  Future<UserProfile> updateProfile(UpdateProfileRequestModel request);

  /// Změní heslo pomocí Request modelu.
  Future<void> changePassword(ChangePasswordRequestModel request);

  /// Načte seznam aktivních zařízení.
  Future<List<Device>> getActiveDevices();

  /// Odhlásí konkrétní zařízení.
  Future<void> logoutDevice(String deviceId);

  /// Odhlásí všechna ostatní zařízení.
  Future<void> logoutAllDevices();
}
