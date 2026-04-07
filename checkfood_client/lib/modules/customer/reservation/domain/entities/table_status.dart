import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_status.freezed.dart';

/// The availability statuses for all tables in a restaurant on a given date.
@freezed
class TableStatusList with _$TableStatusList {
  const factory TableStatusList({
    required String date,
    required List<TableStatus> tables,
  }) = _TableStatusList;
}

/// Availability status of a single table (e.g. available, partially booked).
@freezed
class TableStatus with _$TableStatus {
  const factory TableStatus({
    required String tableId,
    required String status,
  }) = _TableStatus;
}
