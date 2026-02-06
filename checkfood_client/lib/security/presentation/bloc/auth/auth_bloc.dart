import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/auth/get_authenticated_user_usecase.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../domain/usecases/auth/resend_verification_code_usecase.dart';
import '../../../domain/usecases/auth/verify_email_usecase.dart';
import '../../../exceptions/auth_exceptions.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetAuthenticatedUserUseCase _getAuthenticatedUserUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendVerificationCodeUseCase _resendVerificationCodeUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetAuthenticatedUserUseCase getAuthenticatedUserUseCase,
    required VerifyEmailUseCase verifyEmailUseCase,
    required ResendVerificationCodeUseCase resendVerificationCodeUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _getAuthenticatedUserUseCase = getAuthenticatedUserUseCase,
       _verifyEmailUseCase = verifyEmailUseCase,
       _resendVerificationCodeUseCase = resendVerificationCodeUseCase,
       super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        appStarted: (e) => _onAppStarted(e, emit),
        loginRequested: (e) => _onLoginRequested(e, emit),
        registerRequested: (e) => _onRegisterRequested(e, emit),
        verifyEmailRequested: (e) => _onVerifyEmailRequested(e, emit),
        resendCodeRequested: (e) => _onResendCodeRequested(e, emit),
        logoutRequested: (e) => _onLogoutRequested(e, emit),
      );
    });
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final user = await _getAuthenticatedUserUseCase();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _loginUseCase(event.request);
      final user = await _getAuthenticatedUserUseCase();

      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.failure('Chyba: Nepodařilo se načíst profil.'));
      }
    } on AccountNotVerifiedException catch (e) {
      // ✅ NOVÉ: Emitujeme specifický stav pro neověřený účet
      emit(
        AuthState.unverifiedFailure(
          message: e.message,
          email: event.request.email,
          isExpired: false, // Při loginu jde obvykle o "ještě neaktivní" stav
        ),
      );
    } on SecurityException catch (e) {
      // Zde můžeme odchytit i 410 Gone, pokud by ji backend vracel při loginu
      if (e.message.toLowerCase().contains('vypršel')) {
        emit(
          AuthState.unverifiedFailure(
            message: e.message,
            email: event.request.email,
            isExpired: true,
          ),
        );
      } else {
        emit(AuthState.failure(e.message));
      }
    } catch (e) {
      emit(AuthState.failure('Neočekávaná chyba systému: $e'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _registerUseCase(event.request);
      emit(const AuthState.registerSuccess());
    } on SecurityException catch (e) {
      emit(AuthState.failure(e.message));
    } catch (e) {
      emit(AuthState.failure('Chyba při registraci: $e'));
    }
  }

  Future<void> _onVerifyEmailRequested(
    VerifyEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _verifyEmailUseCase(event.request);

      final user = await _getAuthenticatedUserUseCase();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } on SecurityException catch (e) {
      // ✅ NOVÉ: Pokud verifikace selže kvůli expiraci (410), pošleme unverifiedFailure
      if (e.message.toLowerCase().contains('vypršel')) {
        emit(
          AuthState.unverifiedFailure(
            message: e.message,
            email:
                '', // Email zde musíme případně dohledat z kontextu/argumentů
            isExpired: true,
          ),
        );
      } else {
        emit(AuthState.failure(e.message));
      }
    } catch (e) {
      emit(AuthState.failure('Verifikace selhala: $e'));
    }
  }

  Future<void> _onResendCodeRequested(
    ResendCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _resendVerificationCodeUseCase(event.email);
      // Po úspěšném resendu se nic nemění, UI zůstává na verifikačním screenu
    } on SecurityException catch (e) {
      emit(AuthState.failure(e.message));
    } catch (e) {
      emit(AuthState.failure('Nepodařilo se odeslat kód.'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _logoutUseCase();
    } catch (_) {
    } finally {
      emit(const AuthState.unauthenticated());
    }
  }
}
