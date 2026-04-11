// MASVS-CODE
//
// - No hardcoded secrets in lib/ (API keys, JWT secrets, AWS keys, PEM).
// - No outdated / vulnerable dep pins in pubspec.lock (basic heuristic,
//   real scan is done by dart pub outdated / gitleaks in CI).
// - Release build must enable Flutter obfuscation + split-debug-info.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  final libRoot = Directory('lib');

  List<File> dartFiles() => libRoot
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !f.path.endsWith('.freezed.dart'))
      .toList();

  test('no hardcoded secrets in lib/', () {
    final patterns = <String, RegExp>{
      'AWS_ACCESS_KEY':
          RegExp(r'AKIA[0-9A-Z]{16}'),
      'PRIVATE_KEY_PEM':
          RegExp(r'-----BEGIN (RSA|EC|OPENSSH|PGP) PRIVATE KEY-----'),
      'GOOGLE_API_KEY':
          RegExp(r'AIza[0-9A-Za-z_\-]{35}'),
      'SLACK_TOKEN':
          RegExp(r'xox[baprs]-[0-9A-Za-z\-]{10,}'),
      'JWT_LITERAL':
          RegExp(r'eyJ[A-Za-z0-9_\-]{20,}\.[A-Za-z0-9_\-]{20,}\.'
              r'[A-Za-z0-9_\-]{20,}'),
      // Require high-entropy value (digits + mixed case or base64-ish),
      // NOT route slugs like '/auth/forgot-password'.
      'GENERIC_SECRET_ASSIGN': RegExp(
        r'''(secret|apiKey|api_key|clientSecret|privateKey)\s*[:=]\s*['"]'''
        r'''(?=[^'"]*[A-Z])(?=[^'"]*[0-9])[A-Za-z0-9+/=_\-]{24,}['"]''',
        caseSensitive: false,
      ),
    };

    final hits = <String>[];
    for (final f in dartFiles()) {
      final src = f.readAsStringSync();
      for (final entry in patterns.entries) {
        if (entry.value.hasMatch(src)) {
          hits.add('${f.path}: ${entry.key}');
        }
      }
    }
    expect(
      hits,
      isEmpty,
      reason: 'Possible hardcoded secrets: $hits',
    );
  });

  test('Android manifest does not embed Google Maps API key as plain meta-data',
      () {
    // GAP: android/app/src/main/AndroidManifest.xml embeds the key
    // inline. Move to local.properties / gradle placeholder so the key
    // is not checked into VCS.
    final manifest =
        File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    final re = RegExp(r'android:value="AIza[0-9A-Za-z_\-]{35}"');
    expect(
      re.hasMatch(manifest),
      isFalse,
      reason:
          'Plain-text Google Maps API key embedded in AndroidManifest.xml',
    );
  });

  test('.env files are NOT bundled as Flutter assets', () {
    // GAP: pubspec.yaml ships `.env`, `.env.local`, `.env.prod` as
    // assets. Every API key in them is readable from the installed
    // APK/IPA by unzipping it. Move secrets to a backend proxy or use
    // obfuscated runtime injection.
    final pubspec = loadYaml(File('pubspec.yaml').readAsStringSync()) as Map;
    final assets =
        (pubspec['flutter'] as Map)['assets'] as List? ?? const [];
    final offenders =
        assets.cast<String>().where((a) => a.startsWith('.env')).toList();
    expect(
      offenders,
      isEmpty,
      reason: '.env files bundled into APK: $offenders',
    );
  });

  test('pubspec.lock contains no pinned insecure old versions', () {
    // Shallow heuristic. Real audit: `dart pub outdated --mode=security`.
    final lock = File('pubspec.lock').readAsStringSync();
    // known-bad minimums for packages we pin
    final danger = <String, String>{
      'flutter_secure_storage:': '7.',
      'dio:': '4.',
    };
    final offenders = <String>[];
    for (final entry in danger.entries) {
      final idx = lock.indexOf(entry.key);
      if (idx == -1) continue;
      final window = lock.substring(idx, (idx + 400).clamp(0, lock.length));
      final v = RegExp(r'version:\s*"([^"]+)"').firstMatch(window)?.group(1);
      if (v != null && v.startsWith(entry.value)) {
        offenders.add('${entry.key} $v');
      }
    }
    expect(offenders, isEmpty, reason: 'outdated deps: $offenders');
  });

  test('release build script uses --obfuscate + --split-debug-info', () {
    // GAP: no build script found in the repo that passes obfuscation
    // flags. This test documents the expectation — add a Makefile/CI
    // step or a scripts/build_release.sh and point this test at it.
    final candidates = [
      File('scripts/build_release.sh'),
      File('Makefile'),
      File('.github/workflows/release.yml'),
    ].where((f) => f.existsSync());
    final hasObfuscation = candidates.any((f) {
      final src = f.readAsStringSync();
      return src.contains('--obfuscate') &&
          src.contains('--split-debug-info');
    });
    expect(
      hasObfuscation,
      isTrue,
      reason:
          'No release script enforces --obfuscate --split-debug-info. '
          'Dart symbols are trivially reversible without these flags.',
    );
  });
}
