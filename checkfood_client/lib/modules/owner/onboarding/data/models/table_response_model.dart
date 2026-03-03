import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/onboarding_table.dart';

part 'table_response_model.freezed.dart';
part 'table_response_model.g.dart';

@freezed
class TableResponseModel with _$TableResponseModel {
  const TableResponseModel._();

  const factory TableResponseModel({
    String? id,
    String? label,
    @Default(0) int capacity,
    @Default(true) bool active,
    double? yaw,
    double? pitch,
  }) = _TableResponseModel;

  factory TableResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TableResponseModelFromJson(json);

  OnboardingTable toEntity() => OnboardingTable(
        id: id ?? '',
        label: label ?? '',
        capacity: capacity,
        active: active,
        yaw: yaw,
        pitch: pitch,
      );
}
