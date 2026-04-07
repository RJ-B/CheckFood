import '../entities/claim_result.dart';
import '../repositories/owner_claim_repository.dart';

/// Initiates BankID identity verification for a given ICO to claim a restaurant.
class VerifyBankIdUseCase {
  final OwnerClaimRepository _repository;

  VerifyBankIdUseCase(this._repository);

  Future<ClaimResult> call(String ico) async {
    return _repository.verifyBankId(ico);
  }
}
