import '../../domain/entities/staff_reservation.dart';
import '../../domain/repositories/staff_reservation_repository.dart';
import '../datasources/staff_reservation_remote_datasource.dart';

class StaffReservationRepositoryImpl implements StaffReservationRepository {
  final StaffReservationRemoteDataSource _remoteDataSource;

  StaffReservationRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<StaffReservation>> getReservations(String date) async {
    final models = await _remoteDataSource.getReservations(date);
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
}
