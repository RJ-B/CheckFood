import '../../data/models/restaurant_response_model.dart';
import '../repositories/onboarding_repository.dart';

/// Publishes the restaurant, marking onboarding as complete and making it visible to customers.
class PublishRestaurantUseCase {
  final OnboardingRepository _repository;

  PublishRestaurantUseCase(this._repository);

  Future<OwnerRestaurantResponseModel> call() => _repository.publish();
}
