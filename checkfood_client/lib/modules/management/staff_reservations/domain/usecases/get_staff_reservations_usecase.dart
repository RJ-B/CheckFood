import '../entities/staff_reservation.dart';
import '../repositories/staff_reservation_repository.dart';

/// Returns all reservations for a given date as seen by staff.
class GetStaffReservationsUseCase {
  final StaffReservationRepository _repository;

  GetStaffReservationsUseCase(this._repository);

  Future<List<StaffReservation>> call(String date, {String? restaurantId}) {
    return _repository.getReservations(date, restaurantId: restaurantId);
  }
}
