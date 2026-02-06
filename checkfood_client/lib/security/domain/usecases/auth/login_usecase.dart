import '../../../data/models/auth/request/login_request_model.dart';
import '../../entities/auth_tokens.dart';
import '../../repositories/auth_repository.dart';

/// UseCase pro autentizaci uživatele do systému.
///
/// Zapouzdřuje logiku přihlášení, kde na vstupu očekává [LoginRequestModel]
/// a po úspěšném ověření vrací entitu [AuthTokens].
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  /// Spustí proces přihlášení voláním repozitáře.
  Future<AuthTokens> call(LoginRequestModel request) async {
    return await _repository.login(request);
  }
}
