import '../entities/available_slots.dart';
import '../entities/my_reservations_overview.dart';
import '../entities/pending_change.dart';
import '../entities/recurring_reservation.dart';
import '../entities/reservation.dart';
import '../entities/reservation_scene.dart';
import '../entities/table_status.dart';

/// Domain contract for the reservation repository.
abstract class ReservationRepository {
  Future<ReservationScene> getReservationScene(String restaurantId);

  Future<TableStatusList> getTableStatuses(String restaurantId, String date);

  Future<AvailableSlots> getAvailableSlots(
    String restaurantId,
    String tableId,
    String date, {
    String? excludeReservationId,
  });

  Future<Reservation> createReservation({
    required String restaurantId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  });

  Future<MyReservationsOverview> getMyReservationsOverview();

  Future<List<Reservation>> getMyReservationsHistory();

  Future<Reservation> updateReservation({
    required String reservationId,
    required String tableId,
    required String date,
    required String startTime,
    int partySize = 2,
  });

  Future<Reservation> cancelReservation(String reservationId);

  Future<List<PendingChange>> getPendingChanges();
  Future<Reservation> acceptChangeRequest(String changeRequestId);
  Future<Reservation> declineChangeRequest(String changeRequestId);

  Future<RecurringReservation> createRecurringReservation({
    required String restaurantId,
    required String tableId,
    required String dayOfWeek,
    required String startTime,
    int partySize = 2,
  });
  Future<List<RecurringReservation>> getMyRecurringReservations();
  Future<RecurringReservation> cancelRecurringReservation(String id);
}
