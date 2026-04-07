// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservations_overview_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyReservationsOverviewResponseModelImpl
_$$MyReservationsOverviewResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$MyReservationsOverviewResponseModelImpl(
  upcoming:
      (json['upcoming'] as List<dynamic>?)
          ?.map(
            (e) => ReservationResponseModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  history:
      (json['history'] as List<dynamic>?)
          ?.map(
            (e) => ReservationResponseModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  totalHistoryCount: (json['totalHistoryCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$MyReservationsOverviewResponseModelImplToJson(
  _$MyReservationsOverviewResponseModelImpl instance,
) => <String, dynamic>{
  'upcoming': instance.upcoming,
  'history': instance.history,
  'totalHistoryCount': instance.totalHistoryCount,
};
