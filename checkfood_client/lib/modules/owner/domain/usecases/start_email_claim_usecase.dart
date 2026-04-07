import '../entities/claim_result.dart';
import '../repositories/owner_claim_repository.dart';

/// Starts an email-based claim flow for a restaurant identified by ICO,
/// sending a verification code to the registered contact email.
class StartEmailClaimUseCase {
  final OwnerClaimRepository _repository;

  StartEmailClaimUseCase(this._repository);

  Future<ClaimResult> call(String ico) async {
    return _repository.startEmailClaim(ico);
  }
}
