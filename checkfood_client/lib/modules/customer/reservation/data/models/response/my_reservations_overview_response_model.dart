import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/my_reservations_overview.dart';
import 'reservation_response_model.dart';

part 'my_reservations_overview_response_model.freezed.dart';
part 'my_reservations_overview_response_model.g.dart';

@freezed
class MyReservationsOverviewResponseModel
    with _$MyReservationsOverviewResponseModel {
  const MyReservationsOverviewResponseModel._();

  const factory MyReservationsOverviewResponseModel({
    @Default([]) List<ReservationResponseModel> upcoming,
    @Default([]) List<ReservationResponseModel> history,
    @Default(0) int totalHistoryCount,
  }) = _MyReservationsOverviewResponseModel;

  factory MyReservationsOverviewResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MyReservationsOverviewResponseModelFromJson(json);

  MyReservationsOverview toEntity() => MyReservationsOverview(
        upcoming: upcoming.map((m) => m.toEntity()).toList(),
        history: history.map((m) => m.toEntity()).toList(),
        totalHistoryCount: totalHistoryCount,
      );
}
