# CHANGELOG

Starší záznamy (T-0001 až T-0009) vyčištěny — viz git historii.

---

2026-04-07 | Tester | T-0010
Implementován kompletní forgot password flow. Backend: PasswordResetTokenEntity, PasswordResetTokenRepository, ForgotPasswordRequest/ResetPasswordRequest DTOs, rozšíření AuthErrorCode/AuthException/EmailService/AuthServiceImpl/AuthLogger/AuthController/SecurityConfig. Frontend: ForgotPasswordUseCase, ResetPasswordUseCase, request modely, AuthBloc handlery + nové eventy/stavy (Freezed), ForgotPasswordPage, ResetPasswordPage, routy v AppRouter, DI registrace, navigace z LoginForm, error kódy v LoginPage. Backend compile OK, testy OK (pre-existing failures nezměněny). Flutter analyze 0 errors (100 pre-existing info/warnings). flutter test 28/29 PASS (1 pre-existing failure: widget_test.dart smoke test).

---
