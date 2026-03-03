import '../entities/available_slots.dart';
import '../entities/my_reservations_overview.dart';
import '../entities/reservation.dart';
import '../entities/reservation_scene.dart';
import '../entities/table_status.dart';

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
}
