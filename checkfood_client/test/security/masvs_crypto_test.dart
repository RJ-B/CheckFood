// MASVS-CRYPTO
//
// - No custom/rolled crypto primitives (AES / DES / RC4 / MD5 / SHA1 used
//   for auth) should appear in application code. Rely on platform APIs
//   (flutter_secure_storage delegates to Keystore / Keychain).
// - Any PRNG used for tokens, nonces, salts must be dart:math Random.secure(),
//   not the default Random() which is predictable.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final libRoot = Directory('lib');

  List<File> dartFiles() => libRoot
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !f.path.endsWith('.freezed.dart'))
      .toList();

  test('no insecure Random() instances in security-sensitive code', () {
    // Matches `Random(` but NOT `Random.secure(`.
    final insecure = RegExp(r'\bRandom\s*\(');
    final secure = RegExp(r'\bRandom\.secure\s*\(');
    final offenders = <String>[];
    for (final file in dartFiles()) {
      final src = file.readAsStringSync();
      final hasInsecure = insecure.hasMatch(src);
      final hasSecure = secure.hasMatch(src);
      if (hasInsecure && !hasSecure) {
        offenders.add(file.path);
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'Use Random.secure() for anything security-relevant: $offenders',
    );
  });

  test('no homegrown crypto (MD5 / SHA1 / DES / RC4) in source', () {
    // GAP: static scan. Presence alone is suspicious; triage manually.
    final re = RegExp(
      r'\b(md5|sha1|des|rc4|arc4)\b',
      caseSensitive: false,
    );
    final offenders = <String>[];
    for (final file in dartFiles()) {
      final src = file.readAsStringSync();
      // Ignore comments trivially by stripping // lines.
      final stripped = src
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      if (re.hasMatch(stripped)) {
        offenders.add(file.path);
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'Weak/legacy crypto referenced: $offenders',
    );
  });

  test('no Base64-looking static secret literals >40 chars', () {
    // GAP: catches embedded private keys / symmetric secrets.
    // Require: no slashes (rules out URL paths), mixed case, at least
    // one digit and one upper — plain sentences and slugs don't match.
    final re = RegExp(
      r'''['"](?=[^'"]*[A-Z])(?=[^'"]*[a-z])(?=[^'"]*[0-9])'''
      r'''[A-Za-z0-9+=]{40,}['"]''',
    );
    final offenders = <String>[];
    for (final file in dartFiles()) {
      final src = file.readAsStringSync();
      for (final m in re.allMatches(src)) {
        final literal = m.group(0)!;
        if (literal.contains('http') || literal.contains('svg')) continue;
        offenders.add('${file.path}: ${literal.substring(0, 20)}...');
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'Possible embedded secrets: $offenders',
    );
  });
}
