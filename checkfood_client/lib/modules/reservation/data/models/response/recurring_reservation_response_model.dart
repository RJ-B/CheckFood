import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/recurring_reservation.dart';

part 'recurring_reservation_response_model.freezed.dart';
part 'recurring_reservation_response_model.g.dart';

/// API response model pro sérii týdenních opakovaných rezervací.
@freezed
class RecurringReservationResponseModel with _$RecurringReservationResponseModel {
  const RecurringReservationResponseModel._();

  const factory RecurringReservationResponseModel({
    required String id,
    required String restaurantId,
    required String tableId,
    String? restaurantName,
    String? tableLabel,
    required String dayOfWeek,
    required String startTime,
    @Default(2) int partySize,
    required String status,
    String? repeatUntil,
    required String createdAt,
    @Default(0) int instanceCount,
  }) = _RecurringReservationResponseModel;

  factory RecurringReservationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RecurringReservationResponseModelFromJson(json);

  RecurringReservation toEntity() => RecurringReservation(
        id: id,
        restaurantId: restaurantId,
        tableId: tableId,
        restaurantName: restaurantName,
        tableLabel: tableLabel,
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        partySize: partySize,
        status: status,
        repeatUntil: repeatUntil,
        createdAt: createdAt,
        instanceCount: instanceCount,
      );
}
