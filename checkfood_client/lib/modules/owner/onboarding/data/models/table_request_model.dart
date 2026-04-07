import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_request_model.freezed.dart';
part 'table_request_model.g.dart';

/// Request payload for creating or updating a restaurant table.
@freezed
class TableRequestModel with _$TableRequestModel {
  const factory TableRequestModel({
    required String label,
    required int capacity,
    @Default(true) bool active,
  }) = _TableRequestModel;

  factory TableRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TableRequestModelFromJson(json);
}
