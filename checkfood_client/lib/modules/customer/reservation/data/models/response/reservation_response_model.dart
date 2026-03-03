import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/reservation.dart';

part 'reservation_response_model.freezed.dart';
part 'reservation_response_model.g.dart';

@freezed
class ReservationResponseModel with _$ReservationResponseModel {
  const ReservationResponseModel._();

  const factory ReservationResponseModel({
    String? id,
    String? restaurantId,
    String? tableId,
    String? restaurantName,
    String? tableLabel,
    String? date,
    String? startTime,
    String? endTime,
    String? status,
    int? partySize,
    @Default(false) bool canEdit,
    @Default(false) bool canCancel,
  }) = _ReservationResponseModel;

  factory ReservationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationResponseModelFromJson(json);

  Reservation toEntity() => Reservation(
        id: id ?? '',
        restaurantId: restaurantId ?? '',
        tableId: tableId ?? '',
        restaurantName: restaurantName,
        tableLabel: tableLabel,
        date: date ?? '',
        startTime: startTime ?? '',
        endTime: endTime ?? '',
        status: status ?? 'RESERVED',
        partySize: partySize ?? 2,
        canEdit: canEdit,
        canCancel: canCancel,
      );
}
