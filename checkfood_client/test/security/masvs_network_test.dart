// MASVS-NETWORK
//
// - Release builds must pin HTTPS only via network_security_config.xml.
// - Android manifest must NOT enable usesCleartextTraffic for release.
// - iOS Info.plist must NOT weaken NSAppTransportSecurity.
// - Dio should use certificate pinning (or explicitly document the risk).
// - No endpoint in lib/ may use http:// except localhost dev helpers.
//
// Note: prior to Apr 2026 the project shipped `.env`, `.env.local`, `.env.prod`
// as Flutter assets; those files are gone (see B1 migration in
// lib/core/config/build_config.dart). Tests that used to read them now scan
// scripts/build_release.sh for the default prod API_BASE_URL instead.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MASVS-NETWORK / HTTPS everywhere', () {
    test('scripts/build_release.sh default API_BASE_URL uses https://', () {
      final script = File('scripts/build_release.sh');
      expect(script.existsSync(), isTrue, reason: 'scripts/build_release.sh missing');
      final src = script.readAsStringSync();
      // Matches `${API_BASE_URL:-<default>}` — capture group is the default
      // between `:-` and the closing `}`.
      final match = RegExp(r'\$\{API_BASE_URL:-([^}]+)\}')
          .firstMatch(src)
          ?.group(1);
      expect(match, isNotNull, reason: 'default API_BASE_URL missing in build_release.sh');
      expect(
        match!.startsWith('https://'),
        isTrue,
        reason: 'prod default must be https, was $match',
      );
    });

    test('scripts/build_release.sh default Apple redirect URL uses https://', () {
      final src = File('scripts/build_release.sh').readAsStringSync();
      final match = RegExp(r'\$\{APPLE_REDIRECT_URL:-([^}]+)\}')
          .firstMatch(src)
          ?.group(1);
      if (match != null) {
        expect(match.startsWith('https://'), isTrue, reason: match);
      }
    });

    test('no plaintext http://<non-local> URL literals in lib/', () {
      // GAP: catches accidental cleartext calls to non-local hosts.
      final offenders = <String>[];
      final re = RegExp(r'''http://([^'"\s/]+)''');
      for (final f in Directory('lib').listSync(recursive: true)) {
        if (f is! File || !f.path.endsWith('.dart')) continue;
        if (f.path.endsWith('.g.dart') || f.path.endsWith('.freezed.dart')) {
          continue;
        }
        final src = f.readAsStringSync();
        for (final m in re.allMatches(src)) {
          final host = m.group(1)!;
          final isLocal = host.startsWith('localhost') ||
              host.startsWith('127.0.0.1') ||
              host.startsWith('10.0.2.2') ||
              host.startsWith('192.168.') ||
              host.startsWith('schemas.') ||
              host.startsWith('www.w3.org') ||
              host.startsWith('apple.com') ||
              host.startsWith('java.sun.com');
          if (!isLocal) offenders.add('${f.path}: http://$host');
        }
      }
      expect(offenders, isEmpty, reason: 'cleartext URLs: $offenders');
    });
  });

  group('MASVS-NETWORK / platform config', () {
    test('Android release manifest must not enable cleartext traffic', () {
      // GAP: main manifest currently sets usesCleartextTraffic="true"
      // globally. Move it to debug-only variant, or set to "false".
      final manifest =
          File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      expect(
        manifest.contains('android:usesCleartextTraffic="true"'),
        isFalse,
        reason:
            'main manifest has usesCleartextTraffic=true; move to src/debug '
            'or use a network_security_config.xml',
      );
    });

    test('Android manifest should reference network_security_config', () {
      // GAP: there is no res/xml/network_security_config.xml.
      final xmlDir = Directory('android/app/src/main/res/xml');
      expect(
        xmlDir.existsSync() &&
            xmlDir
                .listSync()
                .whereType<File>()
                .any((f) => f.path.endsWith('network_security_config.xml')),
        isTrue,
        reason: 'network_security_config.xml missing — '
            'cleartext traffic not constrained on Android',
      );
    });

    test('iOS Info.plist must not set NSAllowsArbitraryLoads', () {
      final plist = File('ios/Runner/Info.plist').readAsStringSync();
      expect(
        plist.contains('NSAllowsArbitraryLoads'),
        isFalse,
        reason: 'Info.plist weakens ATS',
      );
    });

    test('certificate pinning is wired into Dio', () {
      // Phase 5 (Apr 2026): CertificatePinner installs a
      // badCertificateCallback that compares the leaf cert SHA-256
      // against the CERT_PIN_SHA256 build-time list. Debug builds
      // skip the check. Fingerprints for prod are supplied via
      // scripts/build_release.sh --dart-define=CERT_PIN_SHA256=...
      var foundPinning = false;
      for (final f in Directory('lib').listSync(recursive: true)) {
        if (f is! File || !f.path.endsWith('.dart')) continue;
        final src = f.readAsStringSync();
        if (src.contains('SecurityContext') ||
            src.contains('setTrustedCertificates') ||
            src.contains('badCertificateCallback') ||
            src.contains('certificate_pinning') ||
            src.contains('CertificatePinner')) {
          foundPinning = true;
        }
      }
      expect(
        foundPinning,
        isTrue,
        reason:
            'No certificate pinning detected in Dio configuration. '
            'Expected CertificatePinner.installOn(dio) in the DI setup.',
      );
    });
  });
}
