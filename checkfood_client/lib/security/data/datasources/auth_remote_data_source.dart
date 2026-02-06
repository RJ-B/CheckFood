import 'package:dio/dio.dart';

import '../models/auth/request/login_request_model.dart';
import '../models/auth/request/register_request_model.dart';
import '../models/auth/request/refresh_token_request_model.dart';
import '../models/auth/request/verify_email_request_model.dart';

import '../models/auth/response/auth_response_model.dart';
import '../models/auth/response/token_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<void> register(RegisterRequestModel request);
  Future<void> verifyEmail(VerifyEmailRequestModel request);
  Future<void> resendVerificationCode(String email);
  Future<TokenResponseModel> refreshToken(RefreshTokenRequestModel request);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  static const String _authPath = '/api/auth';

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    final response = await _dio.post(
      '$_authPath/login',
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<void> register(RegisterRequestModel request) async {
    await _dio.post('$_authPath/register', data: request.toJson());
  }

  @override
  Future<void> verifyEmail(VerifyEmailRequestModel request) async {
    // ✅ OPRAVA: Backend používá @GetMapping("/verify") s @RequestParam("token")
    // Proto měníme POST na GET a posíláme token v query parametrech.
    await _dio.get(
      '$_authPath/verify',
      queryParameters: {
        'token':
            request
                .token, // Předpokládám, že VerifyEmailRequestModel má pole 'token'
      },
    );
  }

  @override
  Future<void> resendVerificationCode(String email) async {
    // ✅ KONSTRUKCE: Backend používá @PostMapping("/resend-code") s @RequestBody
    // To odpovídá tvé konstrukci s Mapou, kterou Dio převede na JSON.
    await _dio.post('$_authPath/resend-code', data: {'email': email});
  }

  @override
  Future<TokenResponseModel> refreshToken(
    RefreshTokenRequestModel request,
  ) async {
    final response = await _dio.post(
      '$_authPath/refresh',
      data: request.toJson(),
    );
    return TokenResponseModel.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    await _dio.post('$_authPath/logout');
  }
}
