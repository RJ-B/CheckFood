import '../../repositories/auth_repository.dart';

/// UseCase pro potvrzení registrace.
///
/// Slouží k volání API pro ověření (pokud by se nešlo přes DeepLink).
/// Nevrací tokeny, pouze potvrdí úspěšnost ověření.
class VerifyEmailUseCase {
  final AuthRepository _repository;

  VerifyEmailUseCase(this._repository);

  /// Odešle požadavek na ověření na backend.
  Future<void> call(String token) async {
    await _repository.verifyEmail(token);
  }
}
