import '../entities/claim_result.dart';
import '../repositories/owner_claim_repository.dart';

/// Spustí e-mailový proces nárokování restaurace identifikované IČO
/// a odešle ověřovací kód na registrovaný kontaktní e-mail.
class StartEmailClaimUseCase {
  final OwnerClaimRepository _repository;

  StartEmailClaimUseCase(this._repository);

  Future<ClaimResult> call(String ico) async {
    return _repository.startEmailClaim(ico);
  }
}
