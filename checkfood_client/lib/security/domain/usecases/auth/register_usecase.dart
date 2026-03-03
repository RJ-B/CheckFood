import '../../repositories/auth_repository.dart';
import 'params/auth_params.dart';

/// UseCase pro registraci nového uživatele.
///
/// Přijímá [RegisterParams] se všemi potřebnými údaji.
/// Návratový typ je [void], protože backend po registraci nevrací tokeny,
/// ale pouze potvrdí odeslání verifikačního e-mailu.
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  /// Spustí proces registrace voláním repozitáře.
  Future<void> call(RegisterParams params) async {
    await _repository.register(params);
  }
}
