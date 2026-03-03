import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../data/local/token_storage.dart';
import 'refresh_token_manager.dart';

/// Interceptor přidávající Bearer token a řešící jeho automatickou obnovu.
class AuthInterceptor extends QueuedInterceptor {
  // Používáme TokenStorage místo SecureStorageService pro konzistenci klíčů
  final TokenStorage _storage;
  final RefreshTokenManager _tokenManager;
  final Dio _dio;

  AuthInterceptor(this._storage, this._tokenManager, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Bezpečnostní pojistka:
    // I když máme oddělené Dio instance, ujistíme se, že pokud bychom omylem
    // použili hlavní Dio na refresh endpoint, nepřidáme tam starý Access Token.
    if (options.path.contains('/api/auth/refresh')) {
      return handler.next(options);
    }

    // (Poznámka: Login a Register zde nemusíme řešit, protože ty jdou přes 'dioAuth',
    // který tento interceptor vůbec nemá.)

    // 2. Pro ostatní requesty načteme aktuální token
    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Reagujeme pouze na chybu 401 (Unauthorized)
    if (err.response?.statusCode == 401) {
      final RequestOptions options = err.requestOptions;

      // KDYBY náhodou refresh token sám o sobě vrátil 401,
      // nesmíme se pokoušet o další refresh (nekonečná smyčka).
      // Manager už v tomto případě vyčistil storage.
      if (options.path.contains('/refresh')) {
        return handler.next(err);
      }

      debugPrint('[Interceptor] 401 zachyceno. Spouštím refresh proces...');

      try {
        // Pokus o obnovu tokenu přes Manager (řeší zámky a Device ID)
        final newToken = await _tokenManager.refreshToken();

        if (newToken != null) {
          debugPrint('[Interceptor] Token obnoven. Opakuji původní požadavek.');

          // Vytvoříme novou konfiguraci s novým tokenem
          final opts = Options(
            method: options.method,
            headers: options.headers,
          );

          // Aktualizujeme hlavičku Authorization
          opts.headers?['Authorization'] = 'Bearer $newToken';

          // Zopakujeme původní request
          // Pozor: Používáme _dio.request místo fetch pro lepší kontrolu nad options
          final response = await _dio.request(
            options.path,
            options: opts,
            data: options.data,
            queryParameters: options.queryParameters,
          );

          return handler.resolve(response);
        }
      } catch (e) {
        debugPrint('[Interceptor] Chyba při obnově nebo opakování requestu: $e');
        // Pokud se to nepovede, pošleme původní chybu dál (UI zareaguje logoutem)
        return handler.next(err);
      }
    }

    return handler.next(err);
  }
}
