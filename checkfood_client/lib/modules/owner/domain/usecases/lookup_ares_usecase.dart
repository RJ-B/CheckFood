import '../entities/ares_company.dart';
import '../repositories/owner_claim_repository.dart';

/// Looks up a company by its ICO in the ARES business register.
class LookupAresUseCase {
  final OwnerClaimRepository _repository;

  LookupAresUseCase(this._repository);

  Future<AresCompany> call(String ico) async {
    return _repository.lookupAres(ico);
  }
}
