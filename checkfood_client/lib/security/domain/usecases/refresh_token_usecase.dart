import '../../data/models/auth/request/refresh_token_request_model.dart';
import '../entities/auth_tokens.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  // UseCase nyní musí přijmout i deviceIdentifier, aby mohl sestavit model
  Future<AuthTokens> call(String refreshToken, String deviceIdentifier) async {
    final requestModel = RefreshTokenRequestModel(
      refreshToken: refreshToken,
      deviceIdentifier: deviceIdentifier,
    );

    return await _repository.refreshToken(requestModel);
  }
}
