# CLAUDE.md — Operational Manual for Claude Code

This file is the single source of truth for Claude Code when working on the CheckFood repository. Read it before making any changes.

---

## 1. Project Overview

**CheckFood** is a full-stack restaurant discovery, ordering, and reservation platform.

| Component         | Location                      | Tech                                                    |
| ----------------- | ----------------------------- | ------------------------------------------------------- |
| Backend API       | `checkfood_service/`          | Java 21, Spring Boot 3.5.7, PostgreSQL 15 + PostGIS 3.4 |
| Mobile App        | `checkfood_client/`           | Flutter 3.7+, Dart, BLoC pattern                        |
| Panorama Stitcher | `checkfood_service/stitcher/` | Python 3.12, FastAPI, OpenCV                            |
| Root POM          | `pom.xml`                     | Maven aggregator (backend module only)                  |

**License:** MIT (Copyright 2025 RJ-B)

---

## 2. Repository Structure (Depth 3)

```
CheckFood/
├── checkfood_service/                  # Backend
│   ├── src/main/java/com/checkfood/checkfoodservice/
│   │   ├── audit/                      # Security audit tracking
│   │   ├── client/                     # External service clients (mail, payment)
│   │   ├── config/                     # Global config (OpenAPI, Jackson, PostGIS, Clock)
│   │   ├── event/                      # Domain events (base, application, audit, scheduler)
│   │   ├── exception/                  # Global exception handling
│   │   ├── feature/                    # Feature flags (model, resolver, service)
│   │   ├── listener/                   # Event subscribers
│   │   ├── logging/                    # AOP logging, filters, masking
│   │   ├── module/                     # Business domains ↓
│   │   │   ├── dining/                 #   Dining context
│   │   │   ├── exception/              #   Module-level exceptions
│   │   │   ├── favourite/              #   Favourite restaurants
│   │   │   ├── initializer/            #   Data seeding
│   │   │   ├── menu/                   #   Menu management
│   │   │   ├── order/                  #   Order processing
│   │   │   ├── owner/                  #   Restaurant owner portal
│   │   │   ├── panorama/               #   Panorama stitching integration
│   │   │   ├── reservation/            #   Reservation system
│   │   │   ├── restaurant/             #   Restaurant discovery & management
│   │   │   └── storage/                #   File upload/storage
│   │   ├── monitoring/                 # Health, metrics, tracing
│   │   ├── scheduler/                  # Cron jobs + distributed locking
│   │   └── security/                   # Auth subsystem ↓
│   │       ├── audit/                  #   Audit logging
│   │       ├── config/                 #   SecurityConfig, CORS, MethodSecurity
│   │       ├── module/auth/            #   Registration, login, verification
│   │       ├── module/jwt/             #   JWT generation, validation, filter
│   │       ├── module/mfa/             #   TOTP multi-factor auth
│   │       ├── module/oauth/           #   Google + Apple OAuth2
│   │       ├── module/user/            #   UserEntity, roles, devices
│   │       └── ratelimit/              #   @RateLimited annotation + AOP
│   ├── src/main/resources/
│   │   ├── application.properties      # Base config
│   │   ├── application-local.properties # Dev profile (DDL auto, verbose logs)
│   │   ├── application-prod.properties  # Prod profile (Render.com)
│   │   └── db/migration/               # Flyway (empty — using Hibernate DDL for now)
│   ├── src/test/java/                  # Integration tests (JUnit 5 + MockMvc)
│   ├── stitcher/                       # Python panorama microservice
│   ├── pom.xml                         # Maven config
│   ├── Dockerfile                      # Multi-stage Java 21 build
│   ├── docker-compose.yml              # Full stack (DB + stitcher + app)
│   └── .env.example                    # Environment variable template
│
├── checkfood_client/                   # Frontend
│   ├── lib/
│   │   ├── main.dart                   # Entry point + DI init
│   │   ├── app.dart                    # MaterialApp + MultiBlocProvider
│   │   ├── components/                 # Reusable UI (buttons, cards, dialogs, inputs)
│   │   ├── core/                       # Shared infra ↓
│   │   │   ├── constants/              #   Routes, breakpoints
│   │   │   ├── di/                     #   GetIt injection_container.dart
│   │   │   ├── error/                  #   Exception classes
│   │   │   ├── network/                #   Dio interceptors
│   │   │   ├── theme/                  #   Colors, typography, spacing, radius
│   │   │   └── utils/                  #   LocationService, UI helpers
│   │   ├── features/                   # High-level screens (splash, onboarding, explore)
│   │   ├── modules/                    # Clean Architecture modules ↓
│   │   │   ├── customer/               #   explore, restaurant, reservation, orders
│   │   │   ├── management/             #   dashboard, menu_editor, staff_reservations
│   │   │   ├── owner/                  #   onboarding wizard, claim restaurant
│   │   │   ├── shared/                 #   messaging, review
│   │   │   └── staff/                  #   shift, table_service
│   │   ├── navigation/                 # app_router, route_guards, main_shell
│   │   └── security/                   # Auth data/domain/presentation layers
│   ├── pubspec.yaml
│   ├── test/                           # unit/, widget/, integration/
│   └── assets/                         # images, icons, animations, panoramas
│
├── .github/workflows/                  # CI pipelines
│   ├── backend.yml                     # Build + test + Docker verify
│   ├── flutter-android.yml             # Build APK artifact
│   └── flutter-android-release.yml     # Build + GitHub Release
├── render.yaml                         # Render.com deployment
├── CLAUDE.md                           # This file
├── README.md                           # Project documentation
└── LICENSE                             # MIT
```

---

## 3. Tech Stack

### Backend

| Category        | Technology                        | Version                       |
| --------------- | --------------------------------- | ----------------------------- |
| Language        | Java                              | 21                            |
| Framework       | Spring Boot                       | 3.5.7                         |
| Security        | Spring Security                   | 6.4.3                         |
| ORM             | Hibernate JPA + Hibernate Spatial | —                             |
| Database        | PostgreSQL + PostGIS              | 15 + 3.4                      |
| JWT             | JJWT (io.jsonwebtoken)            | 0.12.6                        |
| Mapping         | MapStruct                         | 1.5.5.Final                   |
| Lombok          | Lombok                            | 1.18.32                       |
| API Docs        | springdoc-openapi (Swagger)       | 2.8.5                         |
| Cloud           | Spring Cloud OpenFeign            | 2025.0.0                      |
| Email           | spring-boot-starter-mail          | —                             |
| Monitoring      | spring-boot-starter-actuator      | —                             |
| Build           | Maven (mvnw wrapper)              | 3.9+                          |
| Analytics       | DuckDB JDBC                       | 1.4.4.0 (Overture Maps)       |
| Virtual Threads | Project Loom                      | Enabled                       |

### Frontend

| Category         | Technology                          | Version       |
| ---------------- | ----------------------------------- | ------------- |
| Framework        | Flutter                             | ^3.7.2        |
| State Management | flutter_bloc                        | 8.1.6         |
| Navigation       | go_router                           | 14.0.0        |
| DI               | get_it                              | 7.7.0         |
| HTTP             | dio                                 | 5.4.3         |
| Models           | freezed + json_serializable         | 2.4.1 / 6.8.0 |
| Secure Storage   | flutter_secure_storage              | 9.2.2         |
| Maps             | google_maps_flutter                 | 2.10.0        |
| OAuth            | google_sign_in / sign_in_with_apple | 6.2.1 / 6.1.1 |
| Testing          | bloc_test + mocktail                | 9.1.7 / 1.0.4 |

### Stitcher

| Category         | Technology        | Version          |
| ---------------- | ----------------- | ---------------- |
| Runtime          | Python            | 3.12             |
| Framework        | FastAPI + Uvicorn | 0.115.6 / 0.34.0 |
| Image Processing | OpenCV (headless) | 4.10.0.84        |
| HTTP Client      | httpx             | 0.28.1           |

---

## 4. Build & Run Commands

### Prerequisites

- Java 21 JDK (Eclipse Temurin), Maven 3.8+ or mvnw
- Flutter SDK >= 3.7.2
- Docker + Docker Compose
- PostgreSQL 15 (or use Docker)

### Backend

```bash
cd checkfood_service
cp .env.example .env              # first time — fill in credentials
docker compose up -d               # start PostgreSQL + PostGIS, stitcher, app
./mvnw spring-boot:run             # run outside Docker (requires DB running)
./mvnw test                        # run integration tests (uses H2 + test profile)
mvn clean package -DskipTests      # build JAR
```

- Server: port **8081**
- Swagger UI: `/swagger-ui.html`
- Health check: `/actuator/health`

### Frontend

```bash
cd checkfood_client
cp .env.example .env               # set API_BASE_URL
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generate Freezed/JSON
flutter run                        # launch on connected device/emulator
```

- Default API URL (Android emulator): `http://10.0.2.2:8081/api`
- Watch mode: `dart run build_runner watch --delete-conflicting-outputs`

### Full Docker Stack

```bash
cd checkfood_service && docker compose up -d
# db        → PostgreSQL 15 + PostGIS 3.4 on :5432
# stitcher  → FastAPI on :8090
# app       → Spring Boot on :8081
```

### Database

- **Local dev**: Hibernate `ddl-auto=update` (no migrations needed)
- **Production**: Flyway enabled, `baseline-on-migrate=true`
- **NEJISTE**: Flyway migration directory is empty — schema is still managed by Hibernate DDL auto. Verify before switching to `validate` mode.
- No manual migration commands needed yet.

---

## 5. Architecture Deep Dive

### 5.1 Backend Architecture

**Layering pattern** (each business module):

```
Controller (@RestController)
    ↓ receives @Valid @RequestBody DTOs
Service (@Service)
    ↓ business logic, publishes domain events
Repository (extends JpaRepository)
    ↓ database access
Entity (@Entity, @Table)
```

**DTO mapping**: MapStruct `@Mapper(componentModel = "spring")` mappers convert between entities and request/response DTOs. Mappers are Spring beans.

**Dual controller pattern**: Customer-facing and owner-facing endpoints are separate controllers (e.g., `MenuController` vs `OwnerMenuController`).

**Security flow**:

```
HTTP Request → JwtAuthenticationFilter → SecurityConfig (permitAll / authenticated)
    → @PreAuthorize / @RateLimited on controller method
    → Service logic
```

**JWT lifecycle**:

- Access token: default 3600s (1 hour), configurable via `JWT_EXPIRES`
- Refresh token: default 86400s (24 hours), configurable via `JWT_REFRESH`
- Device identifier embedded in tokens for multi-device management
- Token rotation on refresh

**Domain event system**:

```
Service publishes → ApplicationEventPublisher.publishEvent(new XxxEvent(...))
Listener receives → @EventListener(XxxEvent.class)
```

Events: `OrderCreatedEvent`, `UserRegisteredEvent`, `ReservationExpiredEvent`, `JobStarted/Finished/FailedEvent`

**Rate limiting** (AOP-based):

```java
@RateLimited(key = "auth:login", limit = 10, duration = 15, unit = TimeUnit.MINUTES, perIp = true)
```

In-memory sliding window implementation.

**Feature flags** (strategy pattern):

```java
if (featureService.isEnabled(FeatureFlag.SOME_FEATURE)) { ... }
```

Resolvers: `BooleanFeatureResolver`, `PercentageFeatureResolver`, `UserBasedFeatureResolver`.

**Scheduler**: `@Scheduled` cron jobs with `DistributedLockProvider` for cluster safety.

- `AuditCleanupJob` — delete old audit logs (retention configurable)
- `OrderCleanupJob` — clean abandoned orders
- `ReservationAutoConfirmJob` — auto-confirm past grace period
- `ReservationExpirationJob` — **TODO: not yet implemented**

### 5.2 Frontend Architecture

**Clean Architecture per module**:

```
data/
├── datasources/     # Remote API calls (Dio)
├── models/          # Freezed DTOs with fromJson/toJson + toEntity()
└── repositories/    # Repository implementations

domain/
├── entities/        # Freezed business models (immutable)
├── repositories/    # Abstract contracts
└── usecases/        # Single-responsibility business logic

presentation/
├── bloc/            # BLoC (events → state machine → emit state)
├── pages/           # Full screens
└── widgets/         # Module-specific UI components
```

**State management**: BLoC pattern (flutter_bloc).

- States and events are `@freezed` sealed classes
- BLoCs registered as **factories** in GetIt (fresh per use)
- Other services as **lazySingletons**

**DI setup** (`core/di/injection_container.dart`):

- Dual Dio instances: `dioAuth` (no interceptor, for login/register) and `dioMain` (with AuthInterceptor)
- 12+ registration sections covering storage, network, datasources, repos, use cases, BLoCs

**Auth flow**:

```
App start → SplashScreen → AuthBloc.add(AppStarted)
    → CheckAuthStatusUseCase (token in secure storage?)
    → Authenticated → MainShell (role-aware bottom nav)
    → Unauthenticated → Onboarding or LoginPage
```

**Token refresh**: `AuthInterceptor` catches 401, delegates to `RefreshTokenManager` (Completer-based deduplication for parallel requests).

**Navigation**: GoRouter with `RootGuard` for auth-based routing. `MainShell` provides bottom tabs with role awareness (CUSTOMER, OWNER, STAFF).

**Theme system** (`core/theme/`):

- Primary color: orange `#E85D04`
- Material 3 enabled
- Design tokens: `AppColors`, `AppTypography`, `AppSpacing`, `AppRadius`

### 5.3 Panorama Stitcher

```
Spring Boot POST /stitch → FastAPI (background task) → OpenCV stitching
    → POST callback to /api/v1/internal/panorama/callback
```

Shared volume: `./uploads:/app/uploads`

---

## 6. Key Domain Entities & Relationships

**Backend** (JPA entities in `security/module/user/entity/` and `module/*/entity/`):

```
UserEntity (implements UserDetails)
├── roles: Set<RoleEntity> (CUSTOMER, OWNER, STAFF)
├── permissions: Set<PermissionEntity>
├── devices: List<DeviceEntity>
├── mfaSecret: MfaSecretEntity (optional TOTP)
└── mfaBackupCodes: List<MfaBackupCodeEntity>

RestaurantEntity
├── address: AddressEntity (PostGIS Point geometry)
├── openingHours: List<OpeningHoursEntity>
├── tables: List<RestaurantTableEntity>
├── menus: List<MenuEntity>
│   └── items: List<MenuItemEntity>
├── owner: UserEntity (FK)
└── employees: List<RestaurantEmployeeEntity>

ReservationEntity
├── user: UserEntity (FK)
├── restaurant: RestaurantEntity (FK)
├── table: RestaurantTableEntity (FK)
└── timeSlot, status, note

OrderEntity
├── user: UserEntity (FK)
├── restaurant: RestaurantEntity (FK)
├── items: List<OrderItemEntity>
└── status, totalPrice, note

FavouriteEntity
├── user: UserEntity (FK)
└── restaurant: RestaurantEntity (FK)

AuditLogEntity — tracks security events
VerificationTokenEntity — email verification tokens
```

---

## 7. Exception Handling Pattern

### Backend

**Hierarchy**:

```
RuntimeException
└── ServiceException (base: errorCode, message, HttpStatus)
    ├── AuthException
    ├── RestaurantException
    ├── ReservationException
    ├── OrderException
    ├── MenuException
    ├── SecurityException
    ├── UserException
    ├── MfaException
    ├── OAuthException
    ├── RateLimitExceededException
    ├── ClientException → ClientTimeoutException, ClientUnavailableException
    └── ...
```

**Global handler** (`ServiceExceptionHandler`):

- `handleServiceException` → uses `ErrorResponseBuilder`
- `handleNoResourceFound` → 404
- `handleGenericException` → 500 fallback

**Standardized error response**:

```json
{
  "code": "VALIDATION_ERROR",
  "message": "Heslo musí mít 8 až 64 znaků...",
  "status": 400,
  "timestamp": "2026-03-04T15:30:45.123456"
}
```

**Error codes** (`ErrorCode` enum): `VALIDATION_ERROR`, `NOT_FOUND`, `INTERNAL_SERVER_ERROR`, `DATABASE_ERROR`, `EXTERNAL_SERVICE_ERROR`, `INVALID_FORMAT`, `OPERATION_NOT_ALLOWED`, `CONFLICT`, `FORBIDDEN`

---

## 8. Validation Patterns

### Backend

- **Jakarta Validation** on request DTOs: `@NotEmpty`, `@NotNull`, `@NotBlank`, `@Size(min, max)`, `@Valid` (nested)
- **Custom validators**: `PasswordValidator` (uses `PasswordPolicy`), `UsernameValidator` (uses `UsernamePolicy`), `ChangePasswordValidator`, `UpdateProfileValidator`
- Password requirements: 8-64 chars, uppercase + lowercase + digit + special char (`@$!%*?&`)
- Controller methods: `@Valid @RequestBody DtoClass request`

### Frontend

- Validators in `security/validators/`
- Input validation in BLoC before API call
- Form-level validation in presentation widgets

---

## 9. Environment Variables

### Backend (`.env.example`)

```
SPRING_PROFILES_ACTIVE=local
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/checkfood
DB_USERNAME=your_db_user
DB_PASSWORD=your_secure_password
JWT_SECRET=your_super_secret_key_at_least_32_characters_long
JWT_EXPIRES=900
JWT_REFRESH=2592000
JWT_ISSUER=checkfood-local
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your-email@gmail.com
SMTP_PASSWORD=your_app_password
APP_BACKEND_URL=http://localhost:8081
SECURITY_AUDIT_ENABLED=true
SECURITY_AUDIT_RETENTION=30
CORS_ALLOWED_ORIGINS=http://localhost:3000,https://app.checkfood.cz
GOOGLE_CLIENT_ID=...
APPLE_CLIENT_ID=...
APPLE_TEAM_ID=...
APPLE_KEY_ID=...
APPLE_PRIVATE_KEY=...
PANORAMA_STITCHER_URL=http://localhost:8090
```

### Frontend (`.env`)

```
API_BASE_URL=http://10.0.2.2:8081/api    # Android emulator
# API_BASE_URL=http://localhost:8081/api  # iOS simulator
```

---

## 10. Testing

### Backend

- **Framework**: JUnit 5 + Spring Boot Test + MockMvc
- **Profile**: `@ActiveProfiles("test")` — uses H2 in-memory DB
- **Base class**: `BaseAuthIntegrationTest` provides MockMvc, ObjectMapper, repos, helpers (`register()`, `verify()`, `login()`, `getToken()`)
- **Mocking**: `@MockitoBean` for external services (EmailService, OAuthClientFactory, RateLimitService)
- **Test files**:
  - `security/Auth*IntegrationTest.java` (8 classes covering registration, login, refresh, logout, OAuth, protected endpoints, device mgmt, edge cases)
  - `module/favourite/FavouriteIntegrationTest.java`
  - `module/restaurant/MyRestaurantAuthorizationTest.java`
  - `reservation/ReservationIntegrationTest.java`

```bash
cd checkfood_service
./mvnw test                          # all tests
./mvnw test -Dtest=AuthLoginIntegrationTest  # single test class
```

### Frontend

- **Framework**: `flutter_test` + `bloc_test` + `mocktail`
- **Pattern**: Fake repositories (not Mockito), `expectLater(bloc.stream, emitsInOrder([...]))`
- **Structure**: `test/unit/`, `test/widget/`, `test/integration/`
- **Coverage**: BLoC tests exist for restaurant detail, reservation, my_restaurant

```bash
cd checkfood_client
flutter test                         # all tests
flutter test test/unit/              # unit only
```

---

## 11. CI/CD

### GitHub Actions (`.github/workflows/`)

| Workflow                      | Trigger                                        | What it does                                                  |
| ----------------------------- | ---------------------------------------------- | ------------------------------------------------------------- |
| `backend.yml`                 | Push to `main` (paths: `checkfood_service/**`) | Maven build → tests (continue-on-error) → Docker build verify |
| `flutter-android.yml`         | Push to `main`                                 | Build release APK → upload artifact                           |
| `flutter-android-release.yml` | Push to `main` or manual                       | Build APK → extract version → create GitHub Release           |

### Deployment (Render.com)

- `render.yaml`: PostgreSQL free tier + Docker-based Spring Boot service
- Auto-deploy from `main` branch
- Health check: `/actuator/health`
- Port: 10000 (internal Render), JWT_SECRET auto-generated

---

## 12. Conventions

### Code Style

**Backend**:

- Lombok annotations: `@Data`, `@Builder`, `@NoArgsConstructor`, `@AllArgsConstructor`, `@RequiredArgsConstructor`
- MapStruct: `@Mapper(componentModel = "spring")`, delegation between mappers
- Comments and error messages: mixed Czech and English
- `@author` tags on some classes
- Package-per-feature inside `module/` and `security/module/`

**Frontend**:

- All models use Freezed (`@freezed`) — regenerate after changes
- BLoC events/states are Freezed sealed classes
- Models have `toEntity()` converter methods
- Null-safe with `@Default()` annotations
- `@JsonKey(name: '...')` for JSON field mapping

### Naming

- Backend packages: lowercase, singular (`restaurant`, `order`, `reservation`)
- Backend DTOs: `*Request`, `*Response` suffixes (e.g., `CreateOrderRequest`, `AuthResponse`)
- Backend mappers: `*Mapper` (e.g., `AuthMapper`, `RestaurantMapper`)
- Backend exceptions: `*Exception` (e.g., `AuthException`, `RestaurantException`)
- Frontend: snake_case files, PascalCase classes, camelCase methods
- Frontend BLoCs: `*_bloc.dart`, `*_event.dart`, `*_state.dart`
- Frontend models: `*_model.dart` (data layer), entity name without suffix (domain)

### API Paths

- Base: `/api/`
- Auth: `/api/auth/register`, `/api/auth/login`, `/api/auth/verify`, `/api/auth/refresh`, `/api/auth/logout`
- OAuth: `/api/oauth/**`
- MFA: `/api/mfa/**`
- User: `/api/user/**`
- Restaurants: `/api/restaurants/**`
- Internal: `/api/v1/internal/**` (stitcher callbacks, etc.)

### Git Workflow

- **Commit prefixes**: `feat:`, `fix:`, `infra:`, `docs:`, `merge:`
- **Language**: Czech or English (both accepted)
- **Main branch**: `main` (production)
- **CI triggers**: push to `main`

---

## 13. Rules for Making Changes

### DO

1. **Keep layering strict**: Controller → Service → Repository. Business logic lives ONLY in Service classes.
2. **Adding a new endpoint (backend)**:
   - Create/update DTO in `dto/request/` and `dto/response/`
   - Add validation annotations on request DTO
   - Create/update MapStruct mapper
   - Add service method with business logic
   - Add controller method with `@Valid @RequestBody`, proper HTTP status
   - Add `@RateLimited` if public-facing
   - Write integration test
3. **Adding a new module (backend)**: Follow existing structure under `module/`: `controller/`, `service/`, `repository/`, `entity/`, `dto/`, `mapper/`, `exception/`
4. **Adding a new feature (frontend)**:
   - Create module under `modules/` with `data/`, `domain/`, `presentation/` layers
   - Register datasource, repository, use cases, and BLoC in `injection_container.dart`
   - Use Freezed for models, events, and states
   - Run `build_runner` after adding/modifying Freezed classes
5. **Exception handling**: Throw module-specific `ServiceException` subclass with appropriate `ErrorCode` and `HttpStatus`. The global handler formats the response.
6. **Validation**: Use Jakarta annotations on DTOs. For complex validation, create a dedicated `*Validator` class with a `*Policy` class.
7. **Configuration**: Use environment variables (never hardcode secrets). Reference via `${ENV_VAR:default}` in `application.properties`.
8. **Domain events**: Publish events from services after successful operations. Create listeners in `listener/` package.
9. **Database changes**: Currently Hibernate DDL auto — add entity with JPA annotations. When Flyway migrations are ready, create versioned SQL scripts in `db/migration/`.
10. **MapStruct mappers**: Annotate with `@Mapper(componentModel = "spring")`. Exclude sensitive fields (passwords, secrets) from response DTOs.

### DON'T

1. **No business logic in controllers** — controllers only validate input, delegate to service, and return response.
2. **No direct repository calls from controllers** — always go through service layer.
3. **No hardcoded configuration** — use environment variables and `application.properties`.
4. **No raw SQL in services** — use JPA repositories or `@Query` annotations on repository interfaces.
5. **No manual JSON serialization** — use MapStruct (backend) or Freezed (frontend) for all DTO mapping.
6. **No skipping validation** — all request DTOs must have Jakarta validation annotations.
7. **Don't modify generated files** — `*.freezed.dart`, `*.g.dart` are auto-generated. Modify the source and re-run `build_runner`.
8. **Don't register BLoCs as singletons** — BLoCs must be **factories** in GetIt to avoid stale state.
9. **Don't call `dioAuth` for authenticated endpoints** — use the default `dioMain` (with AuthInterceptor).
10. **Don't bypass rate limiting** — all public-facing endpoints (auth, registration) must have `@RateLimited`.
11. **Don't ignore existing exception hierarchy** — create module-specific exceptions extending `ServiceException`, don't throw generic `RuntimeException`.
12. **Don't put frontend models in domain layer** — `fromJson`/`toJson` belong in `data/models/`, domain entities are pure Freezed classes with `toEntity()` converters in the model.

---

## 14. Practical Commands

### Backend

```bash
# Start
cd checkfood_service
docker compose up -d                          # full stack
./mvnw spring-boot:run                        # app only (DB must be running)

# Build
mvn clean package -DskipTests                 # JAR without tests
docker build -t checkfood-api:local .         # Docker image

# Test
./mvnw test                                   # all tests
./mvnw test -Dtest=ClassName                  # single class
./mvnw test -Dtest="ClassName#methodName"     # single method

# Database
docker compose up -d db                       # start only PostgreSQL
# Connect: psql -h localhost -p 5432 -U $DB_USERNAME -d checkfood

# Swagger
# Open http://localhost:8081/swagger-ui.html
```

### Frontend

```bash
# Start
cd checkfood_client
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run

# Code generation (after model changes)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs   # watch mode

# Test
flutter test
flutter test test/unit/
flutter test --name="test name pattern"

# Build
flutter build apk --release
flutter build ios --release
```

### Docker

```bash
cd checkfood_service
docker compose up -d              # start all services
docker compose up -d db           # start only DB
docker compose up -d stitcher     # start only stitcher
docker compose logs -f app        # follow app logs
docker compose down               # stop all
docker compose down -v            # stop + remove volumes (DELETES DATA)
```

---

## 15. Safe Work Mode

Before any significant change, follow this protocol:

1. **Mini plan** (3-7 bullet points): list what you'll change and which files are affected.
2. **Read before edit**: always read a file before modifying it. Understand existing patterns.
3. **Incremental changes**: for multi-file refactors, change one file at a time. Verify build/tests between steps.
4. **Don't break existing tests**: run `./mvnw test` (backend) or `flutter test` (frontend) after changes.
5. **Regenerate code**: if you modify Freezed models, run `build_runner` immediately.
6. **Check DI**: if you add new services/repositories/BLoCs, register them in:
   - Backend: Spring auto-scans via `@Component`/`@Service`/`@Repository` annotations
   - Frontend: `injection_container.dart` (manual GetIt registration)
7. **Environment variables**: if adding new config, update both `application.properties` and `.env.example`.

---

## 16. Spring Profiles

| Profile | Activation                     | Hibernate DDL                 | Flyway             | Logging                      | DevTools |
| ------- | ------------------------------ | ----------------------------- | ------------------ | ---------------------------- | -------- |
| `local` | `SPRING_PROFILES_ACTIVE=local` | `update`                      | disabled           | DEBUG (SQL, binds, security) | enabled  |
| `prod`  | `SPRING_PROFILES_ACTIVE=prod`  | `update` (→ `validate` later) | enabled + baseline | INFO only                    | disabled |
| `test`  | `@ActiveProfiles("test")`      | —                             | —                  | —                            | —        |

---

## 17. Key File Locations (Quick Reference)

### Backend

| What                     | Path                                                                                |
| ------------------------ | ----------------------------------------------------------------------------------- |
| Entry point              | `checkfood_service/src/.../CheckfoodServiceApplication.java`                        |
| Security config          | `checkfood_service/src/.../security/config/SecurityConfig.java`                     |
| JWT service              | `checkfood_service/src/.../security/module/jwt/service/JwtService.java`             |
| JWT filter               | `checkfood_service/src/.../security/module/jwt/filter/JwtAuthenticationFilter.java` |
| Auth controller          | `checkfood_service/src/.../security/module/auth/controller/AuthController.java`     |
| Global exception handler | `checkfood_service/src/.../exception/ServiceExceptionHandler.java`                  |
| Error codes              | `checkfood_service/src/.../exception/ErrorCode.java`                                |
| Rate limit annotation    | `checkfood_service/src/.../security/ratelimit/annotation/RateLimited.java`          |
| Feature flags            | `checkfood_service/src/.../feature/service/FeatureService.java`                     |
| Properties               | `checkfood_service/src/main/resources/application*.properties`                      |
| Docker compose           | `checkfood_service/docker-compose.yml`                                              |
| Env template             | `checkfood_service/.env.example`                                                    |

### Frontend

| What             | Path                                                                  |
| ---------------- | --------------------------------------------------------------------- |
| Entry point      | `checkfood_client/lib/main.dart`                                      |
| DI container     | `checkfood_client/lib/core/di/injection_container.dart`               |
| Auth BLoC        | `checkfood_client/lib/security/presentation/bloc/auth/auth_bloc.dart` |
| Auth interceptor | `checkfood_client/lib/security/interceptors/auth_interceptor.dart`    |
| Token storage    | `checkfood_client/lib/security/data/local/token_storage.dart`         |
| Router           | `checkfood_client/lib/navigation/app_router.dart`                     |
| Route guards     | `checkfood_client/lib/navigation/route_guards.dart`                   |
| Theme            | `checkfood_client/lib/core/theme/`                                    |
| Pubspec          | `checkfood_client/pubspec.yaml`                                       |
