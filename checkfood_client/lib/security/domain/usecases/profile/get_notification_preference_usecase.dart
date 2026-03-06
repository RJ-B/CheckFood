import '../../repositories/profile_repository.dart';

class GetNotificationPreferenceUseCase {
  final ProfileRepository _repository;

  GetNotificationPreferenceUseCase(this._repository);

  /// Nacte aktualni stav notifikaci z backendu.
  /// Vraci mapu s keys: notificationsEnabled (bool), hasFcmToken (bool).
  Future<Map<String, dynamic>> call({
    required String deviceIdentifier,
  }) {
    return _repository.getNotificationPreference(
      deviceIdentifier: deviceIdentifier,
    );
  }
}
