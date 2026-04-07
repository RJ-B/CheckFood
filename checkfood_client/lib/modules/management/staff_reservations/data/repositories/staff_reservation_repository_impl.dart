import '../../domain/entities/staff_reservation.dart';
import '../../domain/entities/staff_table.dart';
import '../../domain/repositories/staff_reservation_repository.dart';
import '../datasources/staff_reservation_remote_datasource.dart';

/// Implementace repository delegující na [StaffReservationRemoteDataSource]
/// a mapující response modely na doménové entity.
class StaffReservationRepositoryImpl implements StaffReservationRepository {
  final StaffReservationRemoteDataSource _remoteDataSource;

  StaffReservationRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<StaffReservation>> getReservations(String date, {String? restaurantId}) async {
    final models = await _remoteDataSource.getReservations(date, restaurantId: restaurantId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> confirmReservation(String id) {
    return _remoteDataSource.confirmReservation(id);
  }

  @override
  Future<void> rejectReservation(String id) {
    return _remoteDataSource.rejectReservation(id);
  }

  @override
  Future<void> checkInReservation(String id) {
    return _remoteDataSource.checkInReservation(id);
  }

  @override
  Future<void> completeReservation(String id) {
    return _remoteDataSource.completeReservation(id);
  }

  @override
  Future<List<StaffTable>> getRestaurantTables({String? restaurantId}) async {
    final models = await _remoteDataSource.getRestaurantTables(restaurantId: restaurantId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> proposeChange(String reservationId, {String? startTime, String? tableId}) {
    return _remoteDataSource.proposeChange(reservationId, startTime: startTime, tableId: tableId);
  }

  @override
  Future<void> extendReservation(String reservationId, String endTime) {
    return _remoteDataSource.extendReservation(reservationId, endTime);
  }
}
