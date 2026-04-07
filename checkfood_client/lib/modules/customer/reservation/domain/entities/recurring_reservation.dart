import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_reservation.freezed.dart';

/// Opakující se týdenní rezervace generující jednotlivé instance rezervací.
@freezed
class RecurringReservation with _$RecurringReservation {
  const factory RecurringReservation({
    required String id,
    required String restaurantId,
    required String tableId,
    String? restaurantName,
    String? tableLabel,
    required String dayOfWeek,
    required String startTime,
    required int partySize,
    required String status,
    String? repeatUntil,
    required String createdAt,
    @Default(0) int instanceCount,
  }) = _RecurringReservation;
}
