# QA

---

## T-0002 — Refaktor rezervací: odstranění endTime

**Datum:** 2026-03-05
**Výsledek:** PASS (s opravami)

### Akceptační kritéria

- [x] `Reservation.endTime` není povinné pole (nullable = true)
- [x] Vytvoření rezervace nevyžaduje endTime (backend: endTime=null, frontend: endTime nullable)
- [x] Staff může ukončit rezervaci přes `/complete` → status COMPLETED + endTime=now()
- [x] Ukončená rezervace se zobrazí v historii zákazníka (upcoming/history response)
- [x] Available-slots logika funguje bez endTime (status-based blocking)
- [x] Stávající testy projdou (opraveny pro nový model)

### Build

- Backend compile: OK
- Backend testy: 77/80 PASS (3 pre-existující failures nesouvisí s T-0002)

### Nalezené a opravené problémy (QA fixes)

| # | Problém | Soubor | Oprava |
|---|---------|--------|--------|
| 1 | `LocalFilesystemStorageService` @Profile("local") — testy pod profilem "test" nemají StorageService bean | `LocalFilesystemStorageService.java` | Rozšířen profil na `{"local", "test"}` |
| 2 | `CheckfoodServiceApplicationTests` nemá @ActiveProfiles("test") | `CheckfoodServiceApplicationTests.java` | Přidáno `@ActiveProfiles("test")` |
| 3 | Double DB lookup v DiningContextServiceImpl — restaurace načtena 2x | `DiningContextServiceImpl.java` | Reuse jednoho `findById` volání |
| 4 | Dead proměnné `now` a `today` v getTableStatuses | `ReservationServiceImpl.java` | Odstraněny |
| 5 | Testy neaktualizovány pro nový open-ended model (8 failures) | `ReservationIntegrationTest.java` | Přepsány assertions pro nový model |
| 6 | Test očekával status RESERVED, nově je PENDING_CONFIRMATION | `ReservationIntegrationTest.java` | Opraven expected status |

### Pre-existující problémy (mimo scope T-0002)

| # | Problém | Soubor |
|---|---------|--------|
| 1 | `AuthLogoutIntegrationTest.logoutAll_RemovesAllDevices` — logout-all neodstraní všechny devices | `AuthLogoutIntegrationTest.java` |
| 2 | `MyRestaurantAuthorizationTest` (2x) — expects 404, gets 409 | `MyRestaurantAuthorizationTest.java` |

### Designové poznámky

- Open-ended model je agresivní: jedna aktivní rezervace blokuje stůl od startTime do konce dne. Vyžaduje disciplínu staffu (complete po odchodu hosta).
- JPQL queries používají hardcoded string literály enum hodnot — funguje, ale křehké.

---

## T-0004 — Push notifikace: tlačítko v profilu + potvrzení oprávnění

**Datum:** 2026-03-06
**Výsledek:** PASS

### Akceptační kritéria

- [x] V profilu existuje switch/toggle pro notifikace (SwitchListTile s BlocSelector v profile_screen.dart)
- [x] Při zapnutí se zobrazí systémový permission dialog (NotificationService.requestPermission() volá FirebaseMessaging.requestPermission)
- [x] Po povolení se device token odešle na backend (UserBloc._onNotificationToggled získá FCM token a pošle PUT request)
- [x] Backend uloží device token + notification preference pro uživatele (DeviceServiceImpl.updateNotificationPreference)
- [x] Při vypnutí se preference aktualizuje na backendu (PUT s notificationsEnabled=false, FCM token se smaže — GDPR)
- [x] Stav přepínače odpovídá uloženému stavu (NotificationPreferenceRequested se volá po profileRequested, GET endpoint)
- [x] Funguje na Android (Firebase setup: pubspec, Gradle plugins, google-services.json)

### Build

- Backend compile: OK
- Backend testy: 77/80 PASS (3 pre-existující failures nesouvisí s T-0004)
- Frontend analyze: OK (0 errors, 100 info/warnings — všechny pre-existující)
- Frontend testy: 27/28 PASS (1 pre-existující failure — widget_test.dart default counter smoke test)
- Build runner: OK (0 outputs — vše již vygenerováno)

### Opravené problémy

Žádné — implementace Frontend Dev i Backend Dev byla bezchybná, žádné bugy nalezeny.

### Pre-existující problémy (mimo scope T-0004)

| # | Problém | Soubor |
|---|---------|--------|
| 1 | `AuthLogoutIntegrationTest.logoutAll_RemovesAllDevices` — logout-all neodstraní všechny devices | `AuthLogoutIntegrationTest.java` |
| 2 | `MyRestaurantAuthorizationTest` (2x) — expects 404, gets 409 | `MyRestaurantAuthorizationTest.java` |
| 3 | `widget_test.dart` — default Flutter counter smoke test, nerelevantní pro projekt | `widget_test.dart` |

### API Contract

- PUT `/api/user/devices/notifications`: frontend body matches backend `UpdateNotificationRequest` (deviceIdentifier, fcmToken?, notificationsEnabled)
- GET `/api/user/devices/notifications`: frontend query param `deviceIdentifier` matches backend `@RequestParam`
- Response: `NotificationPreferenceResponse` (notificationsEnabled, hasFcmToken) — frontend parsuje z Map<String, dynamic>
- Endpoint URL: frontend `/user/devices/notifications` + Dio baseUrl `/api` = backend `/api/user/devices/notifications`

### Kontrola kvality

- Žádné debug printy (kromě catch bloků s debugPrint — správný pattern)
- Žádný zakomentovaný kód
- DI registrace kompletní (NotificationService, 2 use cases, UserBloc rozšířen o 4 nové dependency)
- Validace na backendu: @NotBlank deviceIdentifier, @NotNull notificationsEnabled
- SecurityConfig: `/api/user/**` vyžaduje autentizaci — nové endpointy automaticky chráněny
