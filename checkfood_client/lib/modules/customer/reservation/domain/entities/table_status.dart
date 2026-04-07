import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_status.freezed.dart';

/// Stavy dostupnosti všech stolů restaurace pro zadané datum.
@freezed
class TableStatusList with _$TableStatusList {
  const factory TableStatusList({
    required String date,
    required List<TableStatus> tables,
  }) = _TableStatusList;
}

/// Stav dostupnosti jednoho stolu (např. volný, částečně obsazený).
@freezed
class TableStatus with _$TableStatus {
  const factory TableStatus({
    required String tableId,
    required String status,
  }) = _TableStatus;
}
