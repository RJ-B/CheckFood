import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Sluzba pro spravu push notifikaci.
/// Wrapper nad FirebaseMessaging — zapouzdruje permission a token management.
class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Vyzada OS permission pro push notifikace.
  /// Vraci true pokud uzivatel povolil (authorized nebo provisional).
  Future<bool> requestPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      debugPrint('NotificationService.requestPermission error: $e');
      return false;
    }
  }

  /// Zjisti aktualni stav OS permission.
  Future<bool> isPermissionGranted() async {
    try {
      final settings = await _messaging.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      debugPrint('NotificationService.isPermissionGranted error: $e');
      return false;
    }
  }

  /// Ziska FCM token pro aktualni zarizeni.
  /// Vraci null pokud neni k dispozici (napr. bez Google Play Services).
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      debugPrint('NotificationService.getToken error: $e');
      return null;
    }
  }

  /// Stream pro naslouchani zmene FCM tokenu.
  /// Token se muze zmenit za behu — pri zmene je treba aktualizovat backend.
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}
