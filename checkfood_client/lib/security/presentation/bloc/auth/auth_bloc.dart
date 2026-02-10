import 'package:flutter_bloc/flutter_bloc.dart';

// Domain Layer - UseCases
import '../../../data/models/auth/response/auth_error_response_model.dart';
import '../../../domain/usecases/auth/get_authenticated_user_usecase.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../domain/usecases/auth/resend_verification_code_usecase.dart';
import '../../../domain/usecases/auth/verify_email_usecase.dart';

// Domain Layer - Exceptions
import '../../../exceptions/auth_exceptions.dart';

// Data Layer - Models

// Bloc Events and States
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

  /// Inicializace aplikace - kontrola, zda je uživatel již přihlášen.
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

  /// Zpracování požadavku na přihlášení.
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
        emit(
          AuthState.failure(
            const AuthErrorResponseModel(
              message: 'Chyba: Nepodařilo se načíst profil uživatele.',
            ),
          ),
        );
      }
    } on AccountNotVerifiedException catch (e) {
      // ✅ Využíváme model přímo z výjimky vyhozené Repozitářem.
      emit(AuthState.failure(e.errorModel!));
    } on SecurityException catch (e) {
      emit(
        AuthState.failure(
          e.errorModel ?? AuthErrorResponseModel(message: e.message),
        ),
      );
    } catch (e) {
      emit(
        AuthState.failure(
          AuthErrorResponseModel(message: 'Neočekávaná chyba systému: $e'),
        ),
      );
    }
  }

  /// Zpracování registrace nového uživatele.
  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _registerUseCase(event.request);
      emit(const AuthState.registerSuccess());
    } on SecurityException catch (e) {
      emit(
        AuthState.failure(
          e.errorModel ?? AuthErrorResponseModel(message: e.message),
        ),
      );
    } catch (e) {
      emit(
        AuthState.failure(
          AuthErrorResponseModel(message: 'Chyba při registraci: $e'),
        ),
      );
    }
  }

  /// Verifikace e-mailu pomocí tokenu (např. z Deep Linku).
  Future<void> _onVerifyEmailRequested(
    VerifyEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _verifyEmailUseCase(event.request);

      // Po úspěšné verifikaci se pokusíme rovnou přihlásit/načíst uživatele.
      final user = await _getAuthenticatedUserUseCase();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        // Pokud tokeny nemáme, pošleme ho na login s úspěšnou hláškou.
        emit(const AuthState.unauthenticated());
      }
    } on AccountNotVerifiedException catch (e) {
      // Token mohl vypršet (410 Gone), vracíme model pro možnost resendu.
      emit(AuthState.failure(e.errorModel!));
    } on SecurityException catch (e) {
      emit(
        AuthState.failure(
          e.errorModel ?? AuthErrorResponseModel(message: e.message),
        ),
      );
    } catch (e) {
      emit(
        AuthState.failure(
          AuthErrorResponseModel(message: 'Verifikace selhala: $e'),
        ),
      );
    }
  }

  /// Znovuzaslání verifikačního kódu/odkazu.
  Future<void> _onResendCodeRequested(
    ResendCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Zde obvykle neemitujeme loading stav celého BLoCu, aby nezmizel formulář.
    // Chybu však zachytit musíme.
    try {
      await _resendVerificationCodeUseCase(event.email);
    } on SecurityException catch (e) {
      emit(
        AuthState.failure(
          e.errorModel ?? AuthErrorResponseModel(message: e.message),
        ),
      );
    } catch (e) {
      emit(
        AuthState.failure(
          const AuthErrorResponseModel(message: 'Nepodařilo se odeslat kód.'),
        ),
      );
    }
  }

  /// Odhlášení uživatele.
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _logoutUseCase();
    } catch (_) {
      // Při logoutu chyby většinou ignorujeme a uživatele prostě odhlásíme lokálně.
    } finally {
      emit(const AuthState.unauthenticated());
    }
  }
}
