import '../../data/models/address_model.dart';
import '../../data/models/restaurant_response_model.dart';
import '../repositories/onboarding_repository.dart';

class UpdateRestaurantInfoUseCase {
  final OnboardingRepository _repository;

  UpdateRestaurantInfoUseCase(this._repository);

  Future<OwnerRestaurantResponseModel> call({
    required String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  }) =>
      _repository.updateInfo(
        name: name,
        description: description,
        phone: phone,
        email: email,
        address: address,
        cuisineType: cuisineType,
      );
}
