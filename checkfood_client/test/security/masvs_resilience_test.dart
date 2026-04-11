// MASVS-RESILIENCE
//
// - App should detect rooted / jailbroken devices and degrade gracefully
//   (refuse to store tokens, warn the user, disable sensitive features).
// - App should refuse to run under a debugger in production (anti-debug).
// - Secure storage should not be used at keyboard rest level — check
//   that we prefer first_unlock or first_unlock_this_device_only on iOS.
//
// This audit currently has no resilience layer, so every test is a GAP.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('GAP: root/jailbreak detection package is NOT declared', () {
    // GAP: no flutter_jailbreak_detection / freerasp / safe_device
    // present in pubspec.yaml. On rooted devices the Keystore can be
    // read by any other rooted process; the app should at least warn.
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as Map;
    final deps = (pubspec['dependencies'] as Map).keys.cast<String>().toSet();
    final known = {
      'flutter_jailbreak_detection',
      'safe_device',
      'freerasp',
      'trustfall',
    };
    expect(
      deps.intersection(known),
      isNotEmpty,
      reason:
          'No root/jailbreak detection dependency declared. Add one of '
          '$known and gate sensitive features on the result.',
    );
  });

  test('GAP: no anti-debugging hook found in lib/', () {
    // GAP: there is no call to kReleaseMode checks that early-exit
    // when Platform.environment contains JDWP/Frida markers. This is
    // defence-in-depth, not a silver bullet.
    final offenders = <String>[];
    var found = false;
    for (final f in Directory('lib').listSync(recursive: true)) {
      if (f is! File || !f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      if (src.contains('isDebuggerAttached') ||
          src.contains('FRIDA') ||
          src.contains('ptrace') ||
          src.contains('jailbreak') ||
          src.contains('Jailbreak')) {
        found = true;
      }
    }
    expect(
      found,
      isTrue,
      reason:
          'No anti-debug / anti-tamper code found in lib/: $offenders',
    );
  });

  test('iOS Keychain accessibility should be at most first_unlock_this_device',
      () {
    // GAP: TokenStorage uses KeychainAccessibility.first_unlock which
    // is syncable to iCloud. For auth tokens prefer
    // first_unlock_this_device_only so they never leave the device.
    final src = File('lib/security/data/local/token_storage.dart')
        .readAsStringSync();
    expect(
      src.contains('first_unlock_this_device_only'),
      isTrue,
      reason:
          'Use KeychainAccessibility.first_unlock_this_device_only to '
          'keep tokens local to the device.',
    );
  });

  test('GAP: no screenshot / task-switcher blurring on sensitive screens', () {
    // GAP: no FLAG_SECURE nor secureContent wrapper around login /
    // reset-password / device-management screens. Task-switcher
    // thumbnails and screenshots can leak OTP codes and tokens.
    var found = false;
    for (final f in Directory('lib').listSync(recursive: true)) {
      if (f is! File || !f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      if (src.contains('FLAG_SECURE') ||
          src.contains('secureApplicationSwitcher') ||
          src.contains('ScreenProtector') ||
          src.contains('no_screenshot')) {
        found = true;
      }
    }
    expect(
      found,
      isTrue,
      reason: 'No screen-capture protection detected.',
    );
  });
}
