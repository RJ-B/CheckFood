import '../../../data/models/auth/request/register_request_model.dart';
import '../../repositories/auth_repository.dart';

/// UseCase pro registraci nového uživatele.
///
/// Přijímá [RegisterRequestModel] se všemi potřebnými údaji.
/// Návratový typ je [void], protože backend po registraci nevrací tokeny,
/// ale pouze potvrdí odeslání verifikačního e-mailu.
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  /// Spustí proces registrace voláním repozitáře.
  Future<void> call(RegisterRequestModel request) async {
    await _repository.register(request);
  }
}
