import '../entities/claim_result.dart';
import '../repositories/owner_claim_repository.dart';

/// Potvrdí e-mailem podložené nárokování restaurace odesláním ověřovacího kódu.
class ConfirmEmailClaimUseCase {
  final OwnerClaimRepository _repository;

  ConfirmEmailClaimUseCase(this._repository);

  Future<ClaimResult> call(String ico, String code) async {
    return _repository.confirmEmailClaim(ico, code);
  }
}
