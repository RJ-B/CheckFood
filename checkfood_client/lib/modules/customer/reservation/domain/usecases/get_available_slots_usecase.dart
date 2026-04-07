import '../entities/available_slots.dart';
import '../repositories/reservation_repository.dart';

/// Returns the available booking time slots for a given table and date.
class GetAvailableSlotsUseCase {
  final ReservationRepository _repository;

  GetAvailableSlotsUseCase(this._repository);

  Future<AvailableSlots> call(
    String restaurantId,
    String tableId,
    String date, {
    String? excludeReservationId,
  }) async {
    return await _repository.getAvailableSlots(
      restaurantId,
      tableId,
      date,
      excludeReservationId: excludeReservationId,
    );
  }
}
