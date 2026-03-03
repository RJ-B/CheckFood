import '../entities/auth_tokens.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  /// Obnoví token. Repozitář si interně načte refresh token i device ID.
  Future<AuthTokens> call() async {
    return await _repository.refreshToken();
  }
}
