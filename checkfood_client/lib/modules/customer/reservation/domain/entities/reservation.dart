import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';

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
    required String endTime,
    required String status,
    required int partySize,
    @Default(false) bool canEdit,
    @Default(false) bool canCancel,
  }) = _Reservation;
}
