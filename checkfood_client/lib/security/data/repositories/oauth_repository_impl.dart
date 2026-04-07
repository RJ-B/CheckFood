import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../config/security_claims.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/user_role.dart';
import '../../domain/repositories/oauth_repository.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../exceptions/oauth_exceptions.dart';
import '../datasources/oauth_remote_data_source.dart';
import '../local/token_storage.dart';
import '../models/auth/response/auth_error_response_model.dart';
import '../models/auth/response/auth_response_model.dart';
import '../models/oauth/request/oauth_login_request_model.dart';
import '../services/device_info_service.dart';

/// Implementace [OAuthRepository] pro přihlášení přes Google a Apple.
///
/// Orchestruje celý OAuth flow: získání ID tokenu od poskytovatele,
/// odeslání na backend a uložení výsledných tokenů do [TokenStorage].
class OAuthRepositoryImpl implements OAuthRepository {
  final OAuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  final DeviceInfoService _deviceInfoService;
  final GoogleSignIn _googleSignIn;

  User? _currentUser;

  OAuthRepositoryImpl({
    required OAuthRemoteDataSource remoteDataSource,
    required TokenStorage tokenStorage,
    required DeviceInfoService deviceInfoService,
  }) : _remoteDataSource = remoteDataSource,
       _tokenStorage = tokenStorage,
       _deviceInfoService = deviceInfoService,
       _googleSignIn = GoogleSignIn(
         serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
         scopes: ['email', 'profile'],
       );

  @override
  Future<User> loginWithGoogle() async {
    try {
      try {
        await _googleSignIn.signOut();
      } catch (_) {}

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw const OAuthCanceledException();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw const OAuthInvalidTokenException(
          'Nepodařilo se získat ID Token od Google.',
        );
      }

      final nameParts = _splitFullName(googleUser.displayName);
      final deviceIdentifier = await _deviceInfoService.getDeviceIdentifier();
      final deviceName = await _deviceInfoService.getDeviceName();
      final deviceType = await _deviceInfoService.getDeviceType();

      final requestModel = OAuthLoginRequestModel(
        idToken: idToken,
        provider: 'GOOGLE',
        email: googleUser.email,
        firstName: nameParts['firstName'] ?? '',
        lastName: nameParts['lastName'] ?? '',
        deviceIdentifier: deviceIdentifier,
        deviceName: deviceName,
        deviceType: deviceType,
      );

      return await _processOAuthResponse(requestModel);
    } on DioException catch (e) {
      throw _mapOAuthDioException(e);
    }
  }

  @override
  Future<User> loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final deviceIdentifier = await _deviceInfoService.getDeviceIdentifier();
      final deviceName = await _deviceInfoService.getDeviceName();
      final deviceType = await _deviceInfoService.getDeviceType();

      final requestModel = OAuthLoginRequestModel(
        idToken: credential.identityToken!,
        provider: 'APPLE',
        email: credential.email ?? '',
        firstName: credential.givenName ?? '',
        lastName: credential.familyName ?? '',
        deviceIdentifier: deviceIdentifier,
        deviceName: deviceName,
        deviceType: deviceType,
      );

      return await _processOAuthResponse(requestModel);
    } on DioException catch (e) {
      throw _mapOAuthDioException(e);
    } catch (e) {
      if (e.toString().contains('Canceled'))
        throw const OAuthCanceledException();
      rethrow;
    }
  }

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

      _currentUser = User(
        id: userId,
        email: userEmail,
        role: role,
        isActive: true,
        permissions: (rolesData is List) ? rolesData.cast<String>() : [],
      );

      return _currentUser;
    } catch (e) {
      return null;
    }
  }

  Future<User> _processOAuthResponse(OAuthLoginRequestModel request) async {
    final AuthResponseModel authResponse = await _remoteDataSource
        .loginWithOAuth(request);

    await _tokenStorage.saveTokens(
      accessToken: authResponse.accessToken,
      refreshToken: authResponse.refreshToken,
    );
    await _tokenStorage.saveDeviceId(request.deviceIdentifier);

    _currentUser = authResponse.user.toEntity();
    return _currentUser!;
  }

  Map<String, String> _splitFullName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return {'firstName': '', 'lastName': ''};
    }
    final parts = fullName.trim().split(' ');
    if (parts.length <= 1) return {'firstName': parts[0], 'lastName': ''};
    return {'firstName': parts.first, 'lastName': parts.sublist(1).join(' ')};
  }

  SecurityException _mapOAuthDioException(DioException e) {
    AuthErrorResponseModel? errorModel;
    if (e.response?.data != null && e.response?.data is Map) {
      try {
        errorModel = AuthErrorResponseModel.fromJson(
          e.response!.data as Map<String, dynamic>,
        );
      } catch (_) {}
    }

    final statusCode = e.response?.statusCode;
    final finalMessage = errorModel?.message ?? 'Chyba sociálního přihlášení.';

    switch (statusCode) {
      case 401:
        return OAuthInvalidTokenException(finalMessage);
      case 403:
        return OAuthAccountDisabledException(finalMessage);
      case 409:
        return OAuthAccountLinkException(finalMessage);
      case 410:
        return AccountNotVerifiedException(errorModel!);
      default:
        return OAuthProviderException(finalMessage, errorModel: errorModel);
    }
  }
}
