import '../entities/available_slots.dart';
import '../repositories/reservation_repository.dart';

/// Vrátí dostupné časové sloty rezervace pro zadaný stůl a datum.
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
