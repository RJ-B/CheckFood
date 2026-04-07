import 'dart:async';
import '../domain/repositories/auth_repository.dart';

/// Manažer pro synchronizovanou obnovu Access Tokenu.
///
/// Pokud vyprší token u více paralelních požadavků, refresh proběhne
/// pouze jednou — ostatní čekají na výsledek prostřednictvím [Completer].
/// Deleguje obnovu na [AuthRepository], který spravuje tokeny i device ID.
class RefreshTokenManager {
  final AuthRepository _authRepository;

  Completer<String?>? _refreshCompleter;

  RefreshTokenManager(this._authRepository);

  /// Obnoví Access Token a vrátí jeho novou hodnotu.
  ///
  /// Pokud obnova selže nebo již probíhá, vrátí `null` — interceptor
  /// pak pošle původní chybu dál a UI zareaguje odhlášením uživatele.
  Future<String?> refreshToken() async {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String?>();

    try {
      final authTokens = await _authRepository.refreshToken();
      final newAccessToken = authTokens.accessToken;
      _refreshCompleter!.complete(newAccessToken);
      return newAccessToken;
    } catch (_) {
      _refreshCompleter!.complete(null);
      return null;
    } finally {
      _refreshCompleter = null;
    }
  }
}
