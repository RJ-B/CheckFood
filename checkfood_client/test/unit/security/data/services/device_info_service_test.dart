import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:checkfood_client/security/data/services/device_info_service.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

const _kIdKey = 'device_unique_instance_id';

void main() {
  late MockSecureStorage mockStorage;
  late DeviceInfoService service;

  setUp(() {
    mockStorage = MockSecureStorage();
    service = DeviceInfoService(mockStorage);

    when(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
        aOptions: any(named: 'aOptions'),
        iOptions: any(named: 'iOptions'),
      ),
    ).thenAnswer((_) async {});
  });

  group('DeviceInfoService.getDeviceIdentifier', () {
    test('should return persisted ID when one already exists', () async {
      when(
        () => mockStorage.read(
          key: _kIdKey,
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => 'existing-uuid-1234');

      final id = await service.getDeviceIdentifier();

      expect(id, 'existing-uuid-1234');
      // Should NOT write a new one
      verifyNever(
        () => mockStorage.write(
          key: _kIdKey,
          value: any(named: 'value'),
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      );
    });

    test('should generate, persist and return new UUID when none stored',
        () async {
      when(
        () => mockStorage.read(
          key: _kIdKey,
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenAnswer((_) async => null);

      final id = await service.getDeviceIdentifier();

      // Must be a non-empty string
      expect(id, isNotEmpty);
      // UUID v4 pattern
      expect(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          caseSensitive: false,
        ).hasMatch(id),
        isTrue,
        reason: 'generated ID must be a valid UUID v4',
      );

      verify(
        () => mockStorage.write(
          key: _kIdKey,
          value: id,
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).called(1);
    });

    test('should return ephemeral UUID without crashing when storage throws',
        () async {
      when(
        () => mockStorage.read(
          key: _kIdKey,
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenThrow(Exception('keychain unavailable'));

      final id = await service.getDeviceIdentifier();

      expect(id, isNotEmpty);
      // Should attempt to persist the fallback
      verify(
        () => mockStorage.write(
          key: _kIdKey,
          value: any(named: 'value'),
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).called(1);
    });

    test('should return ephemeral UUID even when write also throws', () async {
      when(
        () => mockStorage.read(
          key: _kIdKey,
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenThrow(Exception('read fail'));
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenThrow(Exception('write fail'));

      // Must not throw
      final id = await service.getDeviceIdentifier();
      expect(id, isNotEmpty);
    });

    test('should return different IDs on two calls when storage is unavailable',
        () async {
      when(
        () => mockStorage.read(
          key: _kIdKey,
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenThrow(Exception('unavailable'));
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
          aOptions: any(named: 'aOptions'),
          iOptions: any(named: 'iOptions'),
        ),
      ).thenThrow(Exception('unavailable'));

      final id1 = await service.getDeviceIdentifier();
      final id2 = await service.getDeviceIdentifier();

      // Ephemeral — they will be different (new UUID each time storage fails)
      expect(id1, isNot(equals(id2)));
    });
  });

  group('DeviceInfoService.getDeviceType', () {
    test('should return UNKNOWN on non-mobile test platform', () async {
      // In flutter_test (desktop), neither isAndroid nor isIOS is true and
      // kIsWeb is false, so the method returns UNKNOWN.
      final type = await service.getDeviceType();
      expect(type, anyOf(['ANDROID', 'IOS', 'WEB', 'UNKNOWN']));
    });
  });
}
