import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/security/data/services/notification_service.dart';

/// Tests for the NotificationService stub implementation.
/// Firebase is not yet initialised (T-0004), so all methods return
/// their safe defaults. Tests confirm the safe-default contract and
/// that nothing throws.
void main() {
  late NotificationService service;

  setUp(() {
    service = NotificationService();
  });

  group('NotificationService (Firebase stub — T-0004)', () {
    test('requestPermission should return false without throwing', () async {
      final result = await service.requestPermission();
      expect(result, isFalse);
    });

    test('isPermissionGranted should return false without throwing', () async {
      final result = await service.isPermissionGranted();
      expect(result, isFalse);
    });

    test('getToken should return null without throwing', () async {
      final result = await service.getToken();
      expect(result, isNull);
    });

    test('onTokenRefresh emits no events and does not error', () async {
      final events = <String>[];
      service.onTokenRefresh.listen(events.add);
      // Pump the event loop briefly
      await Future.delayed(Duration.zero);
      expect(events, isEmpty);
    });

    // EXPECTED-FAIL: notification_service — production code does not yet implement
    // real FCM token registration (T-0004). Once Firebase is wired in,
    // getToken() should return a non-null string and requestPermission()
    // should return the actual OS grant status.
    test(
      'getToken should return a non-null FCM token once Firebase is active',
      () async {
        final token = await service.getToken();
        // Will fail until T-0004 is implemented
        expect(
          token,
          isNotNull,
          reason:
              'FCM token must be non-null after Firebase initialisation (T-0004)',
        );
      },
      skip: 'Firebase removed; re-enable when push notifications return',
    );
  });
}
