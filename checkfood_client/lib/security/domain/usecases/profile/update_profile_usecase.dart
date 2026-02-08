import '../../../data/models/profile/request/update_profile_request_model.dart';
import '../../entities/user_profile.dart';
import '../../repositories/profile_repository.dart';

/// UseCase pro aktualizaci údajů v profilu uživatele.
///
/// Přijímá [UpdateProfileRequestModel] a po úspěšné operaci na serveru
/// vrací aktualizovanou entitu [UserProfile].
class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  /// Provede aktualizaci profilu voláním repozitáře.
  Future<UserProfile> call(UpdateProfileRequestModel request) async {
    return await _repository.updateProfile(request);
  }
}
