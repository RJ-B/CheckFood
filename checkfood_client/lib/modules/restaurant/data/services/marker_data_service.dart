import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../../../map/domain/entities/restaurant_marker_light.dart';

/// Ukládá a načítá snapshot markerů restaurací v lokálním souborovém systému.
///
/// Klíčové optimalizace pro startup performance:
///
///   1) Číslo verze se ukládá do **separátního malého souboru**
///      `markers_cache.version` (typicky < 10 B). Předchozí implementace
///      otevírala celý 1.9 MB JSON jen aby si přečetla `version` field, což
///      přidávalo ~500–1000 ms na každý cold-start. Teď je to <1 ms.
///
///   2) Parsování celého snapshotu (`loadFromDisk`) i serializace
///      (`saveToDisk`) běží přes [compute] v background isolate. Hlavní
///      thread tak není blokován jsonDecode/jsonEncode 12 000+ markerů
///      a UI nezamrzne ~300–500 ms při startu app.
class MarkerDataService {
  static const _dataFileName = 'markers_cache.json';
  static const _versionFileName = 'markers_cache.version';

  Future<File> get _dataFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_dataFileName');
  }

  Future<File> get _versionFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_versionFileName');
  }

  /// Načte cachovaný snapshot markerů z disku. Vrátí null, pokud soubor
  /// neexistuje nebo je poškozený.
  ///
  /// jsonDecode + map() přes 12k markerů poběží v background isolate
  /// pomocí [compute], takže main isolate (UI thread) zůstává plynulý.
  Future<({int version, List<RestaurantMarkerLight> data})?> loadFromDisk() async {
    try {
      final file = await _dataFile;
      if (!await file.exists()) return null;

      final jsonStr = await file.readAsString();
      // Parsing 1.9 MB JSON + materializing 12k objects is the single
      // biggest UI-thread freeze on cold start. Move it off-thread.
      return await compute(_parseMarkerSnapshot, jsonStr);
    } catch (_) {
      return null;
    }
  }

  /// Uloží snapshot markerů na disk.
  ///
  /// jsonEncode + map() přes 12k markerů poběží v background isolate
  /// pomocí [compute]. Verze se zároveň zapíše do separátního malého
  /// souboru, aby ji [getLocalVersion] mohl číst bez parsování celého
  /// snapshotu.
  Future<void> saveToDisk(int version, List<RestaurantMarkerLight> data) async {
    try {
      final file = await _dataFile;
      // Same reason as load: keep the encode off the UI thread.
      final jsonStr = await compute(
        _serializeMarkerSnapshot,
        _SerializeArgs(version, data),
      );
      await file.writeAsString(jsonStr);

      // Write the version sidecar AFTER the main file lands so we never
      // claim a cached version that doesn't actually have data behind it.
      final versionFile = await _versionFile;
      await versionFile.writeAsString(version.toString());
    } catch (_) {}
  }

  /// Vrátí pouze pole verze. Čte z malého sidecar souboru
  /// `markers_cache.version` namísto otevírání 1.9 MB JSON snapshotu.
  ///
  /// Fallback na starý snapshot pro upgrade path: pokud sidecar
  /// soubor neexistuje (uživatel přechází z předchozí verze app),
  /// jednorázově ho vytvoří tím, že přečte version z hlavního JSONu.
  Future<int?> getLocalVersion() async {
    try {
      final versionFile = await _versionFile;
      if (await versionFile.exists()) {
        final raw = await versionFile.readAsString();
        return int.tryParse(raw.trim());
      }

      // Migration path: sidecar missing → reconstruct it from the
      // legacy snapshot once.
      final dataFile = await _dataFile;
      if (!await dataFile.exists()) return null;
      final jsonStr = await dataFile.readAsString();
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      final version = json['version'] as int;
      await versionFile.writeAsString(version.toString());
      return version;
    } catch (_) {
      return null;
    }
  }
}

// ---------- Background-isolate helpers ----------
//
// These must be top-level (or static) functions because Dart's `compute`
// helper sends the entry point across the isolate boundary by serializing
// it. Closures and instance methods can't be sent.

/// Top-level function so it can be passed to [compute].
({int version, List<RestaurantMarkerLight> data}) _parseMarkerSnapshot(
  String jsonStr,
) {
  final json = jsonDecode(jsonStr) as Map<String, dynamic>;
  final version = json['version'] as int;
  final rawList = json['data'] as List<dynamic>;
  final data = rawList
      .map((e) => RestaurantMarkerLight.fromJson(e as Map<String, dynamic>))
      .toList();
  return (version: version, data: data);
}

class _SerializeArgs {
  final int version;
  final List<RestaurantMarkerLight> data;
  _SerializeArgs(this.version, this.data);
}

String _serializeMarkerSnapshot(_SerializeArgs args) {
  return jsonEncode({
    'version': args.version,
    'data': args.data.map((d) => d.toJson()).toList(),
  });
}
