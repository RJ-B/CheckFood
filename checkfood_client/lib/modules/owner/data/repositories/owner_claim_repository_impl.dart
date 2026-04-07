import '../../domain/entities/ares_company.dart';
import '../../domain/entities/claim_result.dart';
import '../../domain/repositories/owner_claim_repository.dart';
import '../datasources/owner_claim_remote_datasource.dart';

/// Repository implementation that delegates to [OwnerClaimRemoteDataSource]
/// and maps response models to domain entities.
class OwnerClaimRepositoryImpl implements OwnerClaimRepository {
  final OwnerClaimRemoteDataSource _remoteDataSource;

  OwnerClaimRepositoryImpl(this._remoteDataSource);

  @override
  Future<AresCompany> lookupAres(String ico) async {
    final response = await _remoteDataSource.lookupAres(ico);
    return response.toEntity();
  }

  @override
  Future<ClaimResult> verifyBankId(String ico) async {
    final response = await _remoteDataSource.verifyBankId(ico);
    return response.toEntity();
  }

  @override
  Future<ClaimResult> startEmailClaim(String ico) async {
    final response = await _remoteDataSource.startEmailClaim(ico);
    return response.toEntity();
  }

  @override
  Future<ClaimResult> confirmEmailClaim(String ico, String code) async {
    final response = await _remoteDataSource.confirmEmailClaim(ico, code);
    return response.toEntity();
  }
}
