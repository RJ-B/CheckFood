import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_status.freezed.dart';

@freezed
class TableStatusList with _$TableStatusList {
  const factory TableStatusList({
    required String date,
    required List<TableStatus> tables,
  }) = _TableStatusList;
}

@freezed
class TableStatus with _$TableStatus {
  const factory TableStatus({
    required String tableId,
    required String status,
  }) = _TableStatus;
}
