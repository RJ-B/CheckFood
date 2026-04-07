import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/lookup_ares_usecase.dart';
import '../../domain/usecases/verify_bankid_usecase.dart';
import '../../domain/usecases/start_email_claim_usecase.dart';
import '../../domain/usecases/confirm_email_claim_usecase.dart';
import 'owner_claim_event.dart';
import 'owner_claim_state.dart';

/// BLoC that drives the restaurant claim flow: ARES lookup, BankID verification,
/// and email-code based claim with confirmation.
class OwnerClaimBloc extends Bloc<OwnerClaimEvent, OwnerClaimState> {
  final LookupAresUseCase _lookupAresUseCase;
  final VerifyBankIdUseCase _verifyBankIdUseCase;
  final StartEmailClaimUseCase _startEmailClaimUseCase;
  final ConfirmEmailClaimUseCase _confirmEmailClaimUseCase;

  OwnerClaimBloc({
    required LookupAresUseCase lookupAresUseCase,
    required VerifyBankIdUseCase verifyBankIdUseCase,
    required StartEmailClaimUseCase startEmailClaimUseCase,
    required ConfirmEmailClaimUseCase confirmEmailClaimUseCase,
  })  : _lookupAresUseCase = lookupAresUseCase,
        _verifyBankIdUseCase = verifyBankIdUseCase,
        _startEmailClaimUseCase = startEmailClaimUseCase,
        _confirmEmailClaimUseCase = confirmEmailClaimUseCase,
        super(const OwnerClaimState()) {
    on<LookupAres>(_onLookupAres);
    on<VerifyBankId>(_onVerifyBankId);
    on<StartEmailClaim>(_onStartEmailClaim);
    on<ConfirmEmailCode>(_onConfirmEmailCode);
  }

  Future<void> _onLookupAres(
    LookupAres event,
    Emitter<OwnerClaimState> emit,
  ) async {
    emit(state.copyWith(loading: true, aresError: null));
    try {
      final company = await _lookupAresUseCase(event.ico);
      emit(state.copyWith(loading: false, aresCompany: company));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        aresError: 'Nepodařilo se vyhledat firmu v ARES.',
      ));
    }
  }

  Future<void> _onVerifyBankId(
    VerifyBankId event,
    Emitter<OwnerClaimState> emit,
  ) async {
    final ico = state.aresCompany?.ico;
    if (ico == null) return;

    emit(state.copyWith(bankIdVerifying: true, claimError: null));
    try {
      final result = await _verifyBankIdUseCase(ico);
      emit(state.copyWith(
        bankIdVerifying: false,
        claimResult: result,
        claimSuccess: result.membershipCreated,
      ));
    } catch (e) {
      emit(state.copyWith(
        bankIdVerifying: false,
        claimError: 'Chyba při ověřování identity.',
      ));
    }
  }

  Future<void> _onStartEmailClaim(
    StartEmailClaim event,
    Emitter<OwnerClaimState> emit,
  ) async {
    final ico = state.aresCompany?.ico;
    if (ico == null) return;

    emit(state.copyWith(emailSending: true, claimError: null));
    try {
      final result = await _startEmailClaimUseCase(ico);
      emit(state.copyWith(
        emailSending: false,
        emailCodeSent: true,
        claimResult: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        emailSending: false,
        claimError: 'Nepodařilo se odeslat ověřovací kód.',
      ));
    }
  }

  Future<void> _onConfirmEmailCode(
    ConfirmEmailCode event,
    Emitter<OwnerClaimState> emit,
  ) async {
    final ico = state.aresCompany?.ico;
    if (ico == null) return;

    emit(state.copyWith(emailConfirming: true, claimError: null));
    try {
      final result = await _confirmEmailClaimUseCase(ico, event.code);
      emit(state.copyWith(
        emailConfirming: false,
        claimResult: result,
        claimSuccess: result.membershipCreated,
      ));
    } catch (e) {
      emit(state.copyWith(
        emailConfirming: false,
        claimError: 'Neplatný nebo vypršený kód.',
      ));
    }
  }
}
