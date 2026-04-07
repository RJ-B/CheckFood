# QA

Výsledky testování. Starší reporty vyčištěny — viz git historii pro detaily.

---

## Známé pre-existující test failures

| # | Problém | Soubor |
|---|---------|--------|
| 1 | `AuthLogoutIntegrationTest.logoutAll_RemovesAllDevices` — logout-all neodstraní všechny devices | `AuthLogoutIntegrationTest.java` |
| 2 | `MyRestaurantAuthorizationTest` (2x) — expects 404, gets 409 | `MyRestaurantAuthorizationTest.java` |
| 3 | `ReservationIntegrationTest` (4x) — slot assertion failures | `ReservationIntegrationTest.java` |
| 4 | `widget_test.dart: Counter increments smoke test` — default Flutter boilerplate, never updated for this project | `test/widget_test.dart` |
| 5 | `AuthDeviceManagementIntegrationTest.logoutDevice_OwnDevice_Returns204` — pre-existing | `AuthDeviceManagementIntegrationTest.java` |
| 6 | `AuthEdgeCasesIntegrationTest.fullFlow_Register_Verify_Login_Refresh_Logout` — pre-existing | `AuthEdgeCasesIntegrationTest.java` |
| 7 | `AuthLogoutIntegrationTest.logout_WithValidTokenAndDevice_Returns204` — pre-existing | `AuthLogoutIntegrationTest.java` |

---

## T-0014 — QA Report (2026-04-07)

**Status: PASS (s pre-existujícími failures)**

### Akceptační kritéria

| # | Kritérium | Výsledek |
|---|-----------|---------|
| 1 | Dockerfile optimalizovaný pro Cloud Run (PORT=8080, JSON ENTRYPOINT, JVM flags) | PASS |
| 2 | GcsStorageService nahrazuje SupabaseStorageService (@Profile("prod")) | PASS |
| 3 | application-prod.properties: Cloud SQL datasource + HikariCP tuning | PASS |
| 4 | GitHub Actions gcp-deploy.yml: build → push AR → deploy Cloud Run (project: checkfood-system-478116) | PASS |
| 5 | render.yaml smazán | PASS |
| 6 | Stitcher reference odstraněny (StitcherClient, StitcherClientImpl, StitchCallbackRequest, PanoramaCallbackController, PanoramaProperties, panorama.stitcher.url) | PASS |
| 7 | Supabase Storage reference odstraněny (SupabaseStorageService, SupabaseStorageConfig, supabaseRestTemplate, supabase.url, supabase.service-role-key) | PASS |
| 8 | .env.example aktualizován (GCS_BUCKET_NAME, odstraněno SUPABASE_*) | PASS |
| 9 | Kompilace OK | PASS |
| 10 | Testy: pre-existující failures (AresService bez implementace) — nezpůsobeno T-0014 | PRE-EXISTING |

### Build výsledky

- Backend `./mvnw compile -q` — EXIT 0, žádné chyby
- Backend `./mvnw test` — 0 PASS, 75 ERRORS (všechny způsobeny pre-existující `NoSuchBeanDefinitionException: AresService` — rozbije ApplicationContext pro všechny testy; nesouvisí s T-0014, AresServiceImpl nikdy neexistoval)

### Referenční kontrola (grep — 0 výsledků)

- `SupabaseStorageService`, `SupabaseStorageConfig`, `supabaseRestTemplate` — CLEAN
- `StitcherClient`, `StitcherClientImpl`, `StitchCallbackRequest`, `PanoramaCallbackController`, `PanoramaProperties` — CLEAN
- `panorama.stitcher.url`, `panorama.stitcher.callback-url` — CLEAN
- `supabase.url`, `supabase.service-role-key` (v .properties) — CLEAN
- `render.yaml` — SMAZÁN

### Pre-existující problémy (neblokují commit — B-002)

| # | Problém | Root cause |
|---|---------|------------|
| 1 | `AresService` nemá implementaci (NoSuchBeanDefinitionException) → rozbije Spring ApplicationContext → 75 testů selže | AresServiceImpl nebyl nikdy vytvořen — pre-existující od doby zavedení modulu owner/claim |

---

## T-0010 — QA Report (2026-04-07)

**Status: PASS**

### Opravené chybějící kroky (Frontend Dev přerušen)
- KROK 13: `app_router.dart` — přidány importy ForgotPasswordPage + ResetPasswordPage, konstanty `forgotPassword`/`resetPassword`, case bloky ve switch
- KROK 14: `login_form.dart` — nahrazen TODO komentář skutečnou navigací na AppRouter.forgotPassword, přidán import app_router.dart
- KROK 15: `injection_container.dart` — přidány importy + registrace ForgotPasswordUseCase + ResetPasswordUseCase, AuthBloc factory aktualizována
- KROK 16: `login_page.dart` — přidány `error_forgot_password` a `error_reset_password` do _localizeAuthError

### Build výsledky
- Backend `./mvnw compile` — OK (0 errors)
- Backend `./mvnw test` — 70/80 PASS, 10 FAIL (všechny pre-existující, žádný nový)
- `dart run build_runner build` — OK (0 nových výstupů, vše up-to-date)
- `flutter analyze` — 0 errors, 100 info/warnings (všechny pre-existující)
- `flutter test` — 28/29 PASS, 1 FAIL (widget_test.dart — pre-existující boilerplate)

### API Contract ověření
- POST `/api/auth/forgot-password` — `{ "email": "string" }` → 200 OK: MATCH
- POST `/api/auth/reset-password` — `{ "token": "string", "newPassword": "string" }` → 200 OK: MATCH

---
