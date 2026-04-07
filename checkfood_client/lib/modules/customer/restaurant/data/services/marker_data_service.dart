import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/restaurant_marker_light.dart';

/// Persists and retrieves the restaurant marker snapshot on the local filesystem.
class MarkerDataService {
  static const _fileName = 'markers_cache.json';

  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  /// Loads the cached marker snapshot from disk. Returns null if the file does not exist or is corrupt.
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

  /// Persists the marker snapshot to disk.
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

  /// Returns only the version field from the cached file without deserializing the full data set.
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
