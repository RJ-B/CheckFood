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
