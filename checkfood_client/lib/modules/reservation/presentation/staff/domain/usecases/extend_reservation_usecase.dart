import '../repositories/staff_reservation_repository.dart';

/// Prodlouží čas konce aktivní rezervace.
class ExtendReservationUseCase {
  final StaffReservationRepository _repository;
  ExtendReservationUseCase(this._repository);

  Future<void> call(String reservationId, String endTime) {
    return _repository.extendReservation(reservationId, endTime);
  }
}
