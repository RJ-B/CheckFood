import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// Domain Layer
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

// Data Layer
import '../../exceptions/auth_exceptions.dart';
import '../datasources/auth_remote_data_source.dart';
import '../local/token_storage.dart';
import '../models/auth/request/login_request_model.dart';
import '../models/auth/request/register_request_model.dart';
import '../models/auth/request/verify_email_request_model.dart';
import '../models/auth/request/refresh_token_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  User? _currentUser;

  AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  @override
  Future<AuthTokens> login(LoginRequestModel request) async {
    try {
      final response = await _remoteDataSource.login(request);

      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      _currentUser = response.user.toEntity();
      return response.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při přihlášení: $e');
    }
  }

  @override
  Future<void> register(RegisterRequestModel request) async {
    try {
      await _remoteDataSource.register(request);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při registraci: $e');
    }
  }

  @override
  Future<void> verifyEmail(VerifyEmailRequestModel request) async {
    try {
      await _remoteDataSource.verifyEmail(request);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw AuthServerException('Chyba při verifikaci účtu: $e');
    }
  }

  @override
  Future<void> resendVerificationCode(String email) async {
    try {
      await _remoteDataSource.resendVerificationCode(email);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw AuthServerException('Nepodařilo se znovu odeslat kód: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (e) {
      debugPrint('🔴 [LOGOUT] API volání selhalo: $e');
    } finally {
      await _tokenStorage.clearAuthData();
      _currentUser = null;
    }
  }

  @override
  Future<User?> getAuthenticatedUser() async {
    return _currentUser;
  }

  @override
  Future<AuthTokens> refreshToken(RefreshTokenRequestModel request) async {
    try {
      final response = await _remoteDataSource.refreshToken(request);
      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return response.toEntity();
    } on DioException catch (e) {
      debugPrint('🔴 [REFRESH] Kritické selhání: $e');
      await _tokenStorage.clearAuthData();
      _currentUser = null;
      throw _mapDioException(e);
    } catch (e) {
      throw SessionExpiredException('Vaše sezení vypršelo: $e');
    }
  }

  // --- Mapování chyb ---

  SecurityException _mapDioException(DioException e) {
    String? serverMessage;

    if (e.response?.data != null && e.response?.data is Map) {
      final data = e.response!.data as Map<String, dynamic>;
      serverMessage = data['message'] ?? data['detail'] ?? data['error'];
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const AuthServerException(
        'Server je momentálně nedostupný. Zkontrolujte své připojení.',
      );
    }

    switch (e.response?.statusCode) {
      case 400:
        return AuthServerException(serverMessage ?? 'Neplatný požadavek.');

      case 401:
        return InvalidCredentialsException(
          serverMessage ?? 'Neplatné přihlašovací údaje.',
        );

      case 403:
        if (serverMessage?.toLowerCase().contains('aktivní') ?? false) {
          // Repozitář stále vrací specifickou výjimku, BLoC se pak rozhodne, co s ní
          return AccountNotVerifiedException(serverMessage!);
        }
        return AccountDisabledException(
          serverMessage ?? 'Váš účet byl zablokován nebo deaktivován.',
        );

      case 404:
        return AuthServerException(serverMessage ?? 'Zdroj nenalezen.');

      case 409:
        return EmailAlreadyExistsException(
          serverMessage ?? 'Uživatel s tímto e-mailem již existuje.',
        );

      case 410:
        // ✅ NOVÉ: Ošetření vypršení platnosti (Gone) - např. expirovaný verifikační token
        return AuthServerException(
          serverMessage ??
              'Platnost ověřovacího kódu vypršela. Nechte si zaslat nový.',
        );

      case 500:
        return const AuthServerException(
          'Na serveru došlo k chybě. Zkuste to prosím později.',
        );

      default:
        return AuthServerException(
          serverMessage ?? 'Neočekávaná chyba při komunikaci se serverem.',
        );
    }
  }
}
