import 'package:flutter/foundation.dart';

/// Sluzba pro spravu push notifikaci.
/// Wrapper nad FirebaseMessaging — zapouzdruje permission a token management.
///
/// Firebase je pristupovan lazy — pokud neni inicializovan (T-0004),
/// metody gracefully vraci false/null misto vyhozeni vyjimky.
class NotificationService {
  /// Vyzada OS permission pro push notifikace.
  /// Vraci true pokud uzivatel povolil (authorized nebo provisional).
  Future<bool> requestPermission() async {
    try {
      // TODO(T-0004): Aktivovat az bude Firebase inicializovan
      // final messaging = FirebaseMessaging.instance;
      // final settings = await messaging.requestPermission(
      //   alert: true,
      //   badge: true,
      //   sound: true,
      //   provisional: false,
      // );
      // return settings.authorizationStatus == AuthorizationStatus.authorized ||
      //     settings.authorizationStatus == AuthorizationStatus.provisional;
      debugPrint('NotificationService.requestPermission: Firebase not initialized (T-0004)');
      return false;
    } catch (e) {
      debugPrint('NotificationService.requestPermission error: $e');
      return false;
    }
  }

  /// Zjisti aktualni stav OS permission.
  Future<bool> isPermissionGranted() async {
    try {
      // TODO(T-0004): Aktivovat az bude Firebase inicializovan
      // final messaging = FirebaseMessaging.instance;
      // final settings = await messaging.getNotificationSettings();
      // return settings.authorizationStatus == AuthorizationStatus.authorized ||
      //     settings.authorizationStatus == AuthorizationStatus.provisional;
      return false;
    } catch (e) {
      debugPrint('NotificationService.isPermissionGranted error: $e');
      return false;
    }
  }

  /// Ziska FCM token pro aktualni zarizeni.
  /// Vraci null pokud neni k dispozici (napr. bez Firebase/Google Play Services).
  Future<String?> getToken() async {
    try {
      // TODO(T-0004): Aktivovat az bude Firebase inicializovan
      // final messaging = FirebaseMessaging.instance;
      // return await messaging.getToken();
      return null;
    } catch (e) {
      debugPrint('NotificationService.getToken error: $e');
      return null;
    }
  }

  /// Stream pro naslouchani zmene FCM tokenu.
  /// Vraci prazdny stream pokud Firebase neni inicializovan.
  Stream<String> get onTokenRefresh {
    // TODO(T-0004): Aktivovat az bude Firebase inicializovan
    // return FirebaseMessaging.instance.onTokenRefresh;
    return const Stream.empty();
  }
}
