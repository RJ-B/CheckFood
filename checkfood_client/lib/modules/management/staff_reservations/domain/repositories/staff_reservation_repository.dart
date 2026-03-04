import '../entities/staff_reservation.dart';

abstract class StaffReservationRepository {
  Future<List<StaffReservation>> getReservations(String date);
  Future<void> confirmReservation(String id);
  Future<void> rejectReservation(String id);
  Future<void> checkInReservation(String id);
  Future<void> completeReservation(String id);
}
