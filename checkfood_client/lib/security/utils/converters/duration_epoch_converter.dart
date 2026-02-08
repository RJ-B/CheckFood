import 'package:freezed_annotation/freezed_annotation.dart';

/// Konvertuje int (sekundy z backendu) na Duration (Dart objekt).
class DurationEpochConverter implements JsonConverter<Duration, int?> {
  const DurationEpochConverter();

  @override
  Duration fromJson(int? json) => Duration(seconds: json ?? 0);

  @override
  int? toJson(Duration object) => object.inSeconds;
}
