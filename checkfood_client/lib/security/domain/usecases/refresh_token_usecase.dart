import '../entities/auth_tokens.dart';
import '../repositories/auth_repository.dart';

/// UseCase pro obnovení přístupového tokenu pomocí refresh tokenu.
///
/// Repozitář si interně načte refresh token i identifikátor zařízení.
class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  /// Provede obnovu tokenu a vrátí nové [AuthTokens].
  Future<AuthTokens> call() async {
    return await _repository.refreshToken();
  }
}
