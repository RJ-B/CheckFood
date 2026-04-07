import '../repositories/staff_reservation_repository.dart';

/// Označí rezervaci jako dokončenou po skončení návštěvy hostů.
class CompleteReservationUseCase {
  final StaffReservationRepository _repository;

  CompleteReservationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.completeReservation(id);
  }
}
