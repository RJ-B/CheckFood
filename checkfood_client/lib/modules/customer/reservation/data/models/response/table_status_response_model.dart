import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/table_status.dart';

part 'table_status_response_model.freezed.dart';
part 'table_status_response_model.g.dart';

@freezed
class TableStatusResponseModel with _$TableStatusResponseModel {
  const TableStatusResponseModel._();

  const factory TableStatusResponseModel({
    String? date,
    @Default([]) List<TableStatusItemModel> tables,
  }) = _TableStatusResponseModel;

  factory TableStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TableStatusResponseModelFromJson(json);

  TableStatusList toEntity() => TableStatusList(
        date: date ?? '',
        tables: tables.map((t) => t.toEntity()).toList(),
      );
}

@freezed
class TableStatusItemModel with _$TableStatusItemModel {
  const TableStatusItemModel._();

  const factory TableStatusItemModel({
    String? tableId,
    String? status,
  }) = _TableStatusItemModel;

  factory TableStatusItemModel.fromJson(Map<String, dynamic> json) =>
      _$TableStatusItemModelFromJson(json);

  TableStatus toEntity() => TableStatus(
        tableId: tableId ?? '',
        status: status ?? 'FREE',
      );
}
