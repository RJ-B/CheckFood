import '../../repositories/auth_repository.dart';
import 'params/auth_params.dart';

/// UseCase pro registraci majitele restaurace (role OWNER).
class RegisterOwnerUseCase {
  final AuthRepository _repository;

  RegisterOwnerUseCase(this._repository);

  Future<void> call(RegisterParams params) async {
    await _repository.registerOwner(params);
  }
}
