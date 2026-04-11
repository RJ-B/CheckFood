// MASVS-STORAGE
//
// - Auth tokens must live ONLY in flutter_secure_storage, never in
//   shared_preferences, never in plain files on disk.
// - Sensitive material (passwords, tokens, OTPs, refresh tokens, server
//   stack traces) must not be written to logs (print / debugPrint).
// - Error UI must not echo raw backend errors (which may contain PII or
//   SQL fragments).
//
// Strategy:
//   - Scan lib/ statically for violations. Static scans are deterministic,
//     run offline, and survive refactors.
//   - Use mocktail fakes to prove the SecureStorageService / TokenStorage
//     wrapper round-trips correctly through FlutterSecureStorage.

import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:checkfood_client/security/data/local/token_storage.dart';

class _FakeSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  setUpAll(() {
    registerFallbackValue(const AndroidOptions());
    registerFallbackValue(const IOSOptions());
  });

  group('MASVS-STORAGE / tokens round-trip flutter_secure_storage', () {
    late _FakeSecureStorage storage;
    late TokenStorage sut;

    setUp(() {
      storage = _FakeSecureStorage();
      sut = TokenStorage(storage);

      when(() => storage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).thenAnswer((_) async {});
      when(() => storage.read(
            key: any(named: 'key'),
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).thenAnswer((_) async => null);
      when(() => storage.delete(
            key: any(named: 'key'),
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).thenAnswer((_) async {});
    });

    test('saveTokens writes both access and refresh via FlutterSecureStorage',
        () async {
      await sut.saveTokens(accessToken: 'A', refreshToken: 'R');
      verify(() => storage.write(
            key: 'access_token',
            value: 'A',
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).called(1);
      verify(() => storage.write(
            key: 'refresh_token',
            value: 'R',
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).called(1);
    });

    test('clearAuthData deletes access, refresh and device id', () async {
      await sut.clearAuthData();
      verify(() => storage.delete(
            key: 'access_token',
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).called(1);
      verify(() => storage.delete(
            key: 'refresh_token',
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).called(1);
      verify(() => storage.delete(
            key: 'device_identifier',
            aOptions: any(named: 'aOptions'),
            iOptions: any(named: 'iOptions'),
          )).called(1);
    });
  });

  group('MASVS-STORAGE / static scans of lib/', () {
    final libRoot = Directory('lib');

    List<File> dartFiles() => libRoot
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .where((f) => !f.path.endsWith('.g.dart'))
        .where((f) => !f.path.endsWith('.freezed.dart'))
        .toList();

    test('no source file imports shared_preferences for tokens', () {
      final offenders = <String>[];
      for (final file in dartFiles()) {
        final src = file.readAsStringSync();
        if (!src.contains('shared_preferences')) continue;
        // Any file that imports shared_preferences AND references
        // tokens / passwords is a violation.
        final lowered = src.toLowerCase();
        if (lowered.contains('access_token') ||
            lowered.contains('refresh_token') ||
            lowered.contains('password') ||
            lowered.contains('jwt')) {
          offenders.add(file.path);
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Tokens/passwords MUST NOT touch shared_preferences. '
            'Offending files: $offenders',
      );
    });

    test('no print/debugPrint dumps tokens or passwords', () {
      // GAP: static guard — fails if any logger emits a raw token.
      final re = RegExp(
        r'''(print|debugPrint|logger\.\w+|log)\s*\(\s*[^;]*?(accessToken|refreshToken|password|jwt|bearer)''',
        caseSensitive: false,
      );
      final offenders = <String>[];
      for (final file in dartFiles()) {
        final src = file.readAsStringSync();
        if (re.hasMatch(src)) {
          offenders.add(file.path);
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Sensitive material must never reach logs: $offenders',
      );
    });

    test('error UI must not render raw DioException.toString()', () {
      // GAP: raw backend errors often contain stack traces, SQL hints
      // and email addresses. UI must render user-friendly copy instead.
      final re = RegExp(r'Text\s*\(\s*[^)]*?(DioException|e\.toString\(\))');
      final offenders = <String>[];
      for (final file in dartFiles()) {
        if (!file.path.contains('/presentation/')) continue;
        final src = file.readAsStringSync();
        if (re.hasMatch(src)) {
          offenders.add(file.path);
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Presentation layer leaks raw errors: $offenders',
      );
    });
  });
}
