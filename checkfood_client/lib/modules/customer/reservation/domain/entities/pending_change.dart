import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_change.freezed.dart';

/// Navrhovaná změna existující rezervace čekající na přijetí hostem.
@freezed
class PendingChange with _$PendingChange {
  const factory PendingChange({
    required String id,
    required String reservationId,
    required String restaurantName,
    String? proposedStartTime,
    String? proposedTableId,
    String? proposedTableLabel,
    required String originalStartTime,
    required String originalTableId,
    required String originalTableLabel,
    required String reservationDate,
    required String status,
    required String createdAt,
  }) = _PendingChange;
}
