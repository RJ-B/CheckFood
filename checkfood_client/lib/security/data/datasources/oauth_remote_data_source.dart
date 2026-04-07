import 'package:dio/dio.dart';
import '../../config/security_endpoints.dart';
import '../models/oauth/request/oauth_login_request_model.dart';
import '../models/auth/response/auth_response_model.dart';

/// Abstraktní kontrakt pro vzdálený zdroj dat OAuth přihlašování.
abstract class OAuthRemoteDataSource {
  Future<AuthResponseModel> loginWithOAuth(OAuthLoginRequestModel request);
}

/// Implementace [OAuthRemoteDataSource] komunikující s backendem přes [Dio].
class OAuthRemoteDataSourceImpl implements OAuthRemoteDataSource {
  final Dio _dio;

  OAuthRemoteDataSourceImpl(this._dio);

  @override
  Future<AuthResponseModel> loginWithOAuth(
    OAuthLoginRequestModel request,
  ) async {
    final response = await _dio.post(
      SecurityEndpoints.oauthLogin,
      data: request.toJson(),
    );

    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}
