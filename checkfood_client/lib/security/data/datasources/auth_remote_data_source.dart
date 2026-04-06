import 'package:dio/dio.dart';
import '../../config/security_endpoints.dart';

// Request Models
import '../models/auth/request/login_request_model.dart';
import '../models/auth/request/register_request_model.dart';
import '../models/auth/request/refresh_token_request_model.dart';
import '../models/auth/request/verify_email_request_model.dart';
import '../models/auth/request/logout_request_model.dart';
import '../models/auth/request/resend_verification_request_model.dart';
import '../models/auth/request/forgot_password_request_model.dart';
import '../models/auth/request/reset_password_request_model.dart';

// Response Models
import '../models/auth/response/auth_response_model.dart';
import '../models/auth/response/token_response_model.dart';

/// Rozhraní pro vzdálený zdroj dat autentizace.
/// V Cestě A každá metoda striktně vyžaduje svůj Request Model.
abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<void> register(RegisterRequestModel request);
  Future<void> registerOwner(RegisterRequestModel request);
  Future<void> verifyEmail(VerifyEmailRequestModel request);
  Future<void> resendVerificationCode(ResendVerificationRequestModel request);
  Future<TokenResponseModel> refreshToken(RefreshTokenRequestModel request);
  Future<void> logout(LogoutRequestModel request);
  Future<void> forgotPassword(ForgotPasswordRequestModel request);
  Future<void> resetPassword(ResetPasswordRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    final response = await _dio.post(
      SecurityEndpoints.login,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<void> register(RegisterRequestModel request) async {
    await _dio.post(SecurityEndpoints.register, data: request.toJson());
  }

  @override
  Future<void> registerOwner(RegisterRequestModel request) async {
    await _dio.post(SecurityEndpoints.registerOwner, data: request.toJson());
  }

  @override
  Future<void> verifyEmail(VerifyEmailRequestModel request) async {
    // GET požadavek s tokenem v query parametrech
    await _dio.get(
      SecurityEndpoints.verifyEmail,
      queryParameters: {'token': request.token},
    );
  }

  @override
  Future<void> resendVerificationCode(
    ResendVerificationRequestModel request,
  ) async {
    await _dio.post(
      SecurityEndpoints.resendVerification,
      data: request.toJson(),
    );
  }

  @override
  Future<TokenResponseModel> refreshToken(
    RefreshTokenRequestModel request,
  ) async {
    final response = await _dio.post(
      SecurityEndpoints.refreshToken,
      data: request.toJson(),
    );
    return TokenResponseModel.fromJson(response.data);
  }

  @override
  Future<void> logout(LogoutRequestModel request) async {
    await _dio.post(SecurityEndpoints.logout, data: request.toJson());
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequestModel request) async {
    await _dio.post(SecurityEndpoints.forgotPassword, data: request.toJson());
  }

  @override
  Future<void> resetPassword(ResetPasswordRequestModel request) async {
    await _dio.post(SecurityEndpoints.resetPassword, data: request.toJson());
  }
}
