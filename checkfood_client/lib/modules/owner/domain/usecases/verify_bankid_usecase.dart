import '../entities/claim_result.dart';
import '../repositories/owner_claim_repository.dart';

/// Zahájí ověření identity přes BankID pro dané IČO za účelem nárokování restaurace.
class VerifyBankIdUseCase {
  final OwnerClaimRepository _repository;

  VerifyBankIdUseCase(this._repository);

  Future<ClaimResult> call(String ico) async {
    return _repository.verifyBankId(ico);
  }
}
