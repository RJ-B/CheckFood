import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/**
 * Služba pro získávání informací o zařízení a správu unikátní identity instance aplikace.
 * Zajišťuje, že zařízení bude pro backend rozpoznatelné i po restartu aplikace.
 */
class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final FlutterSecureStorage _storage;

  static const String _storageKeyDeviceId = 'device_unique_instance_id';

  DeviceInfoService(this._storage);

  /// ✅ OPRAVA: Metoda pro získání unikátního ID (řeší první chybu v LoginForm)
  Future<String> getDeviceIdentifier() async {
    try {
      String? storedId = await _storage.read(key: _storageKeyDeviceId);

      if (storedId != null && storedId.isNotEmpty) {
        return storedId;
      }

      final newId = const Uuid().v4();
      await _storage.write(key: _storageKeyDeviceId, value: newId);
      return newId;
    } catch (e) {
      debugPrint('Chyba při přístupu k SecureStorage: $e');
      return const Uuid().v4(); // Fallback
    }
  }

  /// ✅ OPRAVA: Metoda pro získání názvu zařízení (řeší druhou chybu v LoginForm)
  Future<String> getDeviceName() async {
    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        return webInfo.userAgent ?? 'Web Browser';
      } else if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return '${androidInfo.brand} ${androidInfo.model}';
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.name;
      }
    } catch (e) {
      debugPrint('Chyba při získávání názvu zařízení: $e');
    }
    return 'Unknown Device';
  }

  /// ✅ OPRAVA: Metoda pro získání typu zařízení (řeší třetí chybu v LoginForm)
  Future<String> getDeviceType() async {
    if (kIsWeb) return 'WEB';
    if (Platform.isAndroid) return 'ANDROID';
    if (Platform.isIOS) return 'IOS';
    return 'UNKNOWN';
  }

  /// Ponecháno pro zpětnou kompatibilitu, pokud metodu využíváte jinde
  Future<Map<String, String>> getDeviceData() async {
    return {
      'deviceIdentifier': await getDeviceIdentifier(),
      'deviceName': await getDeviceName(),
      'deviceType': await getDeviceType(),
    };
  }
}
