import '../entities/ares_company.dart';
import '../entities/claim_result.dart';

abstract class OwnerClaimRepository {
  Future<AresCompany> lookupAres(String ico);
  Future<ClaimResult> verifyBankId(String ico);
  Future<ClaimResult> startEmailClaim(String ico);
  Future<ClaimResult> confirmEmailClaim(String ico, String code);
}
