import '../../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<void> call({required String token, required String newPassword}) async {
    await _repository.resetPassword(token, newPassword);
  }
}
