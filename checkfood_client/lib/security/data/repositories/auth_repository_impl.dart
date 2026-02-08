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
import '../models/auth/response/auth_error_response_model.dart'; // ✅ Import modelu

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
      // ✅ Předáváme email z requestu pro případ, že ho backend nevrátí v JSONu
      throw _mapDioException(e, emailFallback: request.email);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při přihlášení: $e');
    }
  }

  @override
  Future<void> register(RegisterRequestModel request) async {
    try {
      await _remoteDataSource.register(request);
    } on DioException catch (e) {
      throw _mapDioException(e, emailFallback: request.email);
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
      throw _mapDioException(e, emailFallback: email);
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

  // --- Mapování chyb (Čistá verze) ---

  SecurityException _mapDioException(DioException e, {String? emailFallback}) {
    AuthErrorResponseModel? errorModel;

    // 1. Extrakce dat ze serveru do našeho Response modelu
    if (e.response?.data != null && e.response?.data is Map) {
      try {
        errorModel = AuthErrorResponseModel.fromJson(
          e.response!.data as Map<String, dynamic>,
        );

        // Pokud v JSONu chybí email, doplníme ten, se kterým uživatel pracoval
        if (errorModel.email == null || errorModel.email!.isEmpty) {
          errorModel = errorModel.copyWith(email: emailFallback);
        }
      } catch (_) {
        // Fallback pro případ špatného formátu JSONu
        errorModel = AuthErrorResponseModel(
          message: 'Chyba formátu odpovědi serveru.',
          email: emailFallback,
        );
      }
    }

    // 2. Ošetření síťových chyb (Timeout atd.)
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return AuthServerException(
        'Server je momentálně nedostupný. Zkontrolujte připojení.',
        errorModel: AuthErrorResponseModel(
          message: 'Network error',
          email: emailFallback,
        ),
      );
    }

    final statusCode = e.response?.statusCode;
    final finalMessage = errorModel?.message ?? 'Neočekávaná chyba serveru.';

    // 3. Rozlišení chyb podle HTTP kódu
    switch (statusCode) {
      case 400:
        return AuthServerException(finalMessage, errorModel: errorModel);

      case 401:
        return InvalidCredentialsException(finalMessage);

      case 403:
        // Pokud zpráva obsahuje "aktivní", jde o neověřený účet
        if (finalMessage.toLowerCase().contains('aktivní')) {
          return AccountNotVerifiedException(errorModel!);
        }
        return AccountDisabledException(finalMessage);

      case 409:
        return EmailAlreadyExistsException(finalMessage);

      case 410:
        // Gone = Expirovaný token. Nastavíme isExpired na true pro UI.
        return AccountNotVerifiedException(
          errorModel?.copyWith(isExpired: true) ??
              AuthErrorResponseModel(
                message: finalMessage,
                email: emailFallback,
                isExpired: true,
              ),
        );

      case 500:
        return const AuthServerException('Chyba na straně serveru (500).');

      default:
        return AuthServerException(finalMessage, errorModel: errorModel);
    }
  }
}
