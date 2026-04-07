import '../repositories/staff_reservation_repository.dart';

/// Navrhne změnu času nebo stolu pro rezervaci a odešle ji ke schválení hostovi.
class ProposeChangeUseCase {
  final StaffReservationRepository _repository;
  ProposeChangeUseCase(this._repository);

  Future<void> call(String reservationId, {String? startTime, String? tableId}) {
    return _repository.proposeChange(reservationId, startTime: startTime, tableId: tableId);
  }
}
