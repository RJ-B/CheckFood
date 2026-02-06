import '../../repositories/auth_repository.dart';

/// UseCase pro opětovné vyžádání verifikačního kódu.
class ResendVerificationCodeUseCase {
  final AuthRepository _repository;

  ResendVerificationCodeUseCase(this._repository);

  /// Vyžádá nový kód pro zadaný [email].
  Future<void> call(String email) async {
    return await _repository.resendVerificationCode(email);
  }
}
