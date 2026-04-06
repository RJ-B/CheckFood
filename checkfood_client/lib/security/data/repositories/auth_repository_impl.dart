import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../config/security_claims.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/user_role.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth/params/auth_params.dart';
import '../../exceptions/auth_exceptions.dart';
import '../datasources/auth_remote_data_source.dart';
import '../local/token_storage.dart';

// Request Models
import '../models/auth/request/login_request_model.dart';
import '../models/auth/request/register_request_model.dart';
import '../models/auth/request/verify_email_request_model.dart';
import '../models/auth/request/refresh_token_request_model.dart';
import '../models/auth/request/logout_request_model.dart';
import '../models/auth/request/resend_verification_request_model.dart';
import '../models/auth/request/forgot_password_request_model.dart';
import '../models/auth/request/reset_password_request_model.dart';

// Response Models
import '../models/auth/response/auth_error_response_model.dart';
import '../services/device_info_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  final DeviceInfoService _deviceInfoService;

  User? _currentUser;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorage tokenStorage,
    required DeviceInfoService deviceInfoService,
  }) : _remoteDataSource = remoteDataSource,
       _tokenStorage = tokenStorage,
       _deviceInfoService = deviceInfoService;

  @override
  Future<AuthTokens> login(LoginParams params) async {
    try {
      final deviceIdentifier = await _deviceInfoService.getDeviceIdentifier();
      final deviceName = await _deviceInfoService.getDeviceName();
      final deviceType = await _deviceInfoService.getDeviceType();

      final request = LoginRequestModel(
        email: params.email,
        password: params.password,
        deviceIdentifier: deviceIdentifier,
        deviceName: deviceName,
        deviceType: deviceType,
      );

      final response = await _remoteDataSource.login(request);

      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      await _tokenStorage.saveDeviceId(deviceIdentifier);
      await _tokenStorage.saveNeedsRestaurantClaim(
        response.user.needsRestaurantClaim,
      );
      await _tokenStorage.saveNeedsOnboarding(
        response.user.needsOnboarding,
      );

      _currentUser = response.user.toEntity();
      return response.toEntity();
    } on DioException catch (e) {
      throw _mapDioException(e, emailFallback: params.email);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při přihlášení: $e');
    }
  }

  @override
  Future<void> register(RegisterParams params) async {
    try {
      final request = RegisterRequestModel(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
        ownerRegistration: params.ownerRegistration,
        latitude: params.latitude,
        longitude: params.longitude,
      );

      await _remoteDataSource.register(request);
    } on DioException catch (e) {
      throw _mapDioException(e, emailFallback: params.email);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při registraci: $e');
    }
  }

  @override
  Future<void> registerOwner(RegisterParams params) async {
    try {
      final request = RegisterRequestModel(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
        ownerRegistration: true,
      );

      await _remoteDataSource.registerOwner(request);
    } on DioException catch (e) {
      throw _mapDioException(e, emailFallback: params.email);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při registraci: $e');
    }
  }

  @override
  Future<void> verifyEmail(String token) async {
    try {
      final request = VerifyEmailRequestModel(token: token);
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
      // ✅ OPRAVENO: Nyní správně vytváří model pro DataSource
      final request = ResendVerificationRequestModel(email: email);
      await _remoteDataSource.resendVerificationCode(request);
    } on DioException catch (e) {
      throw _mapDioException(e, emailFallback: email);
    } catch (e) {
      throw AuthServerException('Nepodařilo se znovu odeslat kód: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      final deviceIdentifier = await _deviceInfoService.getDeviceIdentifier();

      if (refreshToken != null) {
        final request = LogoutRequestModel(
          refreshToken: refreshToken,
          deviceIdentifier: deviceIdentifier,
        );
        await _remoteDataSource.logout(request);
      }
    } catch (e) {
      debugPrint('🔴 [LOGOUT] Varování API: $e');
    } finally {
      await _tokenStorage.clearAuthData();
      _currentUser = null;
    }
  }

  @override
  Future<User?> getAuthenticatedUser() async {
    if (_currentUser != null) return _currentUser;

    try {
      final token = await _tokenStorage.getAccessToken();

      if (token == null || JwtDecoder.isExpired(token)) {
        if (token != null) await _tokenStorage.clearAuthData();
        return null;
      }

      final decodedToken = JwtDecoder.decode(token);

      final int userId =
          (decodedToken[SecurityClaims.userId] is int)
              ? decodedToken[SecurityClaims.userId]
              : int.tryParse(
                    decodedToken[SecurityClaims.userId]?.toString() ?? '0',
                  ) ??
                  0;

      final String userEmail =
          decodedToken[SecurityClaims.email] ?? decodedToken['sub'] ?? '';

      UserRole role = UserRole.user;
      final dynamic rolesData = decodedToken[SecurityClaims.roles];

      if (rolesData != null && rolesData is List && rolesData.isNotEmpty) {
        final String rawRole = rolesData.first.toString().replaceAll(
          SecurityClaims.rolePrefix,
          '',
        );
        role = UserRole.fromString(rawRole);
      }

      final needsRestaurantClaim = await _tokenStorage.getNeedsRestaurantClaim();
      final needsOnboarding = await _tokenStorage.getNeedsOnboarding();

      _currentUser = User(
        id: userId,
        email: userEmail,
        role: role,
        isActive: true,
        permissions: (rolesData is List) ? rolesData.map((e) => e.toString()).toList() : [],
        needsRestaurantClaim: needsRestaurantClaim,
        needsOnboarding: needsOnboarding,
      );

      return _currentUser;
    } catch (e) {
      debugPrint('🔴 [REPO] Chyba dekódování tokenu: $e');
      return null;
    }
  }

  @override
  Future<AuthTokens> refreshToken() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      final deviceIdentifier = await _tokenStorage.getDeviceId();

      if (refreshToken == null || deviceIdentifier == null) {
        throw const SessionExpiredException(
          'Chybějící údaje pro obnovení sezení.',
        );
      }

      final request = RefreshTokenRequestModel(
        refreshToken: refreshToken,
        deviceIdentifier: deviceIdentifier,
      );

      final response = await _remoteDataSource.refreshToken(request);

      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return response.toEntity();
    } catch (e) {
      await _tokenStorage.clearAuthData();
      _currentUser = null;
      throw const SessionExpiredException(
        'Sezení vypršelo, přihlaste se znovu.',
      );
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final request = ForgotPasswordRequestModel(email: email);
      await _remoteDataSource.forgotPassword(request);
    } on DioException catch (e) {
      throw _mapDioException(e, emailFallback: email);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při odesílání žádosti: $e');
    }
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    try {
      final request = ResetPasswordRequestModel(
        token: token,
        newPassword: newPassword,
      );
      await _remoteDataSource.resetPassword(request);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw AuthServerException('Neočekávaná chyba při obnově hesla: $e');
    }
  }

  SecurityException _mapDioException(DioException e, {String? emailFallback}) {
    AuthErrorResponseModel? errorModel;

    if (e.response?.data != null && e.response?.data is Map) {
      try {
        errorModel = AuthErrorResponseModel.fromJson(
          e.response!.data as Map<String, dynamic>,
        );
        if ((errorModel.email == null || errorModel.email!.isEmpty) &&
            emailFallback != null) {
          errorModel = errorModel.copyWith(email: emailFallback);
        }
      } catch (_) {}
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return AuthServerException(
        'Server je nedostupný.',
        errorModel: errorModel,
      );
    }

    final statusCode = e.response?.statusCode;
    final finalMessage = errorModel?.message ?? 'Neočekávaná chyba serveru.';

    // Backend error code (e.g. AUTH_ACCOUNT_NOT_VERIFIED, AUTH_ACCOUNT_DISABLED)
    final rawCode = (e.response?.data is Map)
        ? (e.response!.data as Map<String, dynamic>)['code']?.toString()
        : null;

    switch (statusCode) {
      case 401:
        return InvalidCredentialsException(finalMessage);
      case 403:
        if (rawCode == 'AUTH_ACCOUNT_NOT_VERIFIED') {
          return AccountNotVerifiedException(
            errorModel ??
                AuthErrorResponseModel(
                  message: finalMessage,
                  email: emailFallback,
                ),
          );
        }
        return AccountDisabledException(finalMessage);
      case 409:
        return EmailAlreadyExistsException(finalMessage);
      case 410:
        return AccountNotVerifiedException(
          errorModel?.copyWith(isExpired: true) ??
              AuthErrorResponseModel(
                message: finalMessage,
                email: emailFallback,
                isExpired: true,
              ),
        );
      case 429:
        return AuthServerException(
          'Příliš mnoho pokusů. Zkuste to později.',
          errorModel: errorModel,
        );
      default:
        return AuthServerException(finalMessage, errorModel: errorModel);
    }
  }
}
