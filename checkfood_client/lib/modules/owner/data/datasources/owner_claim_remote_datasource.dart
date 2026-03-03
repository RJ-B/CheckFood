import 'package:dio/dio.dart';
import '../../../../security/config/security_endpoints.dart';
import '../models/ares_lookup_response_model.dart';
import '../models/claim_result_response_model.dart';

abstract class OwnerClaimRemoteDataSource {
  Future<AresLookupResponseModel> lookupAres(String ico);
  Future<ClaimResultResponseModel> verifyBankId(String ico);
  Future<ClaimResultResponseModel> startEmailClaim(String ico);
  Future<ClaimResultResponseModel> confirmEmailClaim(String ico, String code);
}

class OwnerClaimRemoteDataSourceImpl implements OwnerClaimRemoteDataSource {
  final Dio _dio;

  OwnerClaimRemoteDataSourceImpl(this._dio);

  @override
  Future<AresLookupResponseModel> lookupAres(String ico) async {
    final response = await _dio.post(
      SecurityEndpoints.ownerClaimAres,
      data: {'ico': ico},
    );
    return AresLookupResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<ClaimResultResponseModel> verifyBankId(String ico) async {
    final response = await _dio.post(
      SecurityEndpoints.ownerClaimBankId,
      data: {'ico': ico},
    );
    return ClaimResultResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<ClaimResultResponseModel> startEmailClaim(String ico) async {
    final response = await _dio.post(
      SecurityEndpoints.ownerClaimEmailStart,
      data: {'ico': ico},
    );
    return ClaimResultResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<ClaimResultResponseModel> confirmEmailClaim(
    String ico,
    String code,
  ) async {
    final response = await _dio.post(
      SecurityEndpoints.ownerClaimEmailConfirm,
      data: {'ico': ico, 'code': code},
    );
    return ClaimResultResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
