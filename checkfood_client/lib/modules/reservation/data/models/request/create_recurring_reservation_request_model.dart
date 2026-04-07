import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_recurring_reservation_request_model.freezed.dart';
part 'create_recurring_reservation_request_model.g.dart';

/// Tělo požadavku pro vytvoření týdenní opakované rezervace.
@freezed
class CreateRecurringReservationRequestModel
    with _$CreateRecurringReservationRequestModel {
  const factory CreateRecurringReservationRequestModel({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    @Default(2) int partySize,
  }) = _CreateRecurringReservationRequestModel;

  factory CreateRecurringReservationRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$CreateRecurringReservationRequestModelFromJson(json);
}
