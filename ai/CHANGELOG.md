# CHANGELOG

Starší záznamy (T-0001 až T-0009) vyčištěny — viz git historii.

---

2026-04-07 | Tester | T-0014
Migrace produkčního prostředí z Render.com na Google Cloud Platform. Backend: GcsStorageService (nahrazuje Supabase Storage), odstranění stitcher reference (PanoramaCallbackController, StitcherClient/Impl, StitchCallbackRequest, PanoramaProperties), aktualizace pom.xml (google-cloud-storage + postgres-socket-factory), application-prod.properties pro Cloud SQL, application.properties (GCS sekce, stitcher sekce odstraněna), SecurityConfig (/panoramas/** odstraněno), .env.example (GCS). Infra: render.yaml smazán, render-healthcheck.yml smazán, gcp-deploy.yml (WIF auth, Artifact Registry, Cloud Run deploy), cloud-run-healthcheck.yml, Dockerfile (PORT=8080, JSON ENTRYPOINT), docker-compose.yml (pouze db service), backend.yml (odstraněn Docker build), ci-monitor.yml (přidán Deploy to Cloud Run). Compile OK. Testy: 75 pre-existujících failures (AresService bez impl — neblokuje).

---

2026-04-07 | Tester | T-0010
Implementován kompletní forgot password flow. Backend: PasswordResetTokenEntity, PasswordResetTokenRepository, ForgotPasswordRequest/ResetPasswordRequest DTOs, rozšíření AuthErrorCode/AuthException/EmailService/AuthServiceImpl/AuthLogger/AuthController/SecurityConfig. Frontend: ForgotPasswordUseCase, ResetPasswordUseCase, request modely, AuthBloc handlery + nové eventy/stavy (Freezed), ForgotPasswordPage, ResetPasswordPage, routy v AppRouter, DI registrace, navigace z LoginForm, error kódy v LoginPage. Backend compile OK, testy OK (pre-existing failures nezměněny). Flutter analyze 0 errors (100 pre-existing info/warnings). flutter test 28/29 PASS (1 pre-existing failure: widget_test.dart smoke test).

---
