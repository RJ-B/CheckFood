import '../../../data/models/profile/request/change_password_request_model.dart';
import '../../repositories/profile_repository.dart';

/// UseCase pro změnu hesla uživatele.
///
/// Zapouzdřuje logiku změny přístupových údajů, kde na vstupu
/// očekává [ChangePasswordRequestModel].
class ChangePasswordUseCase {
  final ProfileRepository _repository;

  ChangePasswordUseCase(this._repository);

  /// Provede změnu hesla voláním repozitáře.
  Future<void> call(ChangePasswordRequestModel request) async {
    return await _repository.changePassword(request);
  }
}
