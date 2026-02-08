import 'dart:async';

import '../data/models/auth/request/refresh_token_request_model.dart';
import '../domain/repositories/auth_repository.dart';
import '../data/local/token_storage.dart';

class RefreshTokenManager {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  Completer<String?>? _refreshCompleter;

  RefreshTokenManager(this._authRepository, this._tokenStorage);

  Future<String?> refreshToken() async {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String?>();

    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      // Musíme získat i Device ID, protože model ho vyžaduje
      final deviceId = await _tokenStorage.getDeviceId();

      if (refreshToken == null) {
        _refreshCompleter!.complete(null);
        return null;
      }

      // OPRAVA: Naplníme OBĚ povinná pole
      final requestModel = RefreshTokenRequestModel(
        refreshToken: refreshToken,
        deviceIdentifier: deviceId,
      );

      final newTokens = await _authRepository.refreshToken(requestModel);

      _refreshCompleter!.complete(newTokens.accessToken);
      return newTokens.accessToken;
    } catch (e) {
      await _tokenStorage.clearAuthData();
      _refreshCompleter!.complete(null);
      return null;
    } finally {
      Future.delayed(const Duration(milliseconds: 100), () {
        _refreshCompleter = null;
      });
    }
  }
}
