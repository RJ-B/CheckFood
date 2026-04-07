import '../repositories/staff_reservation_repository.dart';

/// Proposes a time or table change for a reservation, sending it for guest approval.
class ProposeChangeUseCase {
  final StaffReservationRepository _repository;
  ProposeChangeUseCase(this._repository);

  Future<void> call(String reservationId, {String? startTime, String? tableId}) {
    return _repository.proposeChange(reservationId, startTime: startTime, tableId: tableId);
  }
}
