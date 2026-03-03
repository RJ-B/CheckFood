import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_claim_event.freezed.dart';

@freezed
class OwnerClaimEvent with _$OwnerClaimEvent {
  const factory OwnerClaimEvent.lookupAres({required String ico}) = LookupAres;
  const factory OwnerClaimEvent.verifyBankId() = VerifyBankId;
  const factory OwnerClaimEvent.startEmailClaim() = StartEmailClaim;
  const factory OwnerClaimEvent.confirmEmailCode({required String code}) =
      ConfirmEmailCode;
}
