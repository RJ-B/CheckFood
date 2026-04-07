import '../../data/models/opening_hours_model.dart';
import '../../data/models/restaurant_response_model.dart';
import '../repositories/onboarding_repository.dart';

/// Saves the restaurant's weekly opening hours during onboarding step 2.
class UpdateRestaurantHoursUseCase {
  final OnboardingRepository _repository;

  UpdateRestaurantHoursUseCase(this._repository);

  Future<OwnerRestaurantResponseModel> call(List<OpeningHoursModel> hours) =>
      _repository.updateHours(hours);
}
