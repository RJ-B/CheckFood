import '../../data/models/opening_hours_model.dart';
import '../../data/models/restaurant_response_model.dart';
import '../repositories/onboarding_repository.dart';

class UpdateRestaurantHoursUseCase {
  final OnboardingRepository _repository;

  UpdateRestaurantHoursUseCase(this._repository);

  Future<OwnerRestaurantResponseModel> call(List<OpeningHoursModel> hours) =>
      _repository.updateHours(hours);
}
