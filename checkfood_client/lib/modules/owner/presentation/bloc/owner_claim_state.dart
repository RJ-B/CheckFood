import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/ares_company.dart';
import '../../domain/entities/claim_result.dart';

part 'owner_claim_state.freezed.dart';

@freezed
class OwnerClaimState with _$OwnerClaimState {
  const factory OwnerClaimState({
    @Default(false) bool loading,
    AresCompany? aresCompany,
    String? aresError,
    @Default(false) bool bankIdVerifying,
    ClaimResult? claimResult,
    String? claimError,
    @Default(false) bool emailSending,
    @Default(false) bool emailCodeSent,
    @Default(false) bool emailConfirming,
    @Default(false) bool claimSuccess,
  }) = _OwnerClaimState;
}
