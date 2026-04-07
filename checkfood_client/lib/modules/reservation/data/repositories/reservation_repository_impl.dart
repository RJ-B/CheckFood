import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions/server_exceptions.dart';
import '../../domain/entities/available_slots.dart';
import '../../domain/entities/my_reservations_overview.dart';
import '../../domain/entities/pending_change.dart';
import '../../domain/entities/recurring_reservation.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/entities/reservation_scene.dart';
import '../../domain/entities/table_status.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/reservation_remote_datasource.dart';
import '../models/request/create_recurring_reservation_request_model.dart';
import '../models/request/create_reservation_request_model.dart';
import '../models/request/update_reservation_request_model.dart';

/// Implementace repository, která deleguje na [ReservationRemoteDataSource]
/// a mapuje response modely na domain entity.
class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDataSource _remoteDataSource;

  ReservationRepositoryImpl(this._remoteDataSource);

  @override
  Future<ReservationScene> getReservationScene(String restaurantId) async {
    try {
      final model = await _remoteDataSource.getReservationScene(restaurantId);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<TableStatusList> getTableStatuses(String restaurantId, String date) async {
    try {
      final model = await _remoteDataSource.getTableStatuses(restaurantId, date);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<AvailableSlots> getAvailableSlots(
    String restaurantId,
    String tableId,
    String date, {
    String? excludeReservationId,
  }) async {
    try {
      final model = await _remoteDataSource.getAvailableSlots(
        restaurantId,
        tableId,
        date,
        excludeReservationId: excludeReservationId,
      );
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<Reservation> createReservation({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async {
    try {
      final request = CreateReservationRequestModel(
        restaurantId: restaurantId,
        tableId: tableId,
        date: date,
        startTime: startTime,
        partySize: partySize,
      );
      final model = await _remoteDataSource.createReservation(request);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async {
    try {
      final model = await _remoteDataSource.getMyReservationsOverview();
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<List<Reservation>> getMyReservationsHistory() async {
    try {
      final models = await _remoteDataSource.getMyReservationsHistory();
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<Reservation> updateReservation({
    required String reservationId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async {
    try {
      final request = UpdateReservationRequestModel(
        tableId: tableId,
        date: date,
        startTime: startTime,
        partySize: partySize,
      );
      final model = await _remoteDataSource.updateReservation(reservationId, request);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<Reservation> cancelReservation(String reservationId) async {
    try {
      final model = await _remoteDataSource.cancelReservation(reservationId);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<List<PendingChange>> getPendingChanges() async {
    try {
      final models = await _remoteDataSource.getPendingChanges();
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<Reservation> acceptChangeRequest(String changeRequestId) async {
    try {
      final model = await _remoteDataSource.acceptChangeRequest(changeRequestId);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<Reservation> declineChangeRequest(String changeRequestId) async {
    try {
      final model = await _remoteDataSource.declineChangeRequest(changeRequestId);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<RecurringReservation> createRecurringReservation({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    int partySize = 2,
  }) async {
    try {
      final request = CreateRecurringReservationRequestModel(
        restaurantId: restaurantId,
        tableId: tableId,
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        partySize: partySize,
      );
      final model = await _remoteDataSource.createRecurringReservation(request);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<List<RecurringReservation>> getMyRecurringReservations() async {
    try {
      final models = await _remoteDataSource.getMyRecurringReservations();
      return models.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  @override
  Future<RecurringReservation> cancelRecurringReservation(String id) async {
    try {
      final model = await _remoteDataSource.cancelRecurringReservation(id);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ServerException('Neočekávaná chyba: $e');
    }
  }

  Exception _mapDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const ConnectionException();
    }
    final statusCode = e.response?.statusCode;
    final message = _extractErrorMessage(e);
    switch (statusCode) {
      case 400:
        return ValidationException(message);
      case 401:
        return UnauthorizedException(message);
      case 403:
        return ForbiddenException(message);
      case 404:
        return NotFoundException(message);
      case 409:
        return ConflictException(message);
      case 429:
        return RateLimitException(message);
      default:
        return ServerException(message);
    }
  }

  String _extractErrorMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
    } catch (_) {}
    return 'Došlo k chybě serveru.';
  }
}
