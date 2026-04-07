import '../entities/staff_reservation.dart';
import '../entities/staff_table.dart';

/// Domain contract for staff-facing reservation management operations.
abstract class StaffReservationRepository {
  Future<List<StaffReservation>> getReservations(String date, {String? restaurantId});
  Future<void> confirmReservation(String id);
  Future<void> rejectReservation(String id);
  Future<void> checkInReservation(String id);
  Future<void> completeReservation(String id);
  Future<List<StaffTable>> getRestaurantTables({String? restaurantId});
  Future<void> proposeChange(String reservationId, {String? startTime, String? tableId});
  Future<void> extendReservation(String reservationId, String endTime);
}
