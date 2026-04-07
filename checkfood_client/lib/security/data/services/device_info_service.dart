import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Služba pro získávání informací o zařízení a správu unikátní identity instance aplikace.
///
/// Zajišťuje, že zařízení bude pro backend rozpoznatelné i po restartu aplikace.
/// Identifikátor je persistován v [FlutterSecureStorage] stejnými options jako [TokenStorage].
class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final FlutterSecureStorage _storage;

  static const String _storageKeyDeviceId = 'device_unique_instance_id';

  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );
  static const IOSOptions _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );

  DeviceInfoService(this._storage);

  /// Vrátí unikátní identifikátor instance aplikace.
  ///
  /// Při prvním volání vygeneruje UUID v4, uloží ho do SecureStorage a vrátí.
  /// Při dalším volání načte uloženou hodnotu. Při chybě úložiště vrátí
  /// ephemeral UUID bez záruky persistence.
  Future<String> getDeviceIdentifier() async {
    try {
      String? storedId = await _storage.read(
        key: _storageKeyDeviceId,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );

      if (storedId != null && storedId.isNotEmpty) {
        return storedId;
      }

      final newId = const Uuid().v4();
      await _storage.write(
        key: _storageKeyDeviceId,
        value: newId,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
      return newId;
    } catch (_) {
      final fallbackId = const Uuid().v4();
      try {
        await _storage.write(
          key: _storageKeyDeviceId,
          value: fallbackId,
          aOptions: _androidOptions,
          iOptions: _iosOptions,
        );
      } catch (_) {}
      return fallbackId;
    }
  }

  /// Vrátí zobrazitelný název zařízení (např. "Samsung Galaxy S24").
  ///
  /// Na Androidu kombinuje brand a model, přičemž eliminuje duplicity.
  Future<String> getDeviceName() async {
    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        return webInfo.userAgent ?? 'Web Browser';
      } else if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        final brand = androidInfo.brand;
        final model = androidInfo.model;
        if (model.toLowerCase().startsWith(brand.toLowerCase())) {
          return model;
        }
        return '$brand $model';
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.name;
      }
    } catch (_) {}
    return 'Unknown Device';
  }

  /// Vrátí typ zařízení jako řetězec (`ANDROID`, `IOS`, `WEB`, `UNKNOWN`).
  Future<String> getDeviceType() async {
    if (kIsWeb) return 'WEB';
    if (Platform.isAndroid) return 'ANDROID';
    if (Platform.isIOS) return 'IOS';
    return 'UNKNOWN';
  }

  /// Vrátí mapu se všemi device-info hodnotami pro registrační požadavek.
  Future<Map<String, String>> getDeviceData() async {
    return {
      'deviceIdentifier': await getDeviceIdentifier(),
      'deviceName': await getDeviceName(),
      'deviceType': await getDeviceType(),
    };
  }
}
