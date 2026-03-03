import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours.freezed.dart';

@freezed
class OpeningHours with _$OpeningHours {
  const OpeningHours._();

  const factory OpeningHours({
    required int dayOfWeek, // 1 (pondělí) až 7 (neděle)
    String? openAt, // formát "HH:mm:ss" nebo "HH:mm"
    String? closeAt,
    required bool isClosed,
  }) = _OpeningHours;

  /// Vrátí přehledný text provozní doby
  String get formattedHours {
    if (isClosed || openAt == null || closeAt == null) return 'Zavřeno';
    // Odstranění sekund, pokud jsou přítomny (z "10:00:00" na "10:00")
    final open = openAt!.substring(0, 5);
    final close = closeAt!.substring(0, 5);
    return '$open – $close';
  }
}
