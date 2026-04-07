import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_reservation_request_model.freezed.dart';
part 'update_reservation_request_model.g.dart';

/// Request payload for updating the table, date, time, or party size of an existing reservation.
@freezed
class UpdateReservationRequestModel with _$UpdateReservationRequestModel {
  const factory UpdateReservationRequestModel({
    required String tableId,
    required String date,
    required String startTime,
    required int partySize,
  }) = _UpdateReservationRequestModel;

  factory UpdateReservationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateReservationRequestModelFromJson(json);
}
