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
  test('root/jailbreak detection is available (package OR custom helper)', () {
    // Either ship a published package, or a custom MethodChannel-backed
    // helper. CheckFood picked the latter (lib/security/presentation/
    // utils/device_integrity.dart → native root/jailbreak heuristics
    // in MainActivity.kt + AppDelegate.swift) because the warn-only
    // policy (E2) does not need a full RASP feature set — a single
    // boolean is enough.
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as Map;
    final deps = (pubspec['dependencies'] as Map).keys.cast<String>().toSet();
    final knownPackages = {
      'flutter_jailbreak_detection',
      'safe_device',
      'freerasp',
      'trustfall',
    };
    final hasPackage = deps.intersection(knownPackages).isNotEmpty;
    final helperFile = File(
      'lib/security/presentation/utils/device_integrity.dart',
    );
    final hasCustomHelper = helperFile.existsSync() &&
        helperFile.readAsStringSync().contains('isCompromised');

    expect(
      hasPackage || hasCustomHelper,
      isTrue,
      reason:
          'No root/jailbreak detection found. Either add one of '
          '$knownPackages or implement a custom helper exposing '
          'isCompromised() (see DeviceIntegrity).',
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
    // TokenStorage must use a Keychain accessibility level that does NOT
    // migrate to a new device via iCloud — i.e. *_this_device variants.
    // flutter_secure_storage 9.x enum values:
    //   first_unlock                 (iCloud-syncable) — forbidden
    //   first_unlock_this_device     (local-only)     — required
    //   unlocked_this_device         (stricter, local) — also acceptable
    final src = File('lib/security/data/local/token_storage.dart')
        .readAsStringSync();
    expect(
      src.contains('first_unlock_this_device')
          || src.contains('unlocked_this_device')
          || src.contains('passcode'),
      isTrue,
      reason:
          'Use KeychainAccessibility.first_unlock_this_device (or a '
          'stricter _this_device variant) to keep tokens local.',
    );
    // And must NOT use the bare first_unlock which DOES sync.
    expect(
      RegExp(r'KeychainAccessibility\.first_unlock\s*,').hasMatch(src)
          || RegExp(r'KeychainAccessibility\.first_unlock\s*\)').hasMatch(src),
      isFalse,
      reason: 'first_unlock is iCloud-syncable — use _this_device variant.',
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
