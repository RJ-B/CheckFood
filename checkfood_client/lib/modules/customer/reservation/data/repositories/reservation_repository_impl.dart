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

/// Repository implementation that delegates to [ReservationRemoteDataSource]
/// and maps response models to domain entities.
class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDataSource _remoteDataSource;

  ReservationRepositoryImpl(this._remoteDataSource);

  @override
  Future<ReservationScene> getReservationScene(String restaurantId) async {
    final model = await _remoteDataSource.getReservationScene(restaurantId);
    return model.toEntity();
  }

  @override
  Future<TableStatusList> getTableStatuses(String restaurantId, String date) async {
    final model = await _remoteDataSource.getTableStatuses(restaurantId, date);
    return model.toEntity();
  }

  @override
  Future<AvailableSlots> getAvailableSlots(
    String restaurantId,
    String tableId,
    String date, {
    String? excludeReservationId,
  }) async {
    final model = await _remoteDataSource.getAvailableSlots(
      restaurantId,
      tableId,
      date,
      excludeReservationId: excludeReservationId,
    );
    return model.toEntity();
  }

  @override
  Future<Reservation> createReservation({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async {
    final request = CreateReservationRequestModel(
      restaurantId: restaurantId,
      tableId: tableId,
      date: date,
      startTime: startTime,
      partySize: partySize,
    );
    final model = await _remoteDataSource.createReservation(request);
    return model.toEntity();
  }

  @override
  Future<MyReservationsOverview> getMyReservationsOverview() async {
    final model = await _remoteDataSource.getMyReservationsOverview();
    return model.toEntity();
  }

  @override
  Future<List<Reservation>> getMyReservationsHistory() async {
    final models = await _remoteDataSource.getMyReservationsHistory();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Reservation> updateReservation({
    required String reservationId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  }) async {
    final request = UpdateReservationRequestModel(
      tableId: tableId,
      date: date,
      startTime: startTime,
      partySize: partySize,
    );
    final model = await _remoteDataSource.updateReservation(reservationId, request);
    return model.toEntity();
  }

  @override
  Future<Reservation> cancelReservation(String reservationId) async {
    final model = await _remoteDataSource.cancelReservation(reservationId);
    return model.toEntity();
  }

  @override
  Future<List<PendingChange>> getPendingChanges() async {
    final models = await _remoteDataSource.getPendingChanges();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Reservation> acceptChangeRequest(String changeRequestId) async {
    final model = await _remoteDataSource.acceptChangeRequest(changeRequestId);
    return model.toEntity();
  }

  @override
  Future<Reservation> declineChangeRequest(String changeRequestId) async {
    final model = await _remoteDataSource.declineChangeRequest(changeRequestId);
    return model.toEntity();
  }

  @override
  Future<RecurringReservation> createRecurringReservation({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    int partySize = 2,
  }) async {
    final request = CreateRecurringReservationRequestModel(
      restaurantId: restaurantId,
      tableId: tableId,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      partySize: partySize,
    );
    final model = await _remoteDataSource.createRecurringReservation(request);
    return model.toEntity();
  }

  @override
  Future<List<RecurringReservation>> getMyRecurringReservations() async {
    final models = await _remoteDataSource.getMyRecurringReservations();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<RecurringReservation> cancelRecurringReservation(String id) async {
    final model = await _remoteDataSource.cancelRecurringReservation(id);
    return model.toEntity();
  }
}
