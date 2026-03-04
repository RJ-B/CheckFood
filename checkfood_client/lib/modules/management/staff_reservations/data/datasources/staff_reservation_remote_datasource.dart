import 'package:dio/dio.dart';

import '../models/staff_reservation_model.dart';

abstract class StaffReservationRemoteDataSource {
  Future<List<StaffReservationModel>> getReservations(String date);
  Future<void> confirmReservation(String id);
  Future<void> rejectReservation(String id);
  Future<void> checkInReservation(String id);
  Future<void> completeReservation(String id);
}

class StaffReservationRemoteDataSourceImpl
    implements StaffReservationRemoteDataSource {
  final Dio _dio;

  StaffReservationRemoteDataSourceImpl(this._dio);

  @override
  Future<List<StaffReservationModel>> getReservations(String date) async {
    final response = await _dio.get(
      '/v1/staff/my-restaurant/reservations',
      queryParameters: {'date': date},
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
}
