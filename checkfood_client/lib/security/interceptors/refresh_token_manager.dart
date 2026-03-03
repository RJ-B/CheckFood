import 'dart:async';
import '../domain/repositories/auth_repository.dart';

/**
 * Manažer pro synchronizovanou obnovu Access Tokenu.
 * Zajišťuje, že pokud vyprší token u více paralelních požadavků,
 * refresh proběhne pouze jednou skrze AuthRepository.
 */
class RefreshTokenManager {
  final AuthRepository _authRepository;

  // Completer slouží k synchronizaci paralelních volání
  Completer<String?>? _refreshCompleter;

  RefreshTokenManager(this._authRepository);

  /// Hlavní metoda pro získání nového Access Tokenu.
  Future<String?> refreshToken() async {
    // 1. Pokud již refresh probíhá, nezačínáme nový, ale čekáme na výsledek rozpracovaného
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String?>();

    try {
      // 2. Delegujeme odpovědnost na Repozitář.
      // Repozitář si sám vytáhne Refresh Token i Device ID a provede volání na API.
      final authTokens = await _authRepository.refreshToken();

      // 3. Po úspěšném refreshi vrátíme nový Access Token všem čekajícím požadavkům
      final newAccessToken = authTokens.accessToken;
      _refreshCompleter!.complete(newAccessToken);

      return newAccessToken;
    } catch (e) {
      // 4. Pokud refresh selže, repozitář již vyčistil auth data.
      // Vrátíme null, což Interceptoru řekne, že má uživatele odhlásit.
      _refreshCompleter!.complete(null);

      return null;
    } finally {
      // 5. Uvolníme completer pro budoucí potřebu (např. po příštím přihlášení)
      _refreshCompleter = null;
    }
  }
}
