import 'package:dio/dio.dart';

import '../models/staff_reservation_model.dart';
import '../models/staff_table_model.dart';

/// Kontrakt remote data source pro API volání správy rezervací na straně personálu.
abstract class StaffReservationRemoteDataSource {
  Future<List<StaffReservationModel>> getReservations(String date, {String? restaurantId});
  Future<void> confirmReservation(String id);
  Future<void> rejectReservation(String id);
  Future<void> checkInReservation(String id);
  Future<void> completeReservation(String id);
  Future<List<StaffTableModel>> getRestaurantTables({String? restaurantId});
  Future<void> proposeChange(String reservationId, {String? startTime, String? tableId});
  Future<void> extendReservation(String reservationId, String endTime);
}

/// Implementace [StaffReservationRemoteDataSource] využívající Dio.
class StaffReservationRemoteDataSourceImpl
    implements StaffReservationRemoteDataSource {
  final Dio _dio;

  StaffReservationRemoteDataSourceImpl(this._dio);

  @override
  Future<List<StaffReservationModel>> getReservations(String date, {String? restaurantId}) async {
    final params = <String, dynamic>{'date': date};
    if (restaurantId != null) params['restaurantId'] = restaurantId;
    final response = await _dio.get(
      '/v1/staff/my-restaurant/reservations',
      queryParameters: params,
    );
    return (response.data as List)
        .map((json) =>
            StaffReservationModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> confirmReservation(String id) async {
    await _dio.post('/v1/staff/reservations/$id/confirm');
  }

  @override
  Future<void> rejectReservation(String id) async {
    await _dio.post('/v1/staff/reservations/$id/reject');
  }

  @override
  Future<void> checkInReservation(String id) async {
    await _dio.post('/v1/staff/reservations/$id/check-in');
  }

  @override
  Future<void> completeReservation(String id) async {
    await _dio.post('/v1/staff/reservations/$id/complete');
  }

  @override
  Future<List<StaffTableModel>> getRestaurantTables({String? restaurantId}) async {
    final params = <String, dynamic>{};
    if (restaurantId != null) params['restaurantId'] = restaurantId;
    final response = await _dio.get(
      '/v1/staff/my-restaurant/tables',
      queryParameters: params.isEmpty ? null : params,
    );
    final list = response.data as List;
    return list.map((e) => StaffTableModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> proposeChange(String reservationId, {String? startTime, String? tableId}) async {
    final body = <String, dynamic>{};
    if (startTime != null) body['startTime'] = startTime;
    if (tableId != null) body['tableId'] = tableId;
    await _dio.put('/v1/staff/reservations/$reservationId/propose-change', data: body);
  }

  @override
  Future<void> extendReservation(String reservationId, String endTime) async {
    await _dio.patch('/v1/staff/reservations/$reservationId/extend', data: {'endTime': endTime});
  }
}
