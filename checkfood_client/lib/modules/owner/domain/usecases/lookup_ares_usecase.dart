import '../entities/ares_company.dart';
import '../repositories/owner_claim_repository.dart';

/// Vyhledá společnost podle IČO v obchodním rejstříku ARES.
class LookupAresUseCase {
  final OwnerClaimRepository _repository;

  LookupAresUseCase(this._repository);

  Future<AresCompany> call(String ico) async {
    return _repository.lookupAres(ico);
  }
}
