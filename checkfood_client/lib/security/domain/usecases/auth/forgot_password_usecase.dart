import '../../repositories/auth_repository.dart';

/// UseCase pro zahájení procesu obnovy hesla.
///
/// Odešle požadavek na backend, který zašle uživateli email s resetovacím odkazem.
class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<void> call(String email) async {
    await _repository.forgotPassword(email);
  }
}
