import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_reservation_request_model.freezed.dart';
part 'create_reservation_request_model.g.dart';

/// Request payload for creating a single reservation.
@freezed
class CreateReservationRequestModel with _$CreateReservationRequestModel {
  const factory CreateReservationRequestModel({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    @Default(2) int partySize,
  }) = _CreateReservationRequestModel;

  factory CreateReservationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateReservationRequestModelFromJson(json);
}
