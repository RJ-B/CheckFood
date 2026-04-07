import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';

/// A single table reservation including its status and any pending change request.
@freezed
class Reservation with _$Reservation {
  const Reservation._();

  const factory Reservation({
    required String id,
    required String restaurantId,
    required String tableId,
    String? restaurantName,
    String? tableLabel,
    required String date,
    required String startTime,
    String? endTime,
    required String status,
    required int partySize,
    @Default(false) bool canEdit,
    @Default(false) bool canCancel,
    String? pendingChangeRequestId,
    String? pendingProposedStartTime,
    String? pendingProposedTableId,
    String? pendingProposedTableLabel,
  }) = _Reservation;
}
