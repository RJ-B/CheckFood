import '../../repositories/profile_repository.dart';

class UpdateNotificationPreferenceUseCase {
  final ProfileRepository _repository;

  UpdateNotificationPreferenceUseCase(this._repository);

  /// Aktualizuje preferenci notifikaci na backendu.
  /// Vraci mapu s keys: notificationsEnabled (bool), hasFcmToken (bool).
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
