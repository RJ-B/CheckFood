import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours.freezed.dart';

@freezed
class OpeningHours with _$OpeningHours {
  const OpeningHours._();

  const factory OpeningHours({
    required int dayOfWeek,
    String? openAt,
    String? closeAt,
    required bool isClosed,
  }) = _OpeningHours;

  /// Returns a formatted string of the opening hours for display.
  String get formattedHours {
    if (isClosed || openAt == null || closeAt == null) return 'Zavřeno';
    final open = openAt!.substring(0, 5);
    final close = closeAt!.substring(0, 5);
    return '$open – $close';
  }
}
