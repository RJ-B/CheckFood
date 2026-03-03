import 'package:dio/dio.dart';

import '../models/request/create_reservation_request_model.dart';
import '../models/request/update_reservation_request_model.dart';
import '../models/response/available_slots_response_model.dart';
import '../models/response/my_reservations_overview_response_model.dart';
import '../models/response/reservation_response_model.dart';
import '../models/response/reservation_scene_response_model.dart';
import '../models/response/table_status_response_model.dart';

abstract class ReservationRemoteDataSource {
  Future<ReservationSceneResponseModel> getReservationScene(String restaurantId);
  Future<TableStatusResponseModel> getTableStatuses(String restaurantId, String date);
  Future<AvailableSlotsResponseModel> getAvailableSlots(String restaurantId, String tableId, String date, {String? excludeReservationId});
  Future<ReservationResponseModel> createReservation(CreateReservationRequestModel request);
  Future<MyReservationsOverviewResponseModel> getMyReservationsOverview();
  Future<List<ReservationResponseModel>> getMyReservationsHistory();
  Future<ReservationResponseModel> updateReservation(String id, UpdateReservationRequestModel request);
  Future<ReservationResponseModel> cancelReservation(String id);
}

class ReservationRemoteDataSourceImpl implements ReservationRemoteDataSource {
  final Dio _dio;

  // Dio baseUrl already includes /api (from .env API_BASE_URL)
  static const String _restaurantsBase = '/v1/restaurants';
  static const String _reservationsBase = '/v1/reservations';

  ReservationRemoteDataSourceImpl(this._dio);

  @override
  Future<ReservationSceneResponseModel> getReservationScene(String restaurantId) async {
    final response = await _dio.get('$_restaurantsBase/$restaurantId/reservation-scene');
    return ReservationSceneResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<TableStatusResponseModel> getTableStatuses(String restaurantId, String date) async {
    final response = await _dio.get(
      '$_restaurantsBase/$restaurantId/tables/status',
      queryParameters: {'date': date},
    );
    return TableStatusResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AvailableSlotsResponseModel> getAvailableSlots(
    String restaurantId,
    String tableId,
    String date, {
    String? excludeReservationId,
  }) async {
    final queryParams = <String, dynamic>{'date': date};
    if (excludeReservationId != null) {
      queryParams['excludeReservationId'] = excludeReservationId;
    }
    final response = await _dio.get(
      '$_restaurantsBase/$restaurantId/tables/$tableId/available-slots',
      queryParameters: queryParams,
    );
    return AvailableSlotsResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ReservationResponseModel> createReservation(CreateReservationRequestModel request) async {
    final response = await _dio.post(
      _reservationsBase,
      data: request.toJson(),
    );
    return ReservationResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<MyReservationsOverviewResponseModel> getMyReservationsOverview() async {
    final response = await _dio.get('$_reservationsBase/me');
    return MyReservationsOverviewResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<ReservationResponseModel>> getMyReservationsHistory() async {
    final response = await _dio.get('$_reservationsBase/me/history');
    return (response.data as List)
        .map((json) => ReservationResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ReservationResponseModel> updateReservation(String id, UpdateReservationRequestModel request) async {
    final response = await _dio.put(
      '$_reservationsBase/$id',
      data: request.toJson(),
    );
    return ReservationResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ReservationResponseModel> cancelReservation(String id) async {
    final response = await _dio.patch('$_reservationsBase/$id/cancel');
    return ReservationResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}
