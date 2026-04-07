import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_request_model.freezed.dart';
part 'table_request_model.g.dart';

/// Request payload pro vytvoření nebo aktualizaci stolu restaurace.
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
