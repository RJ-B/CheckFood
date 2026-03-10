# QA

---

## T-0005 — Supabase Storage: migrace fotek z lokálního disku do cloudu

**Datum:** 2026-03-10
**Výsledek:** PASS

### Akceptační kritéria

- [x] Backend má `SupabaseStorageService` implementující `StorageService`
- [x] `SupabaseStorageService` aktivní pro `@Profile("prod")`, `LocalFilesystemStorageService` pro `@Profile("local","test")`
- [x] Panorama fotky se nahrávají do Supabase Storage (upload + stitcher výsledek)
- [x] Generic upload endpoint (`POST /api/v1/uploads`) funguje se Supabase Storage
- [x] Frontend: uživatel může vybrat profilovou fotku z galerie a nahrát ji (`GestureDetector` na avataru v `ProfileHeader`)
- [x] Nahrané fotky mají public URL přístupný z mobilní aplikace (`getPublicUrl()` vrací plnou Supabase URL)
- [x] Stávající testy projdou (lokální profil = LocalFilesystemStorageService) — 77/80 PASS
- [x] Stitcher dokáže číst/zapisovat z/do Supabase Storage (dual mode v `main.py`)
- [x] `.env.example` aktualizován o Supabase Storage config
- [ ] Supabase Storage bucket vytvořen a nakonfigurován — MIMO SCOPE TESTERA (ruční krok v Supabase Dashboard)

### Build

- Backend compile: OK (0 errors)
- Backend testy: 77/80 PASS (3 pre-existující failures)
- Frontend build_runner: OK (0 nových výstupů — vše aktuální)
- Frontend analyze: 0 errors, 90 info (pre-existující linting hints)
- Frontend testy: 27/27 PASS

### Opravené problémy

Žádné — implementace Frontend Dev i Backend Dev byla bezchybná, žádné bugy nalezeny.

### Pre-existující problémy (mimo scope T-0005)

| # | Problém | Soubor |
|---|---------|--------|
| 1 | `AuthLogoutIntegrationTest.logoutAll_RemovesAllDevices` — logout-all neodstraní všechny devices | `AuthLogoutIntegrationTest.java` |
| 2 | `MyRestaurantAuthorizationTest` (2x) — expects 404, gets 409 | `MyRestaurantAuthorizationTest.java` |

### API Contract

- `POST /api/v1/uploads`: frontend posílá multipart `file` + `directory: 'profile'` → backend vrací `{ "url": string, "filename": string }` — backend endpoint existuje v `UploadController.java` ✓
- `PATCH /api/user/profile`: frontend posílá `{ "firstName", "lastName", "profileImageUrl?" }` → backend `UpdateProfileRequest` obsahuje `profileImageUrl` pole ✓
- `SupabaseStorageService.store()` vrací `objectPath` (relativní cesta) — stejná konvence jako `LocalFilesystemStorageService` ✓
- `SupabaseStorageService.getPublicUrl()` vrací plnou Supabase URL → frontend ji může použít přímo ✓
- `StitcherClientImpl` posílá `photo_urls` (JSON key), `StitchRequest` v `main.py` akceptuje `photo_urls` ✓

### Kontrola kvality

- Žádné debug printy (kromě catch bloků s `debugPrint` — správný pattern)
- Žádný zakomentovaný kód
- Nová DI registrace: `profileRepository: sl()` přidáno do `UserBloc` factory — OK
- `@Profile("prod")` na `SupabaseStorageService` a `SupabaseStorageConfig` — správná izolace
- `LocalFilesystemStorageService` omezen na `{"local", "test"}` — testy projdou bez Supabase
- Stitcher `main.py` verze 2.0.0 — dual mode (HTTP/Supabase vs lokální volume) — zpětná kompatibilita zachována
- `image_picker: ^1.1.2` přidán do pubspec.yaml — plugin registranty pro Linux, macOS, Windows vygenerovány automaticky

### Poznámky

- RBAC omezení: `POST /api/v1/uploads` vyžaduje roli OWNER nebo MANAGER. Profilové fotky mohou uploadovat zatím jen owneri/manageři. Pro rozšíření na CUSTOMER je potřeba backend RBAC úprava — eskalováno jako known limitation.
- `SupabaseStorageConfig` bean `"supabaseRestTemplate"` je `@Profile("prod")` — v lokálním vývoji a testech se nenačítá, žádné konflikty s `stitcherRestTemplate`.

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
