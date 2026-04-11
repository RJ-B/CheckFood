# CheckFood

Mobilni aplikace pro restaurace — vyhledavani restauraci, prohlidka menu, objednavani jidla, rezervace stolu (vcetne 3D panoramatickeho vyberu) a sprava uzivatelskeho uctu.

| Vrstva | Technologie |
|--------|-------------|
| Backend | Java 17, Spring Boot 3.5.7, PostgreSQL 15 + PostGIS 3.4, JWT, OAuth2 |
| Frontend | Flutter 3.7+, Dart, BLoC, Dio, Freezed |
| Panorama Stitcher | Python 3.12, FastAPI, OpenCV |
| Infrastruktura | Docker, Docker Compose, GitHub Actions CI |

---

## Obsah

1. [Predpoklady](#1-predpoklady)
2. [Klonovani repozitare](#2-klonovani-repozitare)
3. [Backend — spusteni](#3-backend--spusteni)
4. [Frontend — spusteni](#4-frontend--spusteni)
5. [Docker Compose — cely stack najednou](#5-docker-compose--cely-stack-najednou)
6. [Overeni ze vse bezi](#6-overeni-ze-vse-bezi)
7. [Struktura projektu](#7-struktura-projektu)
8. [API endpointy](#8-api-endpointy)
9. [Architektura](#9-architektura)
10. [Testovani](#10-testovani)
11. [Reseni problemu](#11-reseni-problemu)
12. [Licence](#12-licence)

---

## 1. Predpoklady

Nainstalujte nasledujici nastroje:

| Nastroj | Verze | Odkaz |
|---------|-------|-------|
| Git | libovolna | https://git-scm.com |
| Docker + Docker Compose | Docker 20+ | https://docs.docker.com/get-docker |
| Java JDK | 17 | https://adoptium.net (Eclipse Temurin) |
| Flutter SDK | 3.7.2+ | https://docs.flutter.dev/get-started/install |
| Android Studio nebo VS Code | libovolna | https://developer.android.com/studio |
| Android Emulator nebo fyzicke zarizeni | — | Nastavit pres Android Studio |

Overeni instalace:

```bash
git --version
docker --version
docker compose version
java -version          # musi byt 17+
flutter --version      # musi byt 3.7.2+
flutter doctor         # zkontroluje zavislosti
```

---

## 2. Klonovani repozitare

```bash
git clone https://github.com/RJ-B/CheckFood.git
cd CheckFood
```

---

## 3. Backend — spusteni

### 3.1 Spusteni databaze (PostgreSQL + PostGIS)

```bash
cd checkfood_service
cp .env.example .env
```

Otevrete `.env` v editoru a vyplnte minimalne tyto hodnoty:

```dotenv
# Databaze
DB_USERNAME=checkfood
DB_PASSWORD=heslo123

# JWT — vygenerujte libovolny retezec (min 32 znaku)
JWT_SECRET=tady-vlozte-nahodny-retezec-minimalne-32-znaku-dlouhy
JWT_EXPIRES=900
JWT_REFRESH=2592000
JWT_ISSUER=checkfood-local

# Profil
SPRING_PROFILES_ACTIVE=local
```

> **Poznamka k emailu (SMTP):** Pokud nechcete nastavovat SMTP, nechte puvodni placeholder hodnoty. Backend se spusti i bez nej — jen nebudou fungovat verifikacni emaily. Ucet muzete aktivovat primo v databazi:
> ```sql
> UPDATE users SET enabled = true WHERE email = 'vas@email.cz';
> ```

Spustte databazi:

```bash
docker compose up -d db
```

Overeni:

```bash
docker compose ps
# Sloupec STATUS by mel ukazovat "healthy"
```

### 3.2 Spusteni backend serveru

V novem terminalu (zustanou v `checkfood_service/`):

```bash
# Linux / macOS
./mvnw spring-boot:run

# Windows
mvnw.cmd spring-boot:run
```

Backend nastartuje na **http://localhost:8081**.

Prvni start muze trvat 1–2 minuty (stahuje zavislosti).

### 3.3 Overeni backendu

```bash
curl http://localhost:8081/actuator/health
```

Ocekavana odpoved:

```json
{"status":"UP"}
```

Swagger UI (interaktivni API dokumentace):
**http://localhost:8081/swagger-ui.html**

---

## 4. Frontend — spusteni

### 4.1 Konfigurace

```bash
cd checkfood_client
```

Vytvorte soubor `.env` v koreni `checkfood_client/` s obsahem:

```dotenv
API_BASE_URL=http://10.0.2.2:8081/api
```

> **Dulezite — spravna adresa podle zarizeni:**
>
> | Zarizeni | API_BASE_URL |
> |----------|-------------|
> | Android Emulator | `http://10.0.2.2:8081/api` |
> | iOS Simulator | `http://localhost:8081/api` |
> | Fyzicke zarizeni (WiFi) | `http://192.168.X.X:8081/api` (IP vaseho PC) |
>
> Adresa `10.0.2.2` je specialni alias v Android Emuleru, ktery odkazuje na localhost hostitelskeho PC.

### 4.2 Instalace zavislosti

```bash
flutter pub get
```

### 4.3 Generovani kodu (Freezed + JSON serializace)

Projekt pouziva `freezed` a `json_serializable` pro datove modely. Po kazdem klonovani je nutne vygenerovat kod:

```bash
dart run build_runner build --delete-conflicting-outputs
```

> Tento krok je **povinny**. Bez nej projekt nepujde zkompilovat.

### 4.4 Spusteni aplikace

Overeni pripojenych zarizeni:

```bash
flutter devices
```

Spusteni:

```bash
flutter run
```

Nebo v Android Studio / VS Code: otevrete slozku `checkfood_client/`, vyberte zarizeni a spustte pres Run.

---

## 5. Docker Compose — cely stack najednou

Pokud chcete spustit backend + databazi + panorama stitcher najednou:

```bash
cd checkfood_service
cp .env.example .env
# ... vyplnte .env (viz sekce 3.1) ...

docker compose up -d
```

Tim se spusti 3 sluzby:

| Sluzba | Port | Popis |
|--------|------|-------|
| db | 5432 | PostgreSQL 15 + PostGIS 3.4 |
| stitcher | 8090 | Panorama stitcher (Python/FastAPI/OpenCV) |
| app | 8081 | Spring Boot API |

Kontrola:

```bash
docker compose ps
docker compose logs -f app    # logy backendu
```

Zastaveni:

```bash
docker compose down            # zastavi kontejnery
docker compose down -v         # zastavi + smaze data databaze
```

> **Poznamka:** Frontend (Flutter) se nespousti pres Docker — vzdy se spousti lokalne pres `flutter run`.

---

## 6. Overeni ze vse bezi

| Co overit | Jak | Ocekavany vysledek |
|-----------|-----|-------------------|
| Databaze | `docker compose ps` | db: healthy |
| Backend health | `curl http://localhost:8081/actuator/health` | `{"status":"UP"}` |
| Swagger UI | Otevrit v prohlizeci: `http://localhost:8081/swagger-ui.html` | Interaktivni API dokumentace |
| Frontend | `flutter run` na emuleru | Aplikace se spusti, zobrazi splash screen |
| Pripojeni FE→BE | V aplikaci zkusit registraci nebo login | Odpoved z API (uspech nebo chybova hlaska) |

---

## 7. Struktura projektu

```
CheckFood/
├── checkfood_service/                # Backend (Spring Boot)
│   ├── src/main/java/com/checkfood/checkfoodservice/
│   │   ├── config/                   # Konfigurace (OpenAPI, Jackson, PostGIS)
│   │   ├── exception/                # Globalni exception handling + ErrorCode
│   │   ├── feature/                  # Feature flags
│   │   ├── security/                 # Autentizace a autorizace
│   │   │   ├── module/auth/          #   Registrace, login, verifikace emailem
│   │   │   ├── module/jwt/           #   JWT generace, validace, filter
│   │   │   ├── module/mfa/           #   TOTP multi-factor autentizace
│   │   │   ├── module/oauth/         #   Google + Apple OAuth2
│   │   │   ├── module/user/          #   UserEntity, role, zarizeni
│   │   │   └── ratelimit/            #   Rate limiting (AOP)
│   │   ├── module/                   # Business domeny
│   │   │   ├── restaurant/           #   Vyhledavani restauraci, CRUD, geolokace
│   │   │   ├── menu/                 #   Sprava jidelnich listku
│   │   │   ├── order/                #   Objednavky
│   │   │   ├── reservation/          #   Rezervace stolu
│   │   │   ├── favourite/            #   Oblibene restaurace
│   │   │   ├── owner/                #   Owner portal (onboarding, claim)
│   │   │   ├── panorama/             #   Panorama stitching integrace
│   │   │   ├── dining/               #   Dining context
│   │   │   └── storage/              #   Upload souboru
│   │   └── scheduler/                # Planovane ulohy (cron joby)
│   ├── src/main/resources/
│   │   ├── application.properties    # Zakladni konfigurace
│   │   ├── application-local.properties  # Vyvojovy profil
│   │   └── application-prod.properties   # Produkcni profil
│   ├── src/test/                     # Integracni testy (JUnit 5)
│   ├── stitcher/                     # Panorama microservice (Python)
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── .env.example
│
├── checkfood_client/                 # Frontend (Flutter)
│   ├── lib/
│   │   ├── main.dart                 # Vstupni bod + DI inicializace
│   │   ├── app.dart                  # MaterialApp + BLoC providery
│   │   ├── core/                     # Sdilena infrastruktura
│   │   │   ├── di/                   #   Dependency injection (GetIt)
│   │   │   ├── network/              #   Dio interceptory
│   │   │   └── theme/                #   Barvy, typografie, spacing
│   │   ├── security/                 # Auth (data/domain/presentation vrstvy)
│   │   ├── modules/
│   │   │   ├── customer/             #   Explore, reservation, orders
│   │   │   ├── management/           #   My restaurant, staff reservations
│   │   │   └── owner/                #   Onboarding wizard, claim restaurace
│   │   ├── navigation/               # Router, guards, hlavni shell
│   │   └── components/               # Znovupouzitelne UI komponenty
│   ├── pubspec.yaml
│   └── test/
│
├── .github/workflows/                # CI pipelines
│   ├── backend.yml                   # Backend build + testy
│   ├── flutter-android.yml           # Flutter APK build
│   └── flutter-android-release.yml   # Flutter release + GitHub Release
│
├── ai/                               # Workflow AI agentu (ridici soubory)
├── CLAUDE.md                         # Operacni manual pro AI agenty
├── LICENSE                           # MIT
└── README.md                         # Tento soubor
```

---

## 8. API endpointy

Kompletni interaktivni dokumentace: **http://localhost:8081/swagger-ui.html**

### Autentizace (`/api/auth/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| POST | `/register` | Registrace noveho uzivatele | Verejna |
| POST | `/register-owner` | Registrace majitele restaurace | Verejna |
| POST | `/login` | Prihlaseni (vraci access + refresh token) | Verejna |
| GET | `/verify?token=...` | Verifikace emailu | Verejna |
| POST | `/resend-code` | Znovu zaslani verifikacniho emailu | Verejna |
| POST | `/refresh` | Obnova access tokenu | Verejna |
| POST | `/logout` | Odhlaseni | Prihlaseny |
| GET | `/me` | Aktualni uzivatel | Prihlaseny |

### Uzivatel (`/api/user/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| GET | `/me` | Profil uzivatele | Prihlaseny |
| PATCH | `/profile` | Aktualizace profilu | Prihlaseny |
| POST | `/change-password` | Zmena hesla | Prihlaseny |
| POST | `/logout-all` | Odhlaseni ze vsech zarizeni | Prihlaseny |
| GET | `/devices` | Seznam zarizeni | Prihlaseny |
| DELETE | `/devices/{id}` | Smazani zarizeni | Prihlaseny |
| GET | `/` | Seznam uzivatelu | ADMIN |
| POST | `/assign-role` | Prirazeni role | ADMIN |

### Restaurace (`/api/v1/restaurants/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| GET | `/markers` | Markery restauraci pro mapu | Verejna |
| GET | `/nearest` | Nejblizsi restaurace (geolokace) | Verejna |
| GET | `/{id}` | Detail restaurace | Verejna |
| POST | `/` | Vytvoreni restaurace | OWNER |
| PUT | `/{id}` | Uprava restaurace | OWNER |
| DELETE | `/{id}` | Smazani restaurace | OWNER |

### Rezervace (`/api/v1/reservations/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| POST | `/` | Vytvoreni rezervace | Prihlaseny |
| GET | `/me` | Moje aktivni rezervace | Prihlaseny |
| GET | `/me/history` | Historie rezervaci | Prihlaseny |
| PUT | `/{id}` | Uprava rezervace | Prihlaseny |
| PATCH | `/{id}/cancel` | Zruseni rezervace | Prihlaseny |

### Rezervace — staff (`/api/v1/staff/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| GET | `/my-restaurant/reservations` | Rezervace restaurace | OWNER/MANAGER/STAFF |
| POST | `/reservations/{id}/confirm` | Potvrdit | OWNER/MANAGER/STAFF |
| POST | `/reservations/{id}/reject` | Zamitnout | OWNER/MANAGER/STAFF |
| POST | `/reservations/{id}/check-in` | Check-in hosta | OWNER/MANAGER/STAFF |
| POST | `/reservations/{id}/complete` | Ukoncit rezervaci | OWNER/MANAGER/STAFF |

### Objednavky (`/api/v1/orders/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| POST | `/` | Vytvoreni objednavky | Prihlaseny |
| GET | `/me/current` | Aktualni objednavky | Prihlaseny |

### Menu (`/api/v1/restaurants/{id}/menu`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| GET | `/` | Jidelni listek restaurace | Verejna |

### Oblibene (`/api/v1/users/me/favourites/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| GET | `/` | Moje oblibene restaurace | Prihlaseny |
| PUT | `/{restaurantId}` | Pridat do oblibenych | Prihlaseny |
| DELETE | `/{restaurantId}` | Odebrat z oblibenych | Prihlaseny |

### MFA (`/api/mfa/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| POST | `/setup/start` | Zahajeni MFA nastaveni | Prihlaseny |
| POST | `/setup/verify` | Dokonceni MFA nastaveni | Prihlaseny |
| POST | `/challenge/verify` | Overeni MFA kodu | Prihlaseny |
| POST | `/disable` | Vypnuti MFA | Prihlaseny |
| GET | `/status` | Stav MFA | Prihlaseny |

### OAuth (`/api/oauth/`)

| Metoda | Endpoint | Popis | Autorizace |
|--------|----------|-------|------------|
| POST | `/login` | Prihlaseni pres Google/Apple | Verejna |

---

## 9. Architektura

### System overview

```
┌─────────────────┐       ┌──────────────────┐       ┌──────────────────┐
│  Flutter App     │──────>│  Spring Boot API  │──────>│  PostgreSQL      │
│  (mobilni        │<──────│  port 8081        │<──────│  + PostGIS       │
│   klient)        │ REST  │                  │  JPA  │  port 5432       │
└─────────────────┘       └────────┬──────────┘       └──────────────────┘
                                   │
                              HTTP (async)
                                   │
                           ┌───────v──────────┐
                           │  Panorama        │
                           │  Stitcher        │
                           │  port 8090       │
                           └──────────────────┘
```

### Backend — vrstveni (kazdy modul)

```
Controller (@RestController)     ← prijima HTTP requesty, validuje vstup
    │
Service (@Service)               ← business logika, domain eventy
    │
Repository (JpaRepository)       ← pristup k databazi
    │
Entity (@Entity)                 ← JPA entita, mapovani na DB tabulku
```

DTO mapovani: MapStruct (`@Mapper(componentModel = "spring")`)

### Frontend — Clean Architecture (kazdy modul)

```
data/
├── datasources/     # API volani (Dio)
├── models/          # Freezed DTO s fromJson/toJson
└── repositories/    # Implementace repozitaru

domain/
├── entities/        # Business modely (Freezed, immutable)
├── repositories/    # Abstraktni kontrakty
└── usecases/        # Jednotlive business operace

presentation/
├── bloc/            # Stavovy automat (events → states)
├── pages/           # Cele obrazovky
└── widgets/         # Komponenty specificke pro modul
```

State management: BLoC pattern (flutter_bloc).

### Databazovy model — klicove entity

```
UserEntity ──── RoleEntity ──── PermissionEntity
     │
     ├── DeviceEntity (zarizeni uzivatele)
     ├── MfaSecretEntity (TOTP)
     └── VerificationTokenEntity

Restaurant ──── RestaurantTable ──── TableGroup
     │
     ├── MenuCategory ──── MenuItem
     ├── RestaurantEmployee
     └── PanoramaSession ──── PanoramaPhoto

Reservation (FK: restaurant, table, user)
Order ──── OrderItem (FK: restaurant, table, user, menuItem)
UserFavouriteRestaurant (FK: user, restaurant)
```

### Autentizace

- JWT tokeny: access (15 min) + refresh (30 dni)
- Tokeny obsahuji device identifier pro spravou vice zarizeni
- Refresh token rotace pri kazdem pouziti
- Rate limiting na vsech verejnych endpointech

### Role uzivatelu

| Role | Opravneni |
|------|-----------|
| CUSTOMER | Prohlizeni restauraci, rezervace, objednavky |
| OWNER | Sprava vlastni restaurace, menu, zamestnancu |
| MANAGER | Sprava rezervaci a objednavek restaurace |
| STAFF | Potvrzovani rezervaci, obsluhaa |
| ADMIN | Sprava uzivatelu, audit logy |

---

## 10. Testovani

### Backend

```bash
cd checkfood_service
./mvnw test                              # vsechny testy
./mvnw test -Dtest=AuthLoginIntegrationTest  # konkretni trida
```

Testy pouzivaji H2 in-memory databazi — neni potreba bezici PostgreSQL.

Existujici testove tridy:
- `AuthRegistrationIntegrationTest`
- `AuthLoginIntegrationTest`
- `AuthRefreshIntegrationTest`
- `AuthLogoutIntegrationTest`
- `AuthOAuthIntegrationTest`
- `FavouriteIntegrationTest`
- `ReservationIntegrationTest`
- `MyRestaurantAuthorizationTest`

### Frontend

```bash
cd checkfood_client
flutter test                   # vsechny testy
flutter test test/unit/        # jen unit testy
```

---

## 11. Reseni problemu

### Backend se nespusti

**Chyba:** `Connection refused` na port 5432
- Overit ze databaze bezi: `docker compose ps`
- Overit ze port 5432 neni obsazeny: `netstat -an | grep 5432`

**Chyba:** `JWT_SECRET` error
- Zkontrolovat ze `.env` obsahuje `JWT_SECRET` s minimalne 32 znaky

### Frontend — build error

**Chyba:** `Could not find the generated implementation`
- Spustit code generation: `dart run build_runner build --delete-conflicting-outputs`

**Chyba:** `Connection refused` z aplikace
- Zkontrolovat `API_BASE_URL` v `.env`
- Pro Android Emulator musi byt `10.0.2.2` (ne `localhost`)
- Overit ze backend bezi na portu 8081

### Docker

**Chyba:** Port 5432 uz je obsazeny
- Zastavit lokalni PostgreSQL: `sudo systemctl stop postgresql`
- Nebo zmenit port v `docker-compose.yml`: `"5433:5432"`

**Reset databaze:**
```bash
cd checkfood_service
docker compose down -v     # smaze vsechna data
docker compose up -d db    # znovu spusti s cistou DB
```

---

## 12. Licence

Tento projekt je licencovan pod [MIT licenci](LICENSE).

Copyright 2025 RJ-B
