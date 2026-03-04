import '../entities/staff_reservation.dart';
import '../repositories/staff_reservation_repository.dart';

class GetStaffReservationsUseCase {
  final StaffReservationRepository _repository;

  GetStaffReservationsUseCase(this._repository);

  Future<List<StaffReservation>> call(String date) {
    return _repository.getReservations(date);
  }
}
