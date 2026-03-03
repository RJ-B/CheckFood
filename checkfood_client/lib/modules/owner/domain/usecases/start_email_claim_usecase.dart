import '../entities/claim_result.dart';
import '../repositories/owner_claim_repository.dart';

class StartEmailClaimUseCase {
  final OwnerClaimRepository _repository;

  StartEmailClaimUseCase(this._repository);

  Future<ClaimResult> call(String ico) async {
    return _repository.startEmailClaim(ico);
  }
}
