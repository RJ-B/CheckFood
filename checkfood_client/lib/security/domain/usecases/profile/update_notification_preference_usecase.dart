import '../../repositories/profile_repository.dart';

/// UseCase pro aktualizaci nastavení push notifikací na backendu.
class UpdateNotificationPreferenceUseCase {
  final ProfileRepository _repository;

  UpdateNotificationPreferenceUseCase(this._repository);

  /// Aktualizuje preferenci notifikací pro zařízení identifikované [deviceIdentifier].
  ///
  /// Vrací mapu s klíči `notificationsEnabled` (bool) a `hasFcmToken` (bool).
  Future<Map<String, dynamic>> call({
    required String deviceIdentifier,
    required bool notificationsEnabled,
    String? fcmToken,
  }) {
    return _repository.updateNotificationPreference(
      deviceIdentifier: deviceIdentifier,
      notificationsEnabled: notificationsEnabled,
      fcmToken: fcmToken,
    );
  }
}
