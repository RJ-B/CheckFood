import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours_model.freezed.dart';
part 'opening_hours_model.g.dart';

@freezed
class OpeningHoursModel with _$OpeningHoursModel {
  const factory OpeningHoursModel({
    required String dayOfWeek,
    String? openAt,
    String? closeAt,
    @Default(false) bool closed,
  }) = _OpeningHoursModel;

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursModelFromJson(json);
}
