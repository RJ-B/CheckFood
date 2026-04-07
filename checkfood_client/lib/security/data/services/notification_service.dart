/// Služba pro správu push notifikací.
///
/// Wrapper nad FirebaseMessaging — zapouzdřuje permission a token management.
/// Firebase je přistupován lazy — pokud není inicializován (TODO T-0004),
/// metody vrací `false`/`null` místo vyhození výjimky.
class NotificationService {
  /// Vyžádá OS permission pro push notifikace.
  ///
  /// Vrací `true`, pokud uživatel povolil (authorized nebo provisional).
  Future<bool> requestPermission() async {
    try {
      // TODO(T-0004): Aktivovat až bude Firebase inicializován
      // final messaging = FirebaseMessaging.instance;
      // final settings = await messaging.requestPermission(
      //   alert: true,
      //   badge: true,
      //   sound: true,
      //   provisional: false,
      // );
      // return settings.authorizationStatus == AuthorizationStatus.authorized ||
      //     settings.authorizationStatus == AuthorizationStatus.provisional;
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Zjistí aktuální stav OS permission pro notifikace.
  Future<bool> isPermissionGranted() async {
    try {
      // TODO(T-0004): Aktivovat až bude Firebase inicializován
      // final messaging = FirebaseMessaging.instance;
      // final settings = await messaging.getNotificationSettings();
      // return settings.authorizationStatus == AuthorizationStatus.authorized ||
      //     settings.authorizationStatus == AuthorizationStatus.provisional;
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Získá FCM token pro aktuální zařízení.
  ///
  /// Vrací `null`, pokud není k dispozici (např. bez Firebase/Google Play Services).
  Future<String?> getToken() async {
    try {
      // TODO(T-0004): Aktivovat až bude Firebase inicializován
      // final messaging = FirebaseMessaging.instance;
      // return await messaging.getToken();
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Stream pro naslouchání změně FCM tokenu.
  ///
  /// Vrací prázdný stream, pokud Firebase není inicializován.
  Stream<String> get onTokenRefresh {
    // TODO(T-0004): Aktivovat až bude Firebase inicializován
    // return FirebaseMessaging.instance.onTokenRefresh;
    return const Stream.empty();
  }
}
