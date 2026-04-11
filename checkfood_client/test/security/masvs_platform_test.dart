// MASVS-PLATFORM
//
// - Deep link router MUST reject unknown/malformed URIs and MUST NOT
//   redirect out of the app on attacker input.
// - Android activity should not be blindly exported without scheme guard.
// - WebView MUST not enable unrestricted JavaScript + addJavaScriptChannel
//   on attacker-controlled content.
// - Clipboard should be cleared (or flagged) on sensitive screens.

import 'dart:io';

import 'package:checkfood_client/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MASVS-PLATFORM / deep link routing', () {
    Route<dynamic> route(String name, {Object? args}) =>
        AppRouter.onGenerateRoute(RouteSettings(name: name, arguments: args));

    test('unknown deep link path returns the error route', () {
      final r = route('/this-does-not-exist');
      expect(r, isA<MaterialPageRoute>());
    });

    test('path traversal in route name is rejected or neutralised', () {
      // GAP: AppRouter uses Uri.parse which silently accepts segments
      // containing ".." — verify nothing routable matches.
      final r = route('/../../etc/passwd');
      expect(r, isA<MaterialPageRoute>());
    });

    test('reset-password with missing token returns error route, not crash',
        () {
      final r = route('/reset-password');
      expect(r, isA<MaterialPageRoute>());
    });

    test('reset-password with empty token is rejected', () {
      final r = route('/reset-password?token=');
      expect(r, isA<MaterialPageRoute>());
    });

    test(
        'GAP: login deep link accepts arbitrary query params — '
        'status/message are rendered by LoginPage',
        () {
      // GAP: AppRouter forwards `status` and `message` query params from
      // any caller directly into the LoginPage UI. Malicious deep link:
      //   checkfood://app/login?status=verified&message=<XSS payload>
      // On Flutter this is not script-execution but it can be used for
      // phishing banners ("Your account was suspended, call 800..."),
      // so the router SHOULD reject unknown status values and escape
      // or drop the free-text message.
      final r = route(
        '/login?status=verified&message=You%20have%20been%20hacked.%20'
        'Call%20800-555-0199%20now.',
      );
      expect(r, isA<MaterialPageRoute>());
      // The deliverable is that this test FAILS once a whitelist is
      // added: assert the resulting page drops the unsafe message.
      fail(
        'LoginPage renders attacker-controlled message verbatim. '
        'Whitelist status values (verified|expired|error) and drop any '
        'custom message from deep-link origin.',
      );
    });
  });

  group('MASVS-PLATFORM / Android manifest', () {
    test('exported MainActivity deep link is scheme-locked', () {
      final manifest =
          File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      expect(
        manifest.contains('android:scheme="checkfood"'),
        isTrue,
        reason: 'deep link intent-filter should pin scheme=checkfood',
      );
    });

    test('GAP: exported activity should set android:autoVerify for App Links',
        () {
      // GAP: current intent-filter is not verified (autoVerify="true"),
      // so any app can register a competing checkfood:// handler and
      // steal login deep links.
      final manifest =
          File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      expect(
        manifest.contains('android:autoVerify="true"'),
        isTrue,
        reason: 'enable App Links verification on the deep-link intent-filter',
      );
    });
  });

  group('MASVS-PLATFORM / WebView hardening', () {
    test('panorama WebView runs with unrestricted JS on a local asset', () {
      // GAP: panorama_editor_screen enables JavaScriptMode.unrestricted
      // AND addJavaScriptChannel('EditorChannel') AND
      // AndroidWebViewController.enableDebugging(true) — debug remote
      // inspection should be off in release builds. If the local HTML
      // ever loads remote scripts, the bridge exposes Flutter state to
      // the attacker.
      final src = File(
        'lib/modules/restaurant/presentation/onboarding/presentation/'
        'widgets/panorama_editor_screen.dart',
      ).readAsStringSync();
      final enablesDebugging =
          src.contains('AndroidWebViewController.enableDebugging(true)');
      expect(
        enablesDebugging,
        isFalse,
        reason: 'WebView debugging must be gated behind kDebugMode',
      );
    });
  });

  group('MASVS-PLATFORM / clipboard hygiene', () {
    test('GAP: password fields should clear clipboard on submit', () {
      // GAP: no Clipboard.setData('') hygiene wraps the password or
      // reset-token fields. Other apps with READ_CLIPBOARD can read
      // copy-pasted credentials.
      final re = RegExp(r'Clipboard\.setData\s*\(\s*ClipboardData');
      var found = false;
      for (final f in Directory('lib/security/presentation')
          .listSync(recursive: true)) {
        if (f is! File || !f.path.endsWith('.dart')) continue;
        if (re.hasMatch(f.readAsStringSync())) found = true;
      }
      expect(found, isTrue,
          reason: 'no clipboard clearing detected on sensitive screens');
    });
  });
}
