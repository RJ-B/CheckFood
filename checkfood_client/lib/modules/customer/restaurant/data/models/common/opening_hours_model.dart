import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/opening_hours.dart';

part 'opening_hours_model.freezed.dart';
part 'opening_hours_model.g.dart';

/// API response/request model pro otevírací dobu jednoho dne.
@freezed
class OpeningHoursModel with _$OpeningHoursModel {
  const OpeningHoursModel._();

  const factory OpeningHoursModel({
    @JsonKey(name: 'dayOfWeek') required String dayString,
    String? openAt,
    String? closeAt,
    @JsonKey(name: 'closed')
    required bool isClosed,
  }) = _OpeningHoursModel;

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursModelFromJson(json);

  OpeningHours toEntity() {
    return OpeningHours(
      dayOfWeek: _mapDayToNumber(dayString),
      openAt: openAt,
      closeAt: closeAt,
      isClosed: isClosed,
    );
  }

  int _mapDayToNumber(String day) {
    switch (day.toUpperCase()) {
      case 'MONDAY':
        return 1;
      case 'TUESDAY':
        return 2;
      case 'WEDNESDAY':
        return 3;
      case 'THURSDAY':
        return 4;
      case 'FRIDAY':
        return 5;
      case 'SATURDAY':
        return 6;
      case 'SUNDAY':
        return 7;
      default:
        return 1;
    }
  }
}
