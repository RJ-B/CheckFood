import '../../repositories/auth_repository.dart';
import 'params/auth_params.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  /// Provede přihlášení.
  /// Repozitář zajistí komunikaci s API a uložení tokenů do SecureStorage.
  Future<void> call(LoginParams params) async {
    await _repository.login(params);
  }
}
