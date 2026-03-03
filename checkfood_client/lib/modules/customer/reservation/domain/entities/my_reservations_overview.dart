import 'package:freezed_annotation/freezed_annotation.dart';

import 'reservation.dart';

part 'my_reservations_overview.freezed.dart';

@freezed
class MyReservationsOverview with _$MyReservationsOverview {
  const factory MyReservationsOverview({
    required List<Reservation> upcoming,
    required List<Reservation> history,
    required int totalHistoryCount,
  }) = _MyReservationsOverview;
}
