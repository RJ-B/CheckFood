import 'package:flutter_bloc/flutter_bloc.dart';

// Domain Layer - Entities
import '../../../domain/entities/auth_failure.dart';

// Domain Layer - UseCases
import '../../../domain/usecases/auth/check_auth_status_usecase.dart';
import '../../../domain/usecases/auth/get_authenticated_user_usecase.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../domain/usecases/auth/register_owner_usecase.dart';
import '../../../domain/usecases/auth/resend_verification_code_usecase.dart';
import '../../../domain/usecases/auth/verify_email_usecase.dart';
import '../../../domain/usecases/oauth/login_with_apple_usecase.dart';
import '../../../domain/usecases/oauth/login_with_google_usecase.dart';

// Domain Layer - Exceptions
import '../../../exceptions/auth_exceptions.dart';

// Events and States
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC zodpovědný za řízení stavu autentizace v aplikaci.
/// Implementuje striktní Clean Architecture (Cesta A).
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final RegisterOwnerUseCase _registerOwnerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetAuthenticatedUserUseCase _getAuthenticatedUserUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendVerificationCodeUseCase _resendVerificationCodeUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  final LoginWithAppleUseCase _loginWithAppleUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required RegisterOwnerUseCase registerOwnerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetAuthenticatedUserUseCase getAuthenticatedUserUseCase,
    required VerifyEmailUseCase verifyEmailUseCase,
    required ResendVerificationCodeUseCase resendVerificationCodeUseCase,
    required LoginWithGoogleUseCase loginWithGoogleUseCase,
    required LoginWithAppleUseCase loginWithAppleUseCase,
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _registerOwnerUseCase = registerOwnerUseCase,
       _logoutUseCase = logoutUseCase,
       _getAuthenticatedUserUseCase = getAuthenticatedUserUseCase,
       _verifyEmailUseCase = verifyEmailUseCase,
       _resendVerificationCodeUseCase = resendVerificationCodeUseCase,
       _loginWithGoogleUseCase = loginWithGoogleUseCase,
       _loginWithAppleUseCase = loginWithAppleUseCase,
       _checkAuthStatusUseCase = checkAuthStatusUseCase,
       super(const AuthState.initial()) {
    // Registrace handlerů pro jednotlivé události
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<RegisterOwnerRequested>(_onRegisterOwnerRequested);
    on<VerifyEmailRequested>(_onVerifyEmailRequested);
    on<ResendCodeRequested>(_onResendCodeRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<AppleLoginRequested>(_onAppleLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// 🟢 INITIALIZATION
  /// Kontroluje, zda je uživatel již přihlášen (např. při restartu aplikace).
  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final user = await _checkAuthStatusUseCase();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }

  /// 🔵 LOGIN (Email/Password)
  /// Provádí přihlášení a následně načítá plný profil uživatele.
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _loginUseCase(event.params);
      final user = await _getAuthenticatedUserUseCase();

      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(
          AuthState.failure(
            const AuthFailure(
              message: 'Chyba při načítání uživatelského profilu.',
            ),
          ),
        );
      }
    } on AccountNotVerifiedException catch (e) {
      // Speciální stav, kdy backend vyžaduje verifikaci emailu
      emit(AuthState.verificationRequired(e.errorModel?.email ?? ''));
    } on SecurityException catch (e) {
      emit(AuthState.failure(_mapExceptionToFailure(e)));
    } catch (e) {
      emit(
        AuthState.failure(
          const AuthFailure(message: 'Neočekávaná chyba serveru.'),
        ),
      );
    }
  }

  /// 🟣 REGISTER
  /// Vytvoří nový účet a přepne UI do stavu úspěšné registrace.
  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _registerUseCase(event.params);
      emit(const AuthState.registerSuccess());
    } on SecurityException catch (e) {
      emit(AuthState.failure(_mapExceptionToFailure(e)));
    } catch (e) {
      emit(
        AuthState.failure(const AuthFailure(message: 'Registrace selhala.')),
      );
    }
  }

  /// REGISTER OWNER
  Future<void> _onRegisterOwnerRequested(
    RegisterOwnerRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _registerOwnerUseCase(event.params);
      emit(const AuthState.registerSuccess());
    } on SecurityException catch (e) {
      emit(AuthState.failure(_mapExceptionToFailure(e)));
    } catch (e) {
      emit(
        AuthState.failure(const AuthFailure(message: 'Registrace selhala.')),
      );
    }
  }

  /// 🟠 EMAIL VERIFICATION
  /// Potvrdí účet pomocí tokenu z emailu.
  Future<void> _onVerifyEmailRequested(
    VerifyEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _verifyEmailUseCase(event.token);
      emit(
        const AuthState.unauthenticated(),
      ); // Po verifikaci se uživatel musí přihlásit
    } on SecurityException catch (e) {
      emit(AuthState.failure(_mapExceptionToFailure(e)));
    } catch (e) {
      emit(
        AuthState.failure(const AuthFailure(message: 'Verifikace selhala.')),
      );
    }
  }

  /// 🟡 RESEND VERIFICATION CODE
  /// Požádá backend o nové zaslání verifikačního emailu.
  Future<void> _onResendCodeRequested(
    ResendCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _resendVerificationCodeUseCase(event.email);
      // Zde obvykle neměníme stav na loading, aby se zachoval kontext formuláře v UI
    } on SecurityException catch (e) {
      emit(AuthState.failure(_mapExceptionToFailure(e)));
    }
  }

  /// 🔵 GOOGLE OAUTH
  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await _loginWithGoogleUseCase();
      emit(AuthState.authenticated(user));
    } on SecurityException catch (e) {
      emit(AuthState.failure(_mapExceptionToFailure(e)));
    } catch (e) {
      emit(
        AuthState.failure(const AuthFailure(message: 'Google login selhal.')),
      );
    }
  }

  /// ⚪ APPLE OAUTH
  Future<void> _onAppleLoginRequested(
    AppleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user =
          await _loginWithAppleUseCase();
      emit(AuthState.authenticated(user));
    } on SecurityException catch (e) {
      emit(AuthState.failure(_mapExceptionToFailure(e)));
    } catch (e) {
      emit(
        AuthState.failure(const AuthFailure(message: 'Apple login selhal.')),
      );
    }
  }

  /// 🔴 LOGOUT
  /// Zruší sezení na backendu i lokálně.
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _logoutUseCase();
    } finally {
      // Vždy emitujeme unauthenticated, i když síťové volání selže
      emit(const AuthState.unauthenticated());
    }
  }

  /// Pomocná interní metoda pro převod technických výjimek na doménové entity chyb.
  AuthFailure _mapExceptionToFailure(SecurityException e) {
    return AuthFailure(
      message: e.message,
      email: e.errorModel?.email,
      isExpired: e.errorModel?.message.contains('expired') ?? false,
    );
  }
}
