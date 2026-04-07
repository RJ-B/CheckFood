# Prompt pro napsání diplomové práce — CheckFood

Jsi expert na psaní českých akademických diplomových prací v oblasti informatiky. Piš česky, formálním akademickým stylem, v trpném rodě nebo třetí osobě. Nepoužívej odrážky uvnitř odstavců — piš plynulou prózu. Citace uvádíš ve formátu [číslo] v textu.

---

## KONTEXT PRÁCE

- **Název:** Vývoj aplikace pro správu rezervací a objednávek v gastronomii
- **Autor:** Bc. Rostislav Jirák
- **Škola:** Univerzita Hradec Králové, Fakulta informatiky a managementu, Katedra informatiky a kvantitativních metod
- **Vedoucí:** doc. Mgr. Tomáš Kozel, Ph.D.
- **Rok:** 2025
- **Název projektu:** CheckFood

---

## CO JE JIŽ NAPSÁNO V DIPLOMCE (navazuj na to, nepřepisuj)

Práce již obsahuje tyto hotové kapitoly:
- **Úvod**
- **Kapitola 1: Analýza problému** — existující řešení (OpenTable, Restu.cz, Querko), funkční požadavky (zákazník, zaměstnanec/manažer, rezervace stolů, objednávky, platby, statistiky, notifikace), nefunkční požadavky (škálovatelnost, zabezpečení, výkon, spolehlivost, udržovatelnost)
- **Sekce 1.4: Výběr technologií** — Flutter vs React Native vs Xamarin, Spring Boot vs Node.js vs Django, PostgreSQL vs MySQL vs MongoDB, Docker, Google Cloud Platform
- **Kapitola 2: Návrh architektury** — třívrstevná monolitická architektura, popis frontendu, backendu (Controller/Service/Repository), komunikace přes REST API/HTTPS
- **Kapitola 4 (část backendu):** inicializace Spring Boot projektu (JDK 21, Maven, IntelliJ IDEA Ultimate), struktura projektu a balíčků (entity/repository/service/controller), Docker kontejnerizace a docker-compose, Spring Profiles (local/test/prod), entita User (JPA, Lombok, role jako enum, CreationTimestamp/UpdateTimestamp), nasazení na GCP (Compute Engine E2-micro free tier v us-central1, PostgreSQL přímá instalace na Debian 12, konfigurace pg_hba.conf a postgresql.conf pro externí přístup, firewall pravidlo allow-tcp-5432, application.properties s HikariCP max 5 spojení, port 8081)

---

## TECHNOLOGICKÝ STACK (vyplněno z kódu)

### Flutter
- **Verze Dart SDK:** ^3.7.2
- **Verze aplikace:** 1.0.0+1
- **State management:** BLoC pattern (flutter_bloc 8.1.6); hlavní BLoC třídy: `AuthBloc`, `UserBloc`, `ExploreBloc`, `RestaurantDetailBloc`, `ReservationBloc`, `MyReservationsBloc`, `OrdersBloc`, `MyRestaurantBloc`, `StaffReservationsBloc`, `OwnerClaimBloc`, `OnboardingWizardBloc`, `LocaleCubit`
- **HTTP klient:** Dio 5.4.3; dva Dio instance — `dioAuth` (bez interceptoru, pro login/register) a výchozí Dio s `AuthInterceptor` (QueuedInterceptor: přidává Bearer token, zachytává 401, deleguje na `RefreshTokenManager` s Completer-based deduplikací paralelních požadavků)
- **Navigace:** Custom `AppRouter` (MaterialApp onGenerateRoute) s named routes: `/`, `/login`, `/register`, `/register-owner`, `/claim-restaurant`, `/verify-email`, `/main`; `RootGuard` — auth-based routing (needsRestaurantClaim → ClaimPage, needsOnboarding → OnboardingWizard, authenticated → MainShell, unauthenticated → OnboardingScreen); `MainShell` — bottom nav tabs s role awareness (isAtLeastEmployee → MyRestaurant tab)
- **DI kontejner:** GetIt 7.7.0 v souboru `lib/core/di/injection_container.dart` — 12 registračních sekcí; BLoC jako `registerFactory` (čerstvá instance), služby/repozitáře/use cases jako `registerLazySingleton`
- **Lokální úložiště:** flutter_secure_storage 9.2.2 (tokeny — access + refresh), SharedPreferences 2.2.3 (locale, onboarding_seen flag)
- **Architektura složek:** Clean Architecture per module: `data/` (datasources, models, repositories), `domain/` (entities, repositories abstract, usecases), `presentation/` (bloc, pages, widgets)
- **Google Places API:** `GooglePlacesService` — klientská integrace Google Places API (New) pro vyhledávání restaurací na mapě; endpoint `https://places.googleapis.com/v1`, metody `searchNearby` a `searchText`, max 50 km radius, max 20 výsledků, jazyk cs

**Kompletní seznam závislostí z pubspec.yaml:**

| Závislost | Verze | Kategorie |
|-----------|-------|-----------|
| flutter_bloc | 8.1.6 | State management |
| equatable | 2.0.7 | State management |
| get_it | 7.7.0 | Dependency Injection |
| dio | 5.4.3 | HTTP klient |
| internet_connection_checker | 1.0.0+1 | Síťová komunikace |
| go_router | 14.0.0 | Navigace (deklarováno, ale nepoužito — vlastní AppRouter) |
| app_links | 6.3.2 | Deep linking |
| flutter_dotenv | 5.2.1 | Konfigurace prostředí |
| google_sign_in | 6.2.1 | OAuth — Google |
| sign_in_with_apple | 6.1.1 | OAuth — Apple |
| jwt_decoder | 2.0.1 | JWT dekódování na klientu |
| freezed_annotation | 2.4.1 | Immutable modely (anotace) |
| json_annotation | 4.9.0 | JSON serializace (anotace) |
| flutter_secure_storage | 9.2.2 | Bezpečné úložiště tokenů |
| shared_preferences | 2.2.3 | Lokální preference |
| device_info_plus | 10.1.2 | Identifikace zařízení |
| package_info_plus | 8.0.0 | Verze aplikace |
| path_provider | 2.1.3 | Cesty k souborům |
| url_launcher | 6.3.0 | Otevírání URL |
| io | 1.0.4 | I/O operace |
| firebase_core | 3.8.1 | Firebase základ |
| firebase_messaging | 15.2.1 | Push notifikace |
| camera | 0.11.0+2 | Kamera (panorama capture) |
| sensors_plus | 6.1.1 | Gyroskop (panorama úhly) |
| image_picker | 1.1.2 | Výběr fotografií |
| cached_network_image | 3.3.1 | Cache obrázků |
| qr_flutter | 4.1.0 | QR kódy (MFA) |
| webview_flutter | 4.8.0 | WebView (3D panorama) |
| webview_flutter_android | 3.16.0 | WebView — Android specifická implementace |
| google_maps_flutter | 2.10.0 | Google Maps |
| sliding_up_panel | 2.0.0+1 | Sliding panel (explore) |
| geolocator | 13.0.0 | GPS lokace |
| stream_transform | 2.1.0 | Debounce operátor pro streamy (BLoC events) |
| intl | any | Internacionalizace |
| logger | 2.3.0 | Logování |
| uuid | 4.4.0 | UUID generování |
| cupertino_icons | 1.0.8 | iOS ikony |
| flutter_svg | 2.0.10 | SVG rendering |
| google_fonts | 6.2.1 | Google Fonts |
| gap | 3.0.1 | Spacing widget |
| app_settings | 7.0.0 | Otevření systémového nastavení (notifikace, lokace) |

**Dev dependencies:** flutter_test, flutter_lints 4.0.0, bloc_test 9.1.7, mocktail 1.0.4, build_runner 2.4.9, freezed 2.5.2, json_serializable 6.8.0, flutter_launcher_icons 0.13.1, flutter_native_splash 2.4.0

### Spring Boot
- **Verze Spring Boot:** 3.5.7
- **Java:** JDK 21 (Eclipse Temurin)
- **Build:** Apache Maven 3.9+ (wrapper `mvnw`)
- **Databáze:** PostgreSQL 15 + PostGIS 3.4
- **ORM:** Spring Data JPA + Hibernate Spatial
- **Bezpečnost:** Spring Security 6.4.3 + Spring OAuth2 Resource Server + JJWT 0.12.6 (NimbusJwtEncoder/Decoder, HS256)
- **Port:** 8081
- **Virtual Threads:** Project Loom enabled (`spring.threads.virtual.enabled=true`)

**Kompletní seznam závislostí z pom.xml:**

| Závislost | Verze | Kategorie |
|-----------|-------|-----------|
| spring-boot-starter-web | 3.5.7 | Web framework |
| spring-boot-starter-validation | 3.5.7 | Jakarta Bean Validation |
| spring-boot-starter-data-jpa | 3.5.7 | JPA/Hibernate |
| spring-boot-starter-security | 3.5.7 | Spring Security 6.4.3 |
| spring-boot-starter-oauth2-resource-server | 3.5.7 | OAuth2 Resource Server |
| spring-boot-starter-actuator | 3.5.7 | Monitoring/health |
| spring-boot-starter-mail | 3.5.7 | Email (SMTP) |
| spring-boot-starter-devtools | 3.5.7 | Dev tools (optional, runtime) |
| spring-cloud-starter-openfeign | 2025.0.0 | Feign HTTP client |
| postgresql (driver) | 42.7.6 | PostgreSQL JDBC |
| flyway-core + flyway-database-postgresql | managed | DB migrace |
| hibernate-spatial | managed | PostGIS integrace |
| postgis-jdbc | 2.5.0 | PostGIS JDBC |
| jjwt-api/impl/jackson | 0.12.6 | JWT generování/validace |
| google-api-client | 2.4.1 | Google OAuth verifikace |
| google-http-client-gson | 1.44.1 | Google HTTP |
| mapstruct | 1.5.5.Final | DTO mapping |
| lombok | 1.18.32 | Boilerplate redukce |
| springdoc-openapi-starter-webmvc-ui | 2.8.5 | Swagger/OpenAPI |
| duckdb_jdbc | 1.4.4.0 | Overture Maps analytics |
| h2 | managed (test) | In-memory test DB |

### Stitcher (Python microservice)
- **Runtime:** Python 3.12
- **Framework:** FastAPI 0.115.6 + Uvicorn 0.34.0
- **Image Processing:** OpenCV (headless) 4.10.0.84
- **HTTP Client:** httpx 0.28.1
- **Účel:** Stitching panoramatických fotek do 360° panoramatu

### Infrastruktura
- **Lokální:** Docker Compose (3 služby: PostgreSQL+PostGIS, Stitcher, App), Spring Profiles (local/test/prod)
- **Produkce:** Render.com (Docker-based web service, free plan, auto-deploy z main) + Supabase (PostgreSQL + Storage)
- **Dockerfile:** Multi-stage build — Stage 1: `maven:3.9-eclipse-temurin-21` → `mvn clean package -DskipTests`; Stage 2: `eclipse-temurin:21-jre`, kopíruje JAR, `ENV PORT=8081`, `EXPOSE ${PORT}`, entrypoint: `java -jar app.jar --server.port=${PORT} --server.address=0.0.0.0`
- **docker-compose.yml:** 3 služby na síti `checkfood-network`: `db` (postgis/postgis:15-3.4-alpine, port 5433, healthcheck pg_isready), `stitcher` (FastAPI, port 8090, sdílený volume uploads), `app` (Spring Boot, port 8081, depends_on db:healthy, sdílený volume uploads, Virtual Threads enabled)
- **CI/CD:** GitHub Actions — `backend.yml` (Maven build + test + Docker verify), `flutter-android.yml` (build APK artifact), `flutter-android-release.yml` (build APK + GitHub Release), `ci-monitor.yml` (auto-creates GitHub Issues on CI failure), `render-healthcheck.yml` (15-min health check + auto-issue)
- **render.yaml:** Service `checkfood-api`, runtime docker, health check `/actuator/health`, port 10000, env vars (JWT_SECRET auto-generated, Supabase credentials)
- **Supabase Storage:** bucket `checkfood-public`, HTTP REST API pro upload/download souborů, `SupabaseStorageService` (prod profil), `LocalFilesystemStorageService` (local profil)
- **Google Places API:** klientská integrace (Flutter) — `GooglePlacesService` volá `places.googleapis.com/v1` s API klíčem z `.env`

---

## KOMPLETNÍ DATABÁZOVÉ SCHÉMA

### Tabulka: `users` (entita: `UserEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, GenerationType.IDENTITY |
| email | VARCHAR(254) | NOT NULL, UNIQUE, index `idx_user_email` |
| first_name | VARCHAR(50) | nullable |
| last_name | VARCHAR(50) | nullable |
| profile_image_url | VARCHAR(512) | nullable (z OAuth) |
| phone | VARCHAR(20) | nullable |
| address_street | VARCHAR(255) | nullable |
| address_city | VARCHAR(150) | nullable |
| address_postal_code | VARCHAR(20) | nullable |
| address_country | VARCHAR(100) | nullable |
| password | VARCHAR(255) | nullable (null pro OAuth uživatele, bcrypt strength 12) |
| auth_provider | VARCHAR(20) | NOT NULL, EnumType.STRING (LOCAL, GOOGLE, APPLE) |
| provider_id | VARCHAR(255) | NOT NULL (equals email pro LOCAL) |
| enabled | BOOLEAN | NOT NULL, default false (aktivace po verifikaci emailu) |
| created_at | TIMESTAMP | NOT NULL, updatable=false, @PrePersist |
| updated_at | TIMESTAMP | nullable, @PreUpdate |

Index: `idx_user_provider_identity` (auth_provider, provider_id)
Implements `UserDetails` — `getUsername()` → email, `getAuthorities()` → `ROLE_` + role name

### Tabulka: `roles` (entita: `RoleEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| name | VARCHAR(50) | NOT NULL, UNIQUE, index `idx_role_name` |
| description | VARCHAR(255) | nullable |

Hodnoty v produkci: USER, OWNER, STAFF, ADMIN, MODERATOR, CUSTOMER

### Tabulka: `permissions` (entita: `PermissionEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| name | VARCHAR(100) | NOT NULL, UNIQUE, index `idx_permission_name` |
| description | VARCHAR(255) | nullable |

### Spojovací tabulka: `user_roles`

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| user_id | BIGINT | FK → users.id |
| role_id | BIGINT | FK → roles.id |

### Spojovací tabulka: `role_permissions`

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| role_id | BIGINT | FK → roles.id |
| permission_id | BIGINT | FK → permissions.id |

### Tabulka: `devices` (entita: `DeviceEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| device_identifier | VARCHAR(255) | NOT NULL, UNIQUE, index `idx_device_identifier` |
| device_type | VARCHAR(255) | nullable |
| device_name | VARCHAR(255) | nullable |
| last_ip_address | VARCHAR(45) | nullable (IPv4/IPv6) |
| user_agent | VARCHAR(512) | nullable |
| fcm_token | VARCHAR(512) | nullable (Firebase push token) |
| notifications_enabled | BOOLEAN | NOT NULL, default false |
| active | BOOLEAN | NOT NULL, default true (soft logout flag) |
| last_login | TIMESTAMP | NOT NULL, @PrePersist/@PreUpdate |
| user_id | BIGINT | NOT NULL, FK → users.id |

### Tabulka: `verification_tokens` (entita: `VerificationTokenEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| token | VARCHAR(255) | NOT NULL, UNIQUE (UUID string) |
| user_id | BIGINT | NOT NULL, FK → users.id (OneToOne EAGER) |
| expiry_date | TIMESTAMP | NOT NULL (24h od vytvoření) |

### Tabulka: `mfa_secrets` (entita: `MfaSecretEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| user_id | BIGINT | NOT NULL, UNIQUE, FK → users.id (OneToOne LAZY) |
| secret | VARCHAR(64) | NOT NULL (Base32 TOTP secret) |
| enabled | BOOLEAN | NOT NULL, default false |
| method | VARCHAR(20) | NOT NULL, EnumType.STRING (TOTP, BACKUP_CODE) |
| enabled_at | TIMESTAMP | nullable |
| created_at | TIMESTAMP | NOT NULL, updatable=false |

### Tabulka: `mfa_backup_codes` (entita: `MfaBackupCodeEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| user_id | BIGINT | NOT NULL, FK → users.id, indexed |
| code_hash | VARCHAR(255) | NOT NULL (BCrypt hash) |
| used | BOOLEAN | NOT NULL, default false |
| created_at | TIMESTAMP | NOT NULL, updatable=false |

### Tabulka: `audit_logs` (entita: `AuditLogEntity`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| user_id | BIGINT | nullable (null = anonymní/systém), indexed |
| action | VARCHAR(50) | NOT NULL, EnumType.STRING, indexed |
| status | VARCHAR(20) | NOT NULL, EnumType.STRING (SUCCESS, FAILED, BLOCKED) |
| ip_address | VARCHAR(45) | nullable |
| user_agent | VARCHAR(255) | nullable |
| created_at | INSTANT | NOT NULL, updatable=false, indexed |

AuditAction enum: LOGIN, REGISTER, VERIFY_EMAIL, LOGOUT, REFRESH_TOKEN, OAUTH_LOGIN, MFA_SETUP_START, MFA_SETUP_VERIFY, MFA_CHALLENGE, MFA_DISABLED, PASSWORD_CHANGED, EMAIL_CHANGED, PROFILE_UPDATED, ACCOUNT_DELETED, RATE_LIMIT_EXCEEDED, INVALID_TOKEN, ROLE_ASSIGNED, UNAUTHORIZED_ACCESS

### Tabulka: `restaurant` (entita: `Restaurant`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, GenerationType.UUID |
| overture_id | VARCHAR(64) | UNIQUE, nullable (Overture Maps ID) |
| ico | VARCHAR(8) | UNIQUE, nullable (IČO firmy) |
| owner_id | UUID | NOT NULL, indexed |
| name | VARCHAR(150) | NOT NULL |
| description | VARCHAR(1000) | nullable |
| cuisine_type | VARCHAR(50) | NOT NULL, EnumType.STRING |
| logo_url | VARCHAR(255) | nullable |
| cover_image_url | VARCHAR(255) | nullable |
| panorama_url | VARCHAR(255) | nullable |
| phone | VARCHAR(20) | nullable |
| contact_email | VARCHAR(254) | nullable |
| status | VARCHAR(30) | NOT NULL, EnumType.STRING, indexed |
| is_active | BOOLEAN | NOT NULL, indexed |
| rating | DECIMAL(2,1) | nullable |
| street | VARCHAR(255) | nullable (embedded Address) |
| street_number | VARCHAR(50) | nullable |
| city | VARCHAR(150) | nullable |
| postal_code | VARCHAR(50) | nullable |
| country | VARCHAR(100) | nullable |
| location | geometry(Point,4326) | nullable (PostGIS, SRID 4326 WGS84) |
| google_place_id | VARCHAR(255) | nullable |
| default_reservation_duration_minutes | INT | NOT NULL, default 60 |
| onboarding_completed | BOOLEAN | NOT NULL, default false |
| created_at | TIMESTAMP | NOT NULL, updatable=false |
| updated_at | TIMESTAMP | nullable |

Indexy: `idx_restaurant_owner`, `idx_restaurant_status`, `idx_restaurant_active`, `idx_restaurant_overture_id`, `idx_restaurant_ico`

CuisineType enum: ITALIAN, CZECH, ASIAN, VIETNAMESE, INDIAN, FRENCH, MEXICAN, AMERICAN, MEDITERRANEAN, JAPANESE_SUSHI, BURGER, PIZZA, VEGAN_VEGETARIAN, INTERNATIONAL, STREET_FOOD, KEBAB, CAFE_DESSERT, OTHER

RestaurantStatus enum: PENDING, ACTIVE, CLOSED, ARCHIVED

### Kolekční tabulka: `restaurant_opening_hours` (embeddable `OpeningHours`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| restaurant_id | UUID | FK → restaurant.id |
| day_of_week | VARCHAR(20) | NOT NULL, EnumType.STRING (java.time.DayOfWeek) |
| open_at | TIME | nullable |
| close_at | TIME | nullable |
| is_closed | BOOLEAN | NOT NULL |

### Kolekční tabulka: `restaurant_special_days` (embeddable `SpecialDay`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| restaurant_id | UUID | FK → restaurant.id |
| date | DATE | NOT NULL |
| is_closed | BOOLEAN | NOT NULL |
| open_at | TIME | nullable |
| close_at | TIME | nullable |
| note | VARCHAR(200) | nullable |

### Kolekční tabulka: `restaurant_tag`

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| restaurant_id | UUID | FK → restaurant.id |
| tag | VARCHAR(255) | tag string |

### Tabulka: `restaurant_table` (entita: `RestaurantTable`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| restaurant_id | UUID | NOT NULL, indexed |
| label | VARCHAR(50) | NOT NULL |
| capacity | INT | NOT NULL |
| is_active | BOOLEAN | NOT NULL, indexed |
| yaw | DOUBLE | nullable (horizontální úhel v panoramatu) |
| pitch | DOUBLE | nullable (vertikální úhel v panoramatu) |

### Tabulka: `restaurant_table_group` (entita: `TableGroup`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| restaurant_id | UUID | NOT NULL, indexed |
| label | VARCHAR(100) | nullable |
| is_active | BOOLEAN | NOT NULL, indexed |
| closed_at | TIMESTAMPTZ | nullable |

### Tabulka: `restaurant_table_group_item` (entita: `TableGroupItem`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| group_id | UUID | NOT NULL, FK → restaurant_table_group.id |
| table_id | UUID | NOT NULL |

Unique constraint: `uk_group_table` (group_id, table_id)

### Tabulka: `restaurant_employee` (entita: `RestaurantEmployee`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| user_id | BIGINT | NOT NULL, FK → users.id, indexed |
| restaurant_id | UUID | NOT NULL, FK → restaurant.id, indexed |
| role | VARCHAR(20) | NOT NULL, EnumType.STRING (OWNER, MANAGER, STAFF, HOST) |
| membership_status | VARCHAR(20) | NOT NULL, EnumType.STRING (ACTIVE, PENDING), default ACTIVE |
| created_at | TIMESTAMP | NOT NULL, updatable=false |

Unique constraint: `uk_re_user_restaurant` (user_id, restaurant_id)

### Kolekční tabulka: `restaurant_employee_permissions`

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| restaurant_employee_id | BIGINT | FK → restaurant_employee.id |
| permission | VARCHAR(50) | EnumType.STRING |

EmployeePermission enum: CONFIRM_RESERVATION, EDIT_RESERVATION, CANCEL_RESERVATION, CHECK_IN_RESERVATION, COMPLETE_RESERVATION, EDIT_RESTAURANT_INFO, EDIT_RESERVATION_DURATION, VIEW_STATISTICS, VIEW_RESTAURANT_INFO, MANAGE_EMPLOYEES, MANAGE_MENU

Statická metoda `defaultsForRole(RestaurantEmployeeRole)` vrací výchozí sadu oprávnění pro danou roli.

### Tabulka: `menu_category` (entita: `MenuCategory`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| restaurant_id | UUID | NOT NULL, indexed |
| name | VARCHAR(100) | NOT NULL |
| sort_order | INT | NOT NULL, default 0 |
| is_active | BOOLEAN | NOT NULL, default true |

Index: `idx_menu_category_sort` (restaurant_id, sort_order)

### Tabulka: `menu_item` (entita: `MenuItem`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| category_id | UUID | NOT NULL, indexed |
| restaurant_id | UUID | NOT NULL, indexed |
| name | VARCHAR(150) | NOT NULL |
| description | VARCHAR(500) | nullable |
| price_minor | INT | NOT NULL (cena v haléřích/centech) |
| currency | VARCHAR(3) | NOT NULL, default "CZK" |
| image_url | VARCHAR(255) | nullable |
| is_available | BOOLEAN | NOT NULL, default true |
| sort_order | INT | NOT NULL, default 0 |

Index: `idx_menu_item_sort` (category_id, sort_order)

### Tabulka: `reservation` (entita: `Reservation`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| restaurant_id | UUID | NOT NULL, indexed |
| table_id | UUID | NOT NULL |
| user_id | BIGINT | NOT NULL, indexed |
| reservation_date | DATE | NOT NULL |
| start_time | TIME | NOT NULL |
| end_time | TIME | nullable (open-ended model) |
| status | VARCHAR(30) | NOT NULL, EnumType.STRING, default PENDING_CONFIRMATION |
| party_size | INT | NOT NULL, default 2 |
| recurring_reservation_id | UUID | nullable, FK → recurring_reservation.id, indexed |
| created_at | TIMESTAMP | NOT NULL, updatable=false |

Index: `idx_reservation_table_date` (table_id, reservation_date)

ReservationStatus enum: PENDING_CONFIRMATION, CONFIRMED, RESERVED, CHECKED_IN, REJECTED, CANCELLED, COMPLETED

### Tabulka: `recurring_reservation` (entita: `RecurringReservation`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| restaurant_id | UUID | NOT NULL, indexed |
| table_id | UUID | NOT NULL |
| user_id | BIGINT | NOT NULL, indexed |
| day_of_week | VARCHAR(15) | NOT NULL, EnumType.STRING (java.time.DayOfWeek) |
| start_time | TIME | NOT NULL |
| party_size | INT | NOT NULL, default 2 |
| status | VARCHAR(30) | NOT NULL, EnumType.STRING, default PENDING_CONFIRMATION |
| repeat_until | DATE | nullable (null dokud staff nepotvrdí) |
| created_at | TIMESTAMP | NOT NULL, updatable=false |

Indexy: `idx_recurring_user`, `idx_recurring_restaurant`

RecurringReservationStatus enum: PENDING_CONFIRMATION, ACTIVE, REJECTED, CANCELLED

### Tabulka: `reservation_change_request` (entita: `ReservationChangeRequest`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| reservation_id | UUID | NOT NULL, indexed |
| proposed_table_id | UUID | nullable |
| original_table_id | UUID | nullable |
| requested_by_user_id | BIGINT | NOT NULL |
| proposed_start_time | TIME | nullable |
| original_start_time | TIME | NOT NULL |
| status | VARCHAR(20) | NOT NULL, EnumType.STRING, default PENDING |
| created_at | TIMESTAMP | NOT NULL, updatable=false |
| resolved_at | TIMESTAMP | nullable |

Indexy: `idx_change_request_reservation`, `idx_change_request_status`

ChangeRequestStatus enum: PENDING, ACCEPTED, DECLINED

### Tabulka: `customer_order` (entita: `Order`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| user_id | BIGINT | NOT NULL, indexed |
| restaurant_id | UUID | NOT NULL, indexed |
| table_id | UUID | NOT NULL, indexed |
| reservation_id | UUID | nullable, indexed |
| session_id | UUID | nullable |
| status | VARCHAR(20) | NOT NULL, EnumType.STRING, default PENDING, indexed |
| total_price_minor | INT | NOT NULL |
| currency | VARCHAR(3) | NOT NULL, default "CZK" |
| note | VARCHAR(500) | nullable |
| created_at | TIMESTAMP | NOT NULL, updatable=false, indexed |

OrderStatus enum: PENDING, CONFIRMED, PREPARING, READY, DELIVERED, CANCELLED

### Tabulka: `order_item` (entita: `OrderItem`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| order_id | UUID | NOT NULL, FK → customer_order.id, indexed |
| menu_item_id | UUID | NOT NULL, indexed (snapshot, not live join) |
| item_name | VARCHAR(150) | NOT NULL (denormalizovaný snapshot) |
| unit_price_minor | INT | NOT NULL (cena v okamžiku objednávky) |
| quantity | INT | NOT NULL |

### Tabulka: `user_favourite_restaurant` (entita: `UserFavouriteRestaurant`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | BIGINT | PK, IDENTITY |
| user_id | BIGINT | NOT NULL, indexed |
| restaurant_id | UUID | NOT NULL, indexed |
| created_at | TIMESTAMP | NOT NULL, updatable=false |

Unique constraint: `uk_user_favourite_restaurant` (user_id, restaurant_id)

### Tabulka: `panorama_session` (entita: `PanoramaSession`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| restaurant_id | UUID | NOT NULL, indexed |
| status | VARCHAR(20) | NOT NULL, EnumType.STRING, default UPLOADING |
| photo_count | INT | NOT NULL, default 0 |
| result_url | VARCHAR(255) | nullable (URL výsledného panoramatu) |
| created_at | TIMESTAMP | NOT NULL, updatable=false |
| completed_at | TIMESTAMP | nullable |
| error_message | VARCHAR(500) | nullable |

PanoramaSessionStatus enum: UPLOADING, PROCESSING, COMPLETED, FAILED

### Tabulka: `panorama_photo` (entita: `PanoramaPhoto`)

| Sloupec | Typ | Omezení |
|---------|-----|---------|
| id | UUID | PK, UUID |
| session_id | UUID | NOT NULL, indexed |
| angle_index | INT | NOT NULL (sekvenční index snímku) |
| target_angle | DOUBLE | NOT NULL (zamýšlený horizontální úhel) |
| actual_angle | DOUBLE | NOT NULL (GPS-měřený úhel) |
| target_pitch | DOUBLE | nullable (zamýšlený vertikální úhel) |
| actual_pitch | DOUBLE | nullable (měřený vertikální úhel) |
| photo_url | VARCHAR(255) | NOT NULL |
| uploaded_at | TIMESTAMP | NOT NULL |

### Vztahy mezi tabulkami

```
UserEntity (users) 1—N DeviceEntity (devices): OneToMany, cascade ALL, orphanRemoval, FK: devices.user_id → users.id
UserEntity (users) N—N RoleEntity (roles): ManyToMany LAZY via user_roles (user_id, role_id)
RoleEntity (roles) N—N PermissionEntity (permissions): ManyToMany EAGER via role_permissions (role_id, permission_id)
UserEntity (users) 1—1 MfaSecretEntity (mfa_secrets): OneToOne LAZY, FK: mfa_secrets.user_id → users.id (UNIQUE)
UserEntity (users) 1—N MfaBackupCodeEntity (mfa_backup_codes): ManyToOne LAZY, FK: mfa_backup_codes.user_id → users.id
UserEntity (users) 1—1 VerificationTokenEntity (verification_tokens): OneToOne EAGER, FK: verification_tokens.user_id → users.id
UserEntity (users) 1—N RestaurantEmployee (restaurant_employee): ManyToOne LAZY, FK: restaurant_employee.user_id → users.id
Restaurant (restaurant) 1—N RestaurantEmployee: ManyToOne LAZY, FK: restaurant_employee.restaurant_id → restaurant.id
RestaurantEmployee 1—N EmployeePermission: ElementCollection EAGER via restaurant_employee_permissions
Restaurant → RestaurantTable: FK by value (restaurant_table.restaurant_id)
Restaurant → MenuCategory: FK by value (menu_category.restaurant_id)
Restaurant → Reservation: FK by value (reservation.restaurant_id)
Restaurant → RecurringReservation: FK by value (recurring_reservation.restaurant_id)
Restaurant → Order: FK by value (customer_order.restaurant_id)
Restaurant → PanoramaSession: FK by value (panorama_session.restaurant_id)
Restaurant → UserFavouriteRestaurant: FK by value (user_favourite_restaurant.restaurant_id)
Reservation → ReservationChangeRequest: FK by value (reservation_change_request.reservation_id)
Reservation → RecurringReservation: FK by value (reservation.recurring_reservation_id)
TableGroup 1—N TableGroupItem: OneToMany, cascade ALL, orphanRemoval
Order 1—N OrderItem: OneToMany, cascade ALL, orphanRemoval, FK: order_item.order_id → customer_order.id
MenuCategory → MenuItem: FK by value (menu_item.category_id)
PanoramaSession → PanoramaPhoto: FK by value (panorama_photo.session_id)
```

**Architektonická poznámka:** Většina cross-aggregate foreign keys je uložena jako plain UUID/Long sloupce (FK by value, bez JPA @ManyToOne join objektů). Skutečné JPA object-level joins jsou použity pouze v rámci stejného agregátu.

---

## KOMPLETNÍ REST API (110 endpointů, 20 controllerů)

### AuthController — `/api/auth`
Třída: `com.checkfood.checkfoodservice.security.module.auth.controller.AuthController`

| Metoda | Cesta | Popis | Request | Response | Zabezpečení |
|--------|-------|-------|---------|----------|-------------|
| POST | `/api/auth/register` | Registrace zákazníka | RegisterRequest | 202 Accepted | @RateLimited(5/15min, perIp) |
| POST | `/api/auth/register-owner` | Registrace vlastníka | RegisterRequest | 202 Accepted | @RateLimited(5/15min, perIp) |
| POST | `/api/auth/resend-code` | Opětovné odeslání verifikačního kódu | ResendCodeRequest | 200 OK | @RateLimited(3/5min, perIp) |
| GET | `/api/auth/verify` | Verifikace emailu (redirect na deep link) | ?token=UUID | 302 Redirect | public |
| POST | `/api/auth/login` | Přihlášení | LoginRequest | AuthResponse | @RateLimited(10/1min, perIp) |
| POST | `/api/auth/refresh` | Obnova tokenů | RefreshRequest | TokenResponse | @RateLimited(30/1min, perIp) |
| POST | `/api/auth/logout` | Odhlášení | LogoutRequest | 204 No Content | public (optional auth) |
| GET | `/api/auth/me` | Aktuální uživatel | — | UserResponse | authenticated |

### UserController — `/api/user`
Třída: `com.checkfood.checkfoodservice.security.module.user.controller.UserController`

| Metoda | Cesta | Popis | Request | Response | Zabezpečení |
|--------|-------|-------|---------|----------|-------------|
| GET | `/api/user/me` | Profil uživatele | — | UserProfileResponse | authenticated |
| POST | `/api/user/change-password` | Změna hesla | ChangePasswordRequest | 204 | authenticated |
| PATCH | `/api/user/profile` | Aktualizace profilu | UpdateProfileRequest | UserProfileResponse | authenticated |
| GET | `/api/user` | Seznam všech uživatelů | — | List\<UserSummaryResponse\> | ADMIN |
| GET | `/api/user/{id}` | Detail uživatele | — | UserAdminResponse | ADMIN |
| POST | `/api/user/assign-role` | Přiřazení role | AssignRoleRequest | 200 | ADMIN |
| POST | `/api/user/logout-all` | Soft logout ze všech ostatních zařízení | — | 204 | authenticated |
| DELETE | `/api/user/devices/all` | Hard delete všech zařízení kromě aktuálního | — | 204 | authenticated |
| GET | `/api/user/devices` | Seznam zařízení s aktuálním stavem | — | List\<DeviceResponse\> | authenticated |
| POST | `/api/user/devices/{deviceId}/logout` | Soft logout konkrétního zařízení | — | 204 | authenticated |
| DELETE | `/api/user/devices/{deviceId}` | Hard delete konkrétního zařízení | — | 204 | authenticated |
| PUT | `/api/user/devices/notifications` | Nastavení FCM tokenu a notifikací | UpdateNotificationRequest | NotificationPreferenceResponse | authenticated |
| GET | `/api/user/devices/notifications` | Stav notifikací | ?deviceIdentifier= | NotificationPreferenceResponse | authenticated |

### OAuthController — `/api/oauth`

| Metoda | Cesta | Popis | Request | Response | Zabezpečení |
|--------|-------|-------|---------|----------|-------------|
| POST | `/api/oauth/login` | OAuth přihlášení (Google/Apple) | OAuthLoginRequest | AuthResponse | @RateLimited(5/1min, perIp) |

### MfaController — `/api/mfa`

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| POST | `/api/mfa/setup/start` | Zahájení MFA nastavení | authenticated + @RateLimited(3/30min) |
| POST | `/api/mfa/setup/verify` | Ověření MFA kódu při nastavení | authenticated + @RateLimited(5/10min) |
| POST | `/api/mfa/challenge/verify` | Ověření MFA kódu při přihlášení | authenticated + @RateLimited(3/5min) |
| POST | `/api/mfa/disable` | Deaktivace MFA | authenticated + @RateLimited(3/10min) |
| GET | `/api/mfa/status` | Stav MFA | authenticated + @RateLimited(30/1min) |

### AuditController — `/api/admin/audit` (ADMIN only)

| Metoda | Cesta | Popis |
|--------|-------|-------|
| GET | `/api/admin/audit` | Všechny audit logy (stránkované) |
| GET | `/api/admin/audit/user/{userId}` | Audit logy uživatele |

### RestaurantController — `/api/v1/restaurants`

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| GET | `/api/v1/restaurants/markers` | Markery na mapě (PostGIS clustering, zoom-adaptive) | public |
| GET | `/api/v1/restaurants/nearest` | Nejbližší restaurace s filtry (kuchyně, hodnocení, otevřeno, oblíbené) | public (optional auth) |
| GET | `/api/v1/restaurants/{id}` | Detail restaurace | public (optional auth) |
| POST | `/api/v1/restaurants` | Vytvoření restaurace | RESTAURANT_OWNER |
| GET | `/api/v1/restaurants/me` | Moje restaurace | RESTAURANT_OWNER |
| PUT | `/api/v1/restaurants/{id}` | Aktualizace restaurace | RESTAURANT_OWNER |
| DELETE | `/api/v1/restaurants/{id}` | Smazání restaurace (soft delete) | RESTAURANT_OWNER |
| POST | `/api/v1/restaurants/{id}/tables` | Přidání stolu | RESTAURANT_OWNER |
| GET | `/api/v1/restaurants/{id}/tables` | Seznam stolů | RESTAURANT_OWNER |

### MyRestaurantController — `/api/my-restaurant` (OWNER/MANAGER/STAFF)

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| GET | `/api/my-restaurant/list` | Seznam mých restaurací | OWNER/MANAGER/STAFF |
| GET | `/api/my-restaurant` | Moje restaurace (jedna) | OWNER/MANAGER/STAFF |
| PUT | `/api/my-restaurant` | Aktualizace | OWNER/MANAGER |
| GET | `/api/my-restaurant/employees` | Seznam zaměstnanců | OWNER/MANAGER |
| POST | `/api/my-restaurant/employees` | Přidání zaměstnance | OWNER only |
| PUT | `/api/my-restaurant/employees/{id}` | Změna role | OWNER only |
| GET | `/api/my-restaurant/employees/{id}/permissions` | Oprávnění zaměstnance | OWNER only |
| PUT | `/api/my-restaurant/employees/{id}/permissions` | Aktualizace oprávnění | OWNER only |
| DELETE | `/api/my-restaurant/employees/{id}` | Odebrání zaměstnance | OWNER only |
| GET | `/api/my-restaurant/special-days` | Speciální dny/svátky | OWNER/MANAGER |
| PUT | `/api/my-restaurant/special-days` | Aktualizace speciálních dnů | OWNER/MANAGER |

### ReservationController (zákaznické endpointy)

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| GET | `/api/v1/restaurants/{id}/reservation-scene` | 3D scéna pro rezervaci (panorama + stoly s yaw/pitch) | public |
| GET | `/api/v1/restaurants/{id}/tables/status` | Stavy stolů na dané datum | public |
| GET | `/api/v1/restaurants/{id}/tables/{tid}/available-slots` | Dostupné časové sloty | public |
| POST | `/api/v1/reservations` | Vytvoření rezervace | authenticated |
| GET | `/api/v1/reservations/me` | Přehled mých rezervací | authenticated |
| GET | `/api/v1/reservations/me/history` | Historie rezervací | authenticated |
| PUT | `/api/v1/reservations/{id}` | Úprava rezervace | authenticated |
| PATCH | `/api/v1/reservations/{id}/cancel` | Zrušení rezervace | authenticated |
| GET | `/api/v1/reservations/me/pending-changes` | Nevyřízené návrhy změn od personálu | authenticated |
| POST | `/api/v1/reservations/change-requests/{id}/accept` | Přijetí návrhu změny | authenticated |
| POST | `/api/v1/reservations/change-requests/{id}/decline` | Odmítnutí návrhu změny | authenticated |

### RecurringReservationController — `/api/v1/recurring-reservations`

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| POST | `/api/v1/recurring-reservations` | Vytvoření opakující se rezervace | authenticated |
| GET | `/api/v1/recurring-reservations/me` | Moje opakující se rezervace | authenticated |
| PATCH | `/api/v1/recurring-reservations/{id}/cancel` | Zrušení opakující se rezervace | authenticated |

### StaffReservationController — `/api/v1/staff` (OWNER/MANAGER/STAFF)

| Metoda | Cesta | Popis |
|--------|-------|-------|
| GET | `/api/v1/staff/my-restaurant/tables` | Stoly restaurace |
| GET | `/api/v1/staff/my-restaurant/reservations` | Rezervace restaurace na datum |
| POST | `/api/v1/staff/reservations/{id}/confirm` | Potvrzení |
| POST | `/api/v1/staff/reservations/{id}/reject` | Odmítnutí |
| POST | `/api/v1/staff/reservations/{id}/check-in` | Check-in |
| POST | `/api/v1/staff/reservations/{id}/complete` | Dokončení |
| PUT | `/api/v1/staff/reservations/{id}/propose-change` | Návrh změny času/stolu zákazníkovi |
| PATCH | `/api/v1/staff/reservations/{id}/extend` | Prodloužení rezervace |
| GET | `/api/v1/staff/recurring-reservations` | Opakující se rezervace restaurace |
| POST | `/api/v1/staff/recurring-reservations/{id}/confirm` | Potvrzení opakující se rezervace |
| POST | `/api/v1/staff/recurring-reservations/{id}/reject` | Odmítnutí opakující se rezervace |
| POST | `/api/v1/staff/recurring-reservations/{id}/cancel` | Zrušení opakující se rezervace |

### OrderController

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| POST | `/api/v1/orders` | Vytvoření objednávky | authenticated |
| GET | `/api/v1/orders/me/current` | Aktuální objednávky | authenticated |

### MenuController (public) + OwnerMenuController (OWNER)

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| GET | `/api/v1/restaurants/{id}/menu` | Menu restaurace | public |
| GET | `/api/v1/owner/restaurant/me/menu` | Menu vlastníka | OWNER |
| POST | `.../menu/categories` | Vytvoření kategorie | OWNER |
| PUT | `.../menu/categories/{id}` | Aktualizace kategorie | OWNER |
| DELETE | `.../menu/categories/{id}` | Smazání kategorie | OWNER |
| POST | `.../menu/categories/{catId}/items` | Vytvoření položky | OWNER |
| PUT | `.../menu/items/{id}` | Aktualizace položky | OWNER |
| DELETE | `.../menu/items/{id}` | Smazání položky | OWNER |

### FavouriteController — `/api/v1/users/me/favourites`

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| GET | `/api/v1/users/me/favourites` | Seznam oblíbených | authenticated |
| PUT | `/api/v1/users/me/favourites/{id}` | Přidání (idempotentní) | authenticated |
| DELETE | `/api/v1/users/me/favourites/{id}` | Odebrání | authenticated |

### PanoramaController — `/api/v1/owner/restaurant/me/panorama` (OWNER)

| Metoda | Cesta | Popis |
|--------|-------|-------|
| POST | `.../panorama/sessions` | Vytvoření session |
| POST | `.../panorama/sessions/{id}/photos` | Upload fotky (multipart) |
| POST | `.../panorama/sessions/{id}/finalize` | Spuštění stitchingu |
| GET | `.../panorama/sessions/{id}` | Stav session |
| GET | `.../panorama/sessions` | Seznam sessions |
| POST | `.../panorama/sessions/{id}/activate` | Nastavení aktivního panoramatu |

### PanoramaCallbackController — `/api/v1/internal/panorama` (interní)

| Metoda | Cesta | Popis |
|--------|-------|-------|
| POST | `/api/v1/internal/panorama/callback` | Callback z Python stitcheru |

### OwnerOnboardingController — `/api/v1/owner/restaurant` (OWNER)

| Metoda | Cesta | Popis |
|--------|-------|-------|
| GET | `.../me` | Moje restaurace |
| PUT | `.../me/info` | Aktualizace info |
| PUT | `.../me/hours` | Aktualizace otevíracích hodin |
| GET | `.../me/tables` | Seznam stolů |
| POST | `.../me/tables` | Přidání stolu |
| PUT | `.../me/tables/{id}` | Aktualizace stolu |
| DELETE | `.../me/tables/{id}` | Smazání stolu |
| GET | `.../me/onboarding-status` | Stav onboardingu |
| POST | `.../me/publish` | Publikace restaurace |

### OwnerClaimController — `/api/v1/owner/claim`

| Metoda | Cesta | Popis |
|--------|-------|-------|
| POST | `.../ares` | ARES vyhledávání podle IČO |
| POST | `.../bankid` | BankID verifikace |
| POST | `.../email/start` | Zahájení email verifikace |
| POST | `.../email/confirm` | Potvrzení email kódu |

### DiningContextController + UploadController

| Metoda | Cesta | Popis | Zabezpečení |
|--------|-------|-------|-------------|
| GET | `/api/v1/dining-context/me` | Aktivní dining kontext | authenticated |
| POST | `/api/v1/uploads` | Upload souboru (multipart) | OWNER/MANAGER |

---

## JWT A SPRING SECURITY (přesně z kódu)

### JwtServiceImpl
- **Třída:** `com.checkfood.checkfoodservice.security.module.jwt.service.JwtServiceImpl`
- **Algoritmus:** HS256 (HMAC-SHA256)
- **Klíč:** `JwtProperties.secret` (min 32 znaků) → `SecretKeySpec("HmacSHA256")`
- **Encoder/Decoder:** Spring OAuth2 `NimbusJwtEncoder` / `NimbusJwtDecoder`

**Claims v access tokenu:**
- `iss` = "checkfood" (konfigurovatelný)
- `iat` = čas vydání
- `exp` = iat + accessTokenExpirationSeconds (default 900s = 15 min, v produkci 3600s = 1h)
- `sub` = email uživatele
- `roles` = Set názvů rolí (např. ["USER"], ["OWNER"])
- `type` = "ACCESS"
- `deviceIdentifier` = UUID zařízení (volitelný)

**Claims v refresh tokenu:**
- Stejná struktura, ale `type` = "REFRESH", `exp` = iat + refreshTokenExpirationSeconds (default 2,592,000s = 30 dní, v produkci 86,400s = 24h)
- BEZ `roles` claim

**Metody:**
- `generateAccessToken(UserEntity, deviceId)` — generuje ACCESS token
- `generateRefreshToken(UserEntity, deviceId)` — generuje REFRESH token
- `extractEmail(token)` — dekóduje token, vrací `jwt.getSubject()`
- `extractDeviceIdentifier(token)` — extrahuje deviceIdentifier claim
- `validateToken(token)` — dekóduje token; true pokud bez výjimky
- `isTokenValid(token, user)` — kontroluje email == user.email, expiresAt > now, type == "ACCESS"
- `refreshTokens(refreshToken)` — validuje REFRESH typ, načte uživatele, generuje nový pár
- `isRefreshToken(token)` — kontroluje type == "REFRESH"

### SecurityConfig (SecurityFilterChain)
- **Třída:** `com.checkfood.checkfoodservice.security.config.SecurityConfig`
- CORS defaults, CSRF disabled, stateless sessions
- Exception handling: `JwtAuthenticationEntryPoint` (401), `JwtAccessDeniedHandler` (403)

**Pravidla (permitAll):**
- `/api/auth/register`, `/api/auth/register-owner`, `/api/auth/login`, `/api/auth/verify`, `/api/auth/resend-code`, `/api/auth/refresh`, `/api/auth/logout`
- `/api/oauth/**`
- `/v3/api-docs/**`, `/swagger-ui/**`, `/swagger-ui.html`
- `/actuator/health`, `/actuator/health/**`, `/actuator/info`
- `/api/v1/internal/**` (stitcher callback)
- `/panoramas/**`, `/uploads/**`
- **Vše ostatní:** `.anyRequest().authenticated()`
- **JWT filter:** `JwtAuthenticationFilter` before `UsernamePasswordAuthenticationFilter`

### JwtAuthenticationFilter
- **Třída:** `com.checkfood.checkfoodservice.security.module.jwt.filter.JwtAuthenticationFilter`
- Extends `OncePerRequestFilter`
- Čte `Authorization` header; pokud null nebo nezačíná "Bearer " → přeskočí
- Extrahuje token, volá `jwtService.extractEmail(token)`
- Načte uživatele přes `userService.findWithRolesByEmail(email)`
- Volá `jwtService.isTokenValid(token, user)` → pokud valid: vytvoří `UsernamePasswordAuthenticationToken(user, null, user.getAuthorities())`, nastaví SecurityContext
- Na výjimku loguje WARN, NEpřeruší filtrový řetězec

### UserDetailsService
- **Definováno v:** `SecurityBeansConfig` jako lambda bean
- Načítá uživatele z `UserRepository.findByEmail(username)`
- `PasswordEncoder`: `BCryptPasswordEncoder(12)` — strength 12

### Rate Limiting (AOP)
- **Anotace:** `@RateLimited(key, limit, duration, unit, perIp, perUser)`
- **Implementace:** `InMemoryRateLimitService` — sliding window s `ConcurrentHashMap`
- IP extrakce: `request.getRemoteAddr()` (bez X-Forwarded-For)
- Při překročení limitu: publikuje `AuditEvent(RATE_LIMIT_EXCEEDED, BLOCKED)`

---

## FLUTTER — KOMPLETNÍ PŘEHLED

### Struktura lib/

```
lib/
├── main.dart                           # Entry point, env detection, DI init
├── app.dart                            # MaterialApp, theme, locale
├── core/
│   ├── di/injection_container.dart     # GetIt registrace (12 sekcí)
│   ├── theme/                          # AppColors, AppTypography, AppSpacing, AppRadius, AppTheme, Elevation
│   ├── locale/locale_cubit.dart        # Cubit pro přepínání jazyka (cs/en)
│   ├── services/                       # GooglePlacesService
│   ├── utils/                          # LocationService, AppNotifications
│   ├── constants/                      # Stubs (app_routes, breakpoints)
│   └── state/                          # Stubs (app_state, cart_state)
├── navigation/
│   ├── app_router.dart                 # Named routes: /, /login, /register, /register-owner, /main, ...
│   ├── route_guards.dart               # RootGuard — auth-based routing
│   └── main_shell.dart                 # Bottom nav tabs, role-aware (5 tabs)
├── security/
│   ├── config/security_endpoints.dart  # API path constants
│   ├── data/
│   │   ├── datasources/               # AuthRemoteDataSource, ProfileRemoteDataSource, OAuthRemoteDataSource
│   │   ├── local/token_storage.dart    # Secure storage (access/refresh/device tokens)
│   │   ├── models/                     # Freezed request/response models + toEntity()
│   │   └── repositories/              # AuthRepositoryImpl, OAuthRepositoryImpl, ProfileRepositoryImpl
│   ├── domain/
│   │   ├── entities/                   # User, UserProfile, AuthTokens, AuthFailure, Device
│   │   ├── enums/user_role.dart        # UserRole enum (customer, employee, manager, owner)
│   │   ├── repositories/              # Abstract contracts
│   │   └── usecases/                  # Login, Register, Logout, Refresh, OAuth, Profile, Device...
│   ├── interceptors/
│   │   ├── auth_interceptor.dart       # QueuedInterceptor, Bearer token, 401 refresh
│   │   └── refresh_token_manager.dart  # Completer-based deduplication
│   ├── presentation/
│   │   ├── bloc/auth/                  # AuthBloc (events, states, bloc)
│   │   ├── bloc/user/                  # UserBloc (events, states, bloc)
│   │   ├── pages/auth/                 # LoginPage, RegisterPage, EmailVerificationScreen
│   │   ├── pages/user/                 # ProfileScreen, PersonalDataScreen, DeviceManagementScreen
│   │   └── widgets/                    # LoginForm, RegisterForm, PasswordStrengthIndicator, ...
│   ├── utils/converters/              # DurationEpochConverter
│   ├── validators/                    # AuthValidators, PasswordValidator
│   └── exceptions/                    # Auth, OAuth, MFA, User exceptions
├── components/                         # Reusable UI: buttons/, cards/, dialogs/, feedback/, inputs/, layout/
├── features/
│   ├── splash/                         # SplashScreen (5 animation controllers)
│   ├── onboarding/                     # 4-page onboarding PageView
│   └── explore/                        # Legacy prototype screens (superseded by modules/)
├── modules/
│   ├── customer/
│   │   ├── restaurant/                 # ExploreBloc + RestaurantDetailBloc, Google Maps, PostGIS markers
│   │   ├── reservation/                # ReservationBloc + MyReservationsBloc, 3D WebView panorama, recurring, change requests
│   │   └── orders/                     # OrdersBloc, cart management, dining context
│   ├── management/
│   │   ├── my_restaurant/              # MyRestaurantBloc, restaurant info/employees CRUD, permissions, multi-restaurant
│   │   └── staff_reservations/         # StaffReservationsBloc, 15s polling, status transitions, propose change, extend
│   ├── owner/
│   │   ├── claim/                      # OwnerClaimBloc, ARES + BankID + email verification
│   │   └── onboarding/                 # OnboardingWizardBloc, 6-step wizard, panorama capture + editor
│   ├── shared/                         # (prázdné — připraveno pro messaging, review)
│   └── staff/                          # (prázdné — připraveno pro shift, table_service)
└── l10n/                               # app_cs.arb (430 klíčů), app_en.arb, generated localizations
```

### State management — BLoC pattern

| BLoC | Events | States | Co řídí |
|------|--------|--------|---------|
| `AuthBloc` | AppStarted, LoginRequested, RegisterRequested, RegisterOwnerRequested, VerifyEmailRequested, ResendCodeRequested, GoogleLoginRequested, AppleLoginRequested, LogoutRequested | initial, loading, authenticated(User), unauthenticated, verificationRequired(email), registerSuccess, failure(AuthFailure) | Autentizační flow celé aplikace |
| `UserBloc` | ProfileRequested, DevicesRequested, ProfileUpdated, PasswordChangeRequested, AllDevicesLogoutRequested, DeviceLoggedOut, DeviceDeleted, AllDevicesDeleteRequested, ClearDataRequested, NotificationPreferenceRequested, NotificationToggled, ProfilePhotoUploadRequested | initial, loading, loaded(UserProfile, devices, notifications), failure, passwordChangeSuccess | Uživatelský profil, zařízení, notifikace, logout cascade |
| `ExploreBloc` | InitializeRequested, PermissionResultReceived, RefreshRequested, MarkerSelected, MapBoundsChanged(300ms debounce), SearchChanged(400ms debounce) | initial, loading, loaded(ExploreData), permissionRequired, error | Mapa restaurací, vyhledávání, filtry, paralelní API volání (markery + nearest) |
| `RestaurantDetailBloc` | LoadDetailRequested, ToggleFavourite | initial, loading, loaded(Restaurant), error | Detail restaurace, oblíbené (optimistic toggle) |
| `ReservationBloc` | LoadScene, LoadStatuses, SelectTable, ChangeDate, ChangePartySize, SelectTime, SubmitReservation | ReservationState (scene, tableStatuses, slots, selectedTable/Date/Time, submitting, submitSuccess/Conflict/Error) | 3D panorama rezervační flow |
| `MyReservationsBloc` | LoadMyReservations, RefreshMyReservations, ShowAllHistory, CancelReservation, StartEditReservation, EditDateChanged, EditTableChanged, EditTimeSelected, EditPartySizeChanged, SubmitEditReservation, LoadPendingChanges, AcceptChangeRequest, DeclineChangeRequest, CreateRecurringReservation, LoadRecurringReservations, CancelRecurringReservation | MyReservationsState (upcoming, history, editing state, cancel state, pendingChanges, recurringReservations) | Seznam a editace rezervací, change requests, opakující se rezervace |
| `OrdersBloc` | LoadContext, LoadMenu, AddToCart, RemoveFromCart, UpdateCartQuantity, ClearCart, SubmitOrder, LoadCurrentOrders, RefreshOrders | OrdersState (diningContext, menuCategories, cartItems, currentOrders, submitting) | Objednávkový flow s košíkem, auto-cascade (context → menu → orders) |
| `MyRestaurantBloc` | LoadMyRestaurant, SelectRestaurant, UpdateRestaurant, LoadEmployees, AddEmployee, UpdateEmployeeRole, RemoveEmployee, UpdateEmployeePermissions | Initial, Loading, Loaded(restaurant, restaurants, selectedRestaurantId, employees, isUpdating), Error | Management restaurace, multi-restaurant podpora, zaměstnanci + oprávnění |
| `StaffReservationsBloc` | LoadStaffReservations, ChangeDate, Confirm/Reject/CheckIn/CompleteReservation, PollRefresh, LoadTables, ProposeChange, ExtendReservation | StaffReservationsState (selectedDate, reservations, actionInProgress, tables, restaurantId) | Správa rezervací personálem, 15s polling, propose change, extend |
| `OwnerClaimBloc` | LookupAres, VerifyBankId, StartEmailClaim, ConfirmEmailCode | OwnerClaimState (aresCompany, claimResult, emailCodeSent, claimSuccess) | Claim restaurace flow (ARES + BankID + email) |
| `OnboardingWizardBloc` | LoadOnboarding, GoToStep, UpdateInfo/Hours, CRUD tables/menu, panorama operations, Publish | OnboardingWizardState (currentStep 0-5, status, restaurant, tables, categories, sessions, published) | 6-krokový onboarding wizard |
| `LocaleCubit` | setLocale, toggleLocale | Locale (cs_CZ / en) | Přepínání jazyka |

### Klíčové obrazovky

**Zákaznická část:**
- `SplashScreen` — 5 animačních controllerů, po 3.2s routing podle AuthBloc stavu
- `OnboardingScreen` — 4-stránkový PageView s popisem aplikace
- `LoginPage` — email + heslo form, Google/Apple social login tlačítka, odkaz na registraci, verifikační status feedback
- `RegisterPage` — 5 polí (jméno, příjmení, email, heslo, potvrzení), PasswordStrengthIndicator
- `EmailVerificationScreen` — info o odeslaném emailu, resend tlačítko
- `ExplorePage` (~712 řádků) — Google Maps s SlidingUpPanel, custom teardrop/cluster markery, vyhledávání s debounce 400ms, filtry (kuchyně, hodnocení, otevřeno nyní, oblíbené), paralelní API volání (markers + nearest), performance timing logging
- `RestaurantDetailPage` — SliverAppBar s cover image, opening hours s dnešním dnem, favourite + share akce, tlačítko Reserve Table
- `ReservationPage` — WebView s Three.js 3D panoramatem, bidirectional JS komunikace, TableBottomSheet s time sloty a party size
- `ReservationsScreen` — upcoming + history sekce, cancel dialog, EditReservationSheet modal, pending change requests (accept/decline), recurring reservations
- `OrdersPage` — TabBar (Menu + Moje objednávky), CartSummaryBar, NoContextWidget

**Uživatelský profil:**
- `ProfileScreen` — osobní údaje, bezpečnost (heslo, jazyk), notifikace, odkazy na PersonalDataScreen a DeviceManagementScreen
- `PersonalDataScreen` — editace jména, příjmení, telefonu, adresy
- `DeviceManagementScreen` — seznam aktivních zařízení, soft/hard logout, delete all

**Administrační/management část:**
- `MyRestaurantPage` — TabBar s role-based viditelností (Reservations, Info, Employees, Panorama), multi-restaurant výběr
- `StaffReservationsPage` — date picker ±1 den, 15s auto-polling, akční tlačítka (confirm/reject/check-in/complete), propose change, extend reservation, timeline view s tabulkami
- `ClaimRestaurantPage` — 3-krokový flow (ICO → ARES → BankID → email fallback)
- `OwnerRegisterPage` — registrace jako vlastník restaurace
- `OnboardingWizardPage` — 6 kroků (Info, Hours, Tables, Menu, Panorama, Summary), LinearProgressIndicator
- `PanoramaCaptureScreen` — kamera + gyroskop, 8 snímků s angle guidance
- `PanoramaEditorScreen` — Three.js WebView editor pro úpravu panoramatu, placement stolů

### HTTP klient (Dio)

- **Base URL:** z .env souboru (`API_BASE_URL`); produkce: `https://checkfood-api.onrender.com/api`; local: `http://10.0.2.2:8081/api`
- **Dvě instance:** `dioAuth` (bez interceptoru, pro auth endpointy), default Dio (s `AuthInterceptor`)
- **Guard Interceptor:** detekuje duplicitní `/api/api/` cesty v debug mode
- **AuthInterceptor (QueuedInterceptor):**
  - `onRequest`: čte access token z `TokenStorage`, přidává `Authorization: Bearer <token>`; přeskakuje `/api/auth/refresh`
  - `onError` (401): deleguje na `RefreshTokenManager.refreshToken()` s Completer-based deduplikací; při úspěchu retry s novým tokenem; při selhání logout
- **Model mapping:** Freezed models s `fromJson` factory + `toEntity()` konverze na doménové entity
- **Error handling:** AuthRepositoryImpl mapuje HTTP statusy: 401 → InvalidCredentialsException, 403 → AccountDisabledException/AccountNotVerifiedException, 409 → EmailAlreadyExistsException, 410 → AccountNotVerifiedException (expired), 429 → rate limit

### Lokalizace
- **Defaultní jazyk:** čeština (`cs_CZ`)
- **Sekundární:** angličtina (`en`)
- **Implementace:** flutter_localizations + l10n.yaml + ARB soubory (430 klíčů)
- **Přepínání:** `LocaleCubit` s persistencí do SharedPreferences

### Design systém (theme)
- **Primary color:** #10B981 (Emerald green)
- **Primary Light:** #D1FAE5 (Emerald 100)
- **Primary Dark:** #059669 (Emerald 700)
- **Brand Dark:** #1A3C40 (teal)
- **Gradient (splash):** #0F2027 → #203A43 → #2C5364
- **Sémantické:** Success #059669, Warning #D97706, Error #DC2626, Info #2563EB
- **Text:** Primary #1A1A1A, Secondary #6B7280, Muted #9CA3AF
- **Background:** #FAFAFA, Surface: #FFFFFF
- **Material 3** enabled, light theme only

---

## VĚCI V KÓDU, KTERÉ CHYBÍ V DIPLOMCE

1. **PostGIS a prostorové dotazy** — backend používá PostgreSQL s PostGIS rozšířením pro geometrické operace (Point, SRID 4326, DBSCAN clustering markerů na mapě, K-NN proximity search). Diplomka o tomto vůbec nemluví. → **Vlastní sekce v kap. 3 (Návrh databáze) + zmínka v kap. 4 (Backend)**

2. **OAuth2 (Google + Apple Sign-In)** — kompletní implementace OAuth přihlášení s verifikací ID tokenů, account linking logikou, Apple SigningKey cache. Diplomka nezmiňuje. → **Sekce v rámci 4.1.X (Zabezpečení API)**

3. **MFA/TOTP** — dvoufaktorová autentizace s TOTP (RFC 6238), QR kódy, 8 záložních kódů (BCrypt hashed). → **Sekce v rámci 4.1.X (Zabezpečení API)**

4. **Audit systém** — kompletní AOP-based audit logging (18 typů akcí, 3 stavy, denní cleanup, admin UI). → **Sekce v rámci 4.1.X nebo vlastní podsekce**

5. **Rate limiting** — AOP-based sliding window rate limiter s per-IP/per-User granularitou, 14 chráněných endpointů. → **Sekce v rámci 4.1.X (Zabezpečení API)**

6. **Panorama stitching microservice** — Python FastAPI + OpenCV stitching + Supabase Storage, async background task s callback. → **Vlastní sekce v kap. 4 (Implementace)**

7. **3D panorama rezervace** — Three.js WebView s bidirectional JS komunikací pro výběr stolu v 360° panoramatu. → **Sekce v rámci 4.2 (Flutter)**

8. **Overture Maps integrace** — DuckDB čtení S3 Parquet souborů pro synchronizaci restaurací z Overture Maps. → **Sekce v kap. 4 (Backend) nebo kap. 3**

9. **Owner onboarding wizard** — 6-krokový wizard (info, hodiny, stoly, menu, panorama, souhrn) s validací a publish. → **Sekce v rámci 4.2 (Flutter)**

10. **Owner claim flow** — ARES vyhledávání IČO + BankID verifikace + email fallback pro ověření vlastníka restaurace. → **Sekce v rámci 4.2 (Flutter) nebo vlastní**

11. **Dining context** — server-side kontext pro objednávky navázaný na aktivní rezervaci s grace window. → **Sekce v rámci 4.1 (Backend)**

12. **Domain event systém** — ApplicationEventPublisher s async listenery pro OrderCreated, UserRegistered, ReservationExpired, Job events. → **Zmínka v architektuře (kap. 2)**

13. **Feature flags** — Strategy pattern s BooleanFeatureResolver, PercentageFeatureResolver, UserBasedFeatureResolver. → **Zmínka v architektuře**

14. **CI/CD pipelines** — 5 GitHub Actions workflows včetně auto-monitoring a health checks. → **Sekce v kap. 5 nebo vlastní podsekce v kap. 4**

15. **Supabase místo GCP** — produkce běží na Render.com + Supabase (PostgreSQL + Storage), ne na GCP jak diplomka popisuje. → **OPRAVA v existující sekci o nasazení**

16. **Java 21 místo Java 17** — kód používá JDK 21 s Project Loom (virtual threads), diplomka uvádí JDK 17. → **OPRAVA**

17. **Komplexní role systém** — role jsou entity v DB (ManyToMany s permissions), ne enum jak diplomka popisuje. → **OPRAVA v kap. 4**

18. **MapStruct** — DTO mapping framework použitý namísto manuálního mapování. → **Zmínka v kap. 4**

19. **Lokalizace (cs/en)** — flutter_localizations s 430 klíči, přepínání jazyka. → **Sekce v kap. 4.2**

20. **Reservation auto-confirm job** — @Scheduled cron job pro automatické potvrzení nevyřízených rezervací po 15 minutách. → **Zmínka v business logice**

21. **Recurring reservations** — opakující se týdenní rezervace (zákazník vytváří, staff potvrzuje/odmítá, automatická generace instancí). → **Sekce v rámci 4.1 (Backend) + 4.2 (Flutter)**

22. **Reservation change requests** — staff může navrhnout změnu času/stolu zákazníkovi, zákazník přijme/odmítne. Bidirectional workflow. → **Sekce v rámci 4.1 + 4.2**

23. **Employee permissions** — granulární oprávnění per zaměstnanec (11 typů), výchozí sady dle role, editovatelné vlastníkem. → **Sekce v rámci 4.1 (Backend)**

24. **Special days** — restaurace může definovat speciální dny (svátky, zavřeno, zkrácená otevírací doba) s poznámkou. → **Zmínka v business logice**

25. **Reservation extend** — staff může prodloužit rezervaci (nastavit end_time). → **Zmínka v business logice**

26. **Google Places API** — klientská integrace pro vyhledávání restaurací (searchNearby, searchText) s Google Places API (New). → **Sekce v kap. 4.2 (Flutter)**

27. **Soft/hard device logout** — dvouúrovňový systém odhlášení zařízení: soft logout (deaktivace) vs hard delete (smazání). → **Zmínka v zabezpečení**

28. **Multi-restaurant support** — vlastník/manažer může spravovat více restaurací, výběr aktivní restaurace v UI. → **Zmínka v kap. 4.2**

---

## VĚCI V DIPLOMCE, KTERÉ CHYBÍ V KÓDU

1. **GCP nasazení** — diplomka popisuje GCP Compute Engine E2-micro, Debian 12, PostgreSQL přímou instalaci. Kód je nasazen na Render.com + Supabase. → **Buď přepsat sekci na Render/Supabase, nebo zmínit jako historickou fázi vývoje a přidat aktuální stav.**

2. **Platby** — diplomka zmiňuje platby v požadavcích. V kódu existují pouze stub třídy (`StripePaymentClient`, `MockPaymentClient`) bez implementace. → **Zmínit jako plánované rozšíření.**

3. **Push notifikace** — firebase_messaging je v pubspec.yaml a FCM token v DeviceEntity, ale implementace odesílání notifikací chybí. → **Zmínit jako plánované rozšíření.**

4. **Statistiky** — diplomka zmiňuje statistiky v požadavcích. V kódu jsou pouze stub monitoring třídy (`BusinessMetricsService`). → **Zmínit jako plánované rozšíření.**

5. **Flyway migrace** — kód má Flyway enabled v produkci s `baseline-on-migrate=true`, ale adresář `db/migration/` je prázdný. Schéma řídí Hibernate DDL auto. → **Zmínit přechodný stav, doporučit migraci na Flyway.**

6. **WebSocket** — kód neobsahuje žádnou WebSocket implementaci. → **Pokud diplomka zmiňuje real-time, upřesnit že polling (15s) je aktuální řešení.**

7. **Caching** — feature flag `CACHE_ENABLED` existuje ale žádná cache implementace. → **Zmínit jako budoucí optimalizaci.**

---

## CO CHCEŠ NAPSAT — ÚKOLY PRO PSANÍ DIPLOMKY

Napiš prosím tyto části. Každou zvlášť jako samostatnou odpověď.

### ÚKOL A: Kapitola 3 — Návrh databáze (cca 8–10 stran)

**3.1 Struktura databázového modelu**
Zdůvodni volbu relačního modelu pro tento typ aplikace (rezervace, uživatelé, stoly — jasně definované vztahy, potřeba referenční integrity a ACID transakcí). Popiš přístup k návrhu entitního modelu vycházejícího z funkčních požadavků z kapitoly 1.2. Zmiň PostGIS rozšíření pro prostorové dotazy.

**3.1.1 Entity a jejich atributy**
Pro každou entitu/tabulku napiš prose odstavec popisující co reprezentuje, jaké má klíčové atributy a proč, jaká omezení jsou na ni kladena. Za každým odstavcem přidej tabulku atributů (Sloupec | Typ | Popis). Zmiňuj konkrétní technická rozhodnutí (GenerationType.IDENTITY vs UUID, @PrePersist pro timestampy, EnumType.STRING pro role, bcrypt strength 12 pro hesla, minor currency units pro ceny, denormalizované snapshoty v OrderItem, Point geometry SRID 4326 pro GPS souřadnice...).

Entity k popisu: UserEntity, RoleEntity, PermissionEntity, DeviceEntity, VerificationTokenEntity, MfaSecretEntity, MfaBackupCodeEntity, AuditLogEntity, Restaurant (+ embedded Address, OpeningHours, SpecialDay), RestaurantTable, TableGroup + TableGroupItem, RestaurantEmployee (+ EmployeePermission), MenuCategory, MenuItem, Reservation, RecurringReservation, ReservationChangeRequest, Order + OrderItem, UserFavouriteRestaurant, PanoramaSession, PanoramaPhoto.

**3.1.2 Vztahy mezi entitami**
Popiš všechny vztahy mezi entitami. Vysvětli proč byly navrženy tímto způsobem — zejména: proč většina cross-aggregate FK je "by value" (UUID/Long sloupce bez JPA join), proč ManyToMany pro role s join tabulkou, proč cascade ALL + orphanRemoval pro Order→OrderItem, proč ElementCollection EAGER pro EmployeePermission. Odkaz na ER diagram ("viz Obrázek X").

**3.2 Optimalizace databáze**
Popiš strategii indexování (composite indexy na reservation table+date, indexy na FK sloupce, unique constrainty). Nastavení HikariCP connection poolu (minimum-idle=2, maximum-pool-size=10 v produkci). Přístup k N+1 problému v JPA (@EntityGraph na UserRepository pro eager loading rolí/zařízení). PostGIS DBSCAN clustering pro map markers s zoom-adaptive epsilon.

**3.3 Implementace v PostgreSQL**
Popiš specifika PostgreSQL implementace — PostGIS rozšíření (CREATE EXTENSION IF NOT EXISTS postgis v @PostConstruct), Hibernate Spatial pro Point geometry, ddl-auto=update ve vývoji, Flyway s baseline-on-migrate=true v produkci (zatím prázdné migrace), doporučený přechod na Flyway validate.

### ÚKOL B: Sekce 4.1.X — Zabezpečení API (cca 5–7 stran)

Napiš sekci popisující implementaci JWT autentizace a RBAC. Popiš přesně:
- **SecurityFilterChain** — CORS, CSRF disabled, stateless, pravidla (permitAll vs authenticated), přidání JWT filtru
- **JwtAuthenticationFilter** — extrakce Bearer tokenu z Authorization headeru, extrakce emailu, načtení uživatele s rolemi (@EntityGraph), validace (email match + expiration + ACCESS type), nastavení SecurityContext
- **JwtServiceImpl** — HS256 s NimbusJwtEncoder/Decoder, generování access (15min/1h) + refresh (30d/24h) tokenů, claims struktura, token rotation při refresh, device binding (deviceIdentifier v claims)
- **UserEntity jako UserDetails** — getUsername() → email, getAuthorities() → ROLE_ prefix
- **Mapování rolí na endpointy** — @PreAuthorize("hasRole('OWNER')"), @PreAuthorize("hasAnyRole('OWNER','MANAGER','STAFF')")
- **Employee permissions** — granulární oprávnění per zaměstnanec (11 typů EmployeePermission), výchozí sady dle role, editovatelné vlastníkem
- **Rate limiting** — @RateLimited AOP anotace, InMemoryRateLimitService (sliding window, ConcurrentHashMap), per-IP/per-User granularita
- **OAuth2 přihlášení** — Google IdToken verifikace, Apple JWT verifikace (JJWT + Apple signing keys via Feign, 24h cache), account linking logika
- **MFA/TOTP** — HmacSHA1, 30s time step, 6 číslic, ±1 window tolerance, 8 backup kódů (BCrypt hashed)
- **Audit logging** — AOP @Async @EventListener, 18 typů akcí, denní cleanup
- **Device management** — soft logout (active flag) vs hard delete, FCM token, multi-device tracking

Používej skutečné názvy tříd z kódu. Krátké ukázky kódu (3–5 řádků) jsou vítány.

### ÚKOL C: Sekce 4.2 — Flutter klientská aplikace (cca 12–15 stran)

**4.2.1 Architektura klientské aplikace**
- Clean Architecture per module: data/ (datasources, models, repositories), domain/ (entities, repositories abstract, usecases), presentation/ (bloc, pages, widgets)
- DI: GetIt s 12 registračními sekcemi; BLoC jako factories, služby jako lazySingletons
- Dva Dio instance: dioAuth (bez interceptoru) pro auth, default s AuthInterceptor + guard interceptor
- Freezed pro immutable modely, events, states; toEntity() konverze; build_runner generování
- stream_transform pro debounce operace v BLoC eventech

**4.2.2 State management — BLoC pattern**
- Zvolený vzor, celý tok dat na příkladu rezervace: `SubmitReservation` event → `ReservationBloc.on<SubmitReservation>` → `CreateReservationUseCase.call()` → `ReservationRepositoryImpl.createReservation()` → `ReservationRemoteDataSource.createReservation()` (Dio POST) → server → response → `ReservationResponseModel.fromJson()` → `model.toEntity()` → emit `state.copyWith(submitSuccess: true)` → `BlocBuilder` rebuilds UI
- Debounce strategie (searchChanged 400ms, mapBoundsChanged 300ms) — implementováno přes stream_transform
- Optimistic updates (favourite toggle)
- Auto-cascade pattern (OrdersBloc: LoadContext → LoadMenu → LoadCurrentOrders)

**4.2.3 Navigace a autentizace**
- Custom AppRouter s named routes
- RootGuard — rozhodovací strom: authenticated owner needsRestaurantClaim → ClaimPage, needsOnboarding → OnboardingWizard, else MainShell; unauthenticated → OnboardingScreen
- MainShell — bottom tabs (5) s role awareness (isAtLeastEmployee → MyRestaurant tab), IndexedStack pro efektivní přepínání, BlocListener pro logout cascade
- AuthInterceptor + RefreshTokenManager — Completer-based deduplikace paralelních 401 refresh požadavků
- Token storage (flutter_secure_storage)

**4.2.4 Implementace klíčových obrazovek**
Pro každou hlavní obrazovku prose odstavec: co zobrazuje, state management, API volání, UX logika:
- ExplorePage (Google Maps + SlidingUpPanel + custom teardrop markery + PostGIS clustering + filtry + vyhledávání + Google Places API integrace)
- RestaurantDetailPage (SliverAppBar, opening hours, favourite)
- ReservationPage (Three.js WebView 3D panorama + JS channel + TableBottomSheet s time sloty)
- ReservationsScreen (upcoming + history, cancel, edit, pending change requests accept/decline, recurring reservations)
- OrdersPage (TabBar Menu/Orders, CartSummaryBar, DiningContext, auto-cascade)
- ProfileScreen + PersonalDataScreen + DeviceManagementScreen (osobní údaje, bezpečnost, zařízení soft/hard logout, jazyk, notifikace)
- MyRestaurantPage (TabBar s role-based viditelností, multi-restaurant podpora, employee permissions)
- StaffReservationsPage (date picker, 15s polling, status transitions, propose change, extend reservation, tables timeline)
- OnboardingWizardPage (6 kroků, panorama capture s kamerou + gyroskopem, panorama editor s Three.js)
- ClaimRestaurantPage (ARES + BankID + email 3-step flow)

**4.2.5 Komunikace s REST API**
- Dio konfigurace, base URL z .env
- AuthInterceptor detailně + guard interceptor
- Model mapping: Freezed fromJson/toJson + toEntity()
- Error handling: mapování HTTP statusů na domain exceptions
- Google Places Service — klientská integrace s Places API (New)

### ÚKOL D: Kapitola 5 — Testování (cca 4–5 stran)

**Backend testy (JUnit 5 + MockMvc):**
- BaseAuthIntegrationTest — sdílená infrastruktura, helper metody, H2 in-memory
- 13 testovacích tříd (+ 1 base třída) pokrývajících: registraci (5 scénářů), login (5), verifikaci emailu (6), refresh token (4), logout (3), protected endpoints (7), OAuth (4), edge cases (3), device management (3), MyRestaurant autorizaci (7), favourites (6), rezervace (26 scénářů ve vnořených skupinách)
- Celkem 79 testovacích metod

**Flutter testy (bloc_test + mocktail):**
- 4 testovací soubory: ReservationBloc (10 testů), RestaurantDetailBloc (6 testů), MyRestaurantBloc (5 testů), MyRestaurantVisibility (7 testů)
- Celkem 28 testovacích metod
- Fake repository pattern vs mocktail mocking
- 1 stale widget_test.dart (default Flutter scaffold — nefunkční)

Popiš testovací strategii, pokrytí, co chybí a proč (frontend unit testy vs integrační), scénáře manuálního testování.

### ÚKOL E: Závěr (cca 1–2 strany)

Shrnutí dosažených výsledků: 110 REST endpointů, 26 databázových entit (vč. embeddables), 12 BLoC tříd, 79 backend + 28 frontend testů, kompletní zákaznický flow (registrace → login → explore → rezervace → objednávka), management flow (správa restaurace, zaměstnanců s granulárními oprávněními, menu, panoramatu), owner onboarding, recurring reservations, reservation change requests. Splnění cílů z úvodu. Přínos práce — inovativní 3D panorama rezervace, PostGIS clustering, ARES/BankID integrace, granulární employee permissions, Google Places API integrace. Možná rozšíření: platební integrace (Stripe stub připraven), push notifikace (FCM token připraven), statistiky a analytics, WebSocket pro real-time, Redis pro distribuovaný rate limiting a cache.

### ÚKOL F: Opravy chyb v existujícím dokumentu

**F1 — Anotace**
Existující anotace mluví o "Teorii her v ekonomii". Napiš správnou pro tuto práci (česky + anglicky, cca 150 slov každá). Zaměř se na: full-stack aplikace pro gastronomii, Flutter + Spring Boot, rezervace stolů s 3D panoramatem, objednávky, JWT autentizace s MFA, PostGIS, Clean Architecture + BLoC, REST API.

**F2 — Literatura**
Existující seznam je z jiné práce. Sestav nový správný seznam ze zdrojů relevantních pro práci + doplň chybějící. Zahrň: Spring Boot dokumentaci, Flutter dokumentaci, BLoC pattern, PostgreSQL + PostGIS, JWT RFC 7519, TOTP RFC 6238, OAuth 2.0, Clean Architecture (Robert C. Martin), REST API design, Freezed/Dart code generation, OpenCV, Three.js, Overture Maps, Docker, Render.com, Supabase.

**F3 — Sekce 1.3.5 Použitelnost a přístupnost**
V obsahu je, ale chybí text. Napiš ji (cca 2 strany): Nielsenovy principy použitelnosti, WCAG přístupnost, Flutter Semantics widget, konkrétní požadavky systému CheckFood (role-aware UI, responsive design, offline indikace, error states, loading states, form validation, lokalizace cs/en).

### ÚKOL G: Kapitoly pro věci z kódu, které v diplomce chybí

Na základě analýzy z "VĚCI V KÓDU, KTERÉ CHYBÍ V DIPLOMCE" navrhuji toto začlenění:

1. **PostGIS a prostorové dotazy** → Nová sekce **3.2.1 Prostorové dotazy a PostGIS** v kap. 3 (2 strany): PostGIS Point geometry, SRID 4326, DBSCAN clustering pro map markers, K-NN proximity search, zoom-adaptive epsilon

2. **OAuth2 + MFA + Audit + Rate limiting + Employee permissions + Device management** → Rozšíření sekce **4.1.X Zabezpečení API** (viz Úkol B, celkem 5-7 stran)

3. **Panorama stitching microservice** → Nová sekce **4.3 Panorama stitcher** (2 strany): FastAPI architektura, OpenCV stitching pipeline, async background tasks, callback pattern, Supabase Storage integrace

4. **3D panorama rezervace** → Součást sekce **4.2.4** u ReservationPage (1.5 strany): Three.js WebView, bidirectional JS communication, angle-based table positioning

5. **Overture Maps integrace** → Nová sekce **4.1.Y Data synchronizace** (1 strana): DuckDB, S3 Parquet, Overture Maps, cron sync, upsert + soft-delete stale

6. **Owner claim flow (ARES + BankID)** → Součást sekce **4.2.4** u ClaimRestaurantPage (1 strana): ARES API, BankID mockup, email fallback

7. **Owner onboarding wizard** → Součást sekce **4.2.4** u OnboardingWizardPage (1.5 strany): 6 kroků, validace, panorama capture s kamerou + gyroskopem, panorama editor s Three.js

8. **CI/CD pipelines** → Nová sekce **4.4 Continuous Integration a Deployment** (2 strany): 5 GitHub Actions workflows, auto-monitoring, health checks, Render.com deployment

9. **Dining context + objednávky** → Součást sekce **4.1.Z Business logika** (1 strana): server-side kontext navázaný na rezervaci, grace window, server-side price calculation

10. **Lokalizace** → Součást sekce **4.2.1** (0.5 strany): flutter_localizations, ARB soubory, 430 klíčů, LocaleCubit

11. **Recurring reservations + Change requests** → Nová sekce **4.1.A Pokročilé rezervační funkce** (2 strany): opakující se rezervace, návrhy změn (staff→customer), bidirectional workflow, extend reservation

12. **Google Places API** → Součást sekce **4.2.4** u ExplorePage (0.5 strany): GooglePlacesService, searchNearby, searchText, field mask

13. **OPRAVA: GCP → Render.com + Supabase** → Přepsat existující sekci o nasazení. Zmínit GCP jako historickou fázi, popsat aktuální Render.com + Supabase.

14. **OPRAVA: Java 17 → Java 21** → Opravit v existující sekci o inicializaci projektu. Zmínit Project Loom (virtual threads).

15. **OPRAVA: Role enum → Role entity** → Opravit v existující sekci o User entitě. Popsat ManyToMany s join tabulkou a RBAC.

---

## POKYNY PRO PSANÍ

1. Piš v trpném rodě nebo třetí osobě
2. Každou technologii nejprve obecně představ, pak konkrétně v CheckFood
3. Používej skutečné názvy tříd, metod, endpointů z kódu (viz výše)
4. Nepoužívej odrážky uvnitř odstavců — plynulá próza; výjimku tvoří přehledové tabulky
5. Konzistence s existující prací: monolitická architektura (s panorama stitcher jako výjimka — microservice), Render.com + Supabase (ne GCP), Docker, role USER/OWNER/MANAGER/STAFF/HOST/ADMIN
6. Citace ve formátu [číslo]
7. Ceny v systému jsou v minor currency units (haléře) — int, ne BigDecimal — vysvětli proč (přesnost, žádné floating-point chyby)
8. Zdůrazni inovativní prvky: 3D panorama rezervace, PostGIS clustering na backendu (ne na klientu), owner claim přes ARES/BankID, Overture Maps sync, recurring reservations, reservation change requests, granulární employee permissions, Google Places API integrace

Začni Úkolem F1 (oprava anotace).
