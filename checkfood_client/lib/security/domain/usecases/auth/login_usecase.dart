import '../../repositories/auth_repository.dart';
import 'params/auth_params.dart';

/// UseCase pro přihlášení uživatele pomocí emailu a hesla.
///
/// Repozitář zajistí komunikaci s API a uložení tokenů do SecureStorage.
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  /// Provede přihlášení s dodanými [params].
  Future<void> call(LoginParams params) async {
    await _repository.login(params);
  }
}
