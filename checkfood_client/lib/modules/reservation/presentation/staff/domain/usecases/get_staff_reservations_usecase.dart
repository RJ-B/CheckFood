import '../entities/staff_reservation.dart';
import '../repositories/staff_reservation_repository.dart';

/// Vrátí všechny rezervace pro daný den z pohledu personálu.
class GetStaffReservationsUseCase {
  final StaffReservationRepository _repository;

  GetStaffReservationsUseCase(this._repository);

  Future<List<StaffReservation>> call(String date, {String? restaurantId}) {
    return _repository.getReservations(date, restaurantId: restaurantId);
  }
}
