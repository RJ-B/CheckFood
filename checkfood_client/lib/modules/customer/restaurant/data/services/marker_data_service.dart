import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/restaurant_marker_light.dart';

/// Ukládá a načítá snapshot markerů restaurací v lokálním souborovém systému.
class MarkerDataService {
  static const _fileName = 'markers_cache.json';

  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  /// Načte cachovaný snapshot markerů z disku. Vrátí null, pokud soubor neexistuje nebo je poškozený.
  Future<({int version, List<RestaurantMarkerLight> data})?> loadFromDisk() async {
    try {
      final file = await _file;
      if (!await file.exists()) return null;

      final jsonStr = await file.readAsString();
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      final version = json['version'] as int;
      final rawList = json['data'] as List<dynamic>;

      final data = rawList
          .map((e) => RestaurantMarkerLight.fromJson(e as Map<String, dynamic>))
          .toList();

      return (version: version, data: data);
    } catch (_) {
      return null;
    }
  }

  /// Uloží snapshot markerů na disk.
  Future<void> saveToDisk(int version, List<RestaurantMarkerLight> data) async {
    try {
      final file = await _file;
      final json = {
        'version': version,
        'data': data.map((d) => d.toJson()).toList(),
      };
      await file.writeAsString(jsonEncode(json));
    } catch (_) {}
  }

  /// Vrátí pouze pole verze z cachovaného souboru bez deserializace celé datové sady.
  Future<int?> getLocalVersion() async {
    try {
      final file = await _file;
      if (!await file.exists()) return null;
      final jsonStr = await file.readAsString();
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return json['version'] as int;
    } catch (_) {
      return null;
    }
  }
}
