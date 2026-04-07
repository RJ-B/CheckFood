import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/pending_change.dart';

part 'pending_change_model.freezed.dart';
part 'pending_change_model.g.dart';

/// API response model representing a staff-proposed change to an existing reservation.
@freezed
class PendingChangeModel with _$PendingChangeModel {
  const PendingChangeModel._();

  const factory PendingChangeModel({
    String? id,
    String? reservationId,
    String? restaurantName,
    String? proposedStartTime,
    String? proposedTableId,
    String? proposedTableLabel,
    String? originalStartTime,
    String? originalTableId,
    String? originalTableLabel,
    String? reservationDate,
    String? status,
    String? createdAt,
  }) = _PendingChangeModel;

  factory PendingChangeModel.fromJson(Map<String, dynamic> json) =>
      _$PendingChangeModelFromJson(json);

  PendingChange toEntity() => PendingChange(
        id: id ?? '',
        reservationId: reservationId ?? '',
        restaurantName: restaurantName ?? '',
        proposedStartTime: proposedStartTime,
        proposedTableId: proposedTableId,
        proposedTableLabel: proposedTableLabel,
        originalStartTime: originalStartTime ?? '',
        originalTableId: originalTableId ?? '',
        originalTableLabel: originalTableLabel ?? '',
        reservationDate: reservationDate ?? '',
        status: status ?? 'PENDING',
        createdAt: createdAt ?? '',
      );
}
