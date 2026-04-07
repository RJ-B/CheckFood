import '../../repositories/profile_repository.dart';

/// UseCase pro načtení aktuálního nastavení push notifikací z backendu.
class GetNotificationPreferenceUseCase {
  final ProfileRepository _repository;

  GetNotificationPreferenceUseCase(this._repository);

  /// Načte preference notifikací pro zařízení identifikované [deviceIdentifier].
  ///
  /// Vrací mapu s klíči `notificationsEnabled` (bool) a `hasFcmToken` (bool).
  Future<Map<String, dynamic>> call({
    required String deviceIdentifier,
  }) {
    return _repository.getNotificationPreference(
      deviceIdentifier: deviceIdentifier,
    );
  }
}
