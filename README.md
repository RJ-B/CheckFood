# 🍽️ CheckFood

Mobilní aplikace pro restaurace – prohlížení menu, objednávání jídla, rezervace stolů (včetně 3D panoramatického výběru) a správa uživatelského účtu.

| Vrstva | Technologie |
|--------|-------------|
| **Backend** | Java 17, Spring Boot 3.5.7, PostgreSQL, JWT, OAuth2 |
| **Frontend** | Flutter 3.7+, Dart, BLoC, Dio |
| **Infrastruktura** | Docker, Docker Compose |

---

## Předpoklady

Než začnete, ujistěte se, že máte nainstalované:

- **Git**
- **Docker** a **Docker Compose**
- **Java 17** (JDK) – doporučeno Eclipse Temurin
- **Maven 3.8+** (nebo použijte přibalený `mvnw`)
- **Flutter SDK** ≥ 3.7.2 ([instalace](https://docs.flutter.dev/get-started/install))
- **Android Studio** nebo **VS Code** s Flutter pluginem
- **Android Emulator** nebo fyzické zařízení

---

## 1. Klonování repozitáře

```bash
git clone https://github.com/RJ-B/CheckFood.git
cd CheckFood
```

---

## 2. Backend (`checkfood_service`)

### 2.1 Spuštění databáze

Přejděte do složky backendu a vytvořte soubor `.env` ze šablony:

```bash
cd checkfood_service
cp .env.example .env
```

Otevřete `.env` a vyplňte přihlašovací údaje k databázi:

```dotenv
DB_USERNAME=checkfood
DB_PASSWORD=heslo123
```

Spusťte PostgreSQL kontejner:

```bash
docker compose up -d
```

Ověřte, že databáze běží:

```bash
docker compose ps
# Stav by měl být "running" / "healthy"
```

### 2.2 Konfigurace prostředí

Ve stejném `.env` souboru nastavte zbývající proměnné.

> **Tip:** Pokud nechcete řešit SMTP, backend se spustí i bez něj – jen nebudou fungovat verifikační emaily. Můžete účet aktivovat přímo v databázi: `UPDATE users SET enabled = true WHERE email = '...';`

### 2.3 Spuštění backendu

Pomocí Maven Wrapperu (není třeba instalovat Maven):

```bash
# Linux / macOS
./mvnw spring-boot:run

# Windows
mvnw.cmd spring-boot:run
```

Nebo klasicky přes Maven:

```bash
mvn spring-boot:run
```

Backend nastartuje na **http://localhost:8081**.

### 2.4 Ověření

```bash
curl http://localhost:8081/actuator/health
# Očekávaná odpověď: {"status":"UP"}
```

API dokumentace (Swagger UI) je dostupná na:
**http://localhost:8081/swagger-ui.html**

### 2.5 Spuštění testů

```bash
./mvnw test
```

Testy používají in-memory H2 databázi – není potřeba běžící PostgreSQL.

---

## 3. Frontend (`checkfood_client`)

### 3.1 Konfigurace prostředí

```bash
cd ../checkfood_client
cp .env.example .env
```

Vytvořte/upravte soubor `.env` v kořeni `checkfood_client/`:

> **Poznámka k adrese:**
> - `10.0.2.2` – Android Emulator (mapuje na localhost hostitelského PC)
> - `localhost` – Web
> - `192.168.x.x` – Fyzické zařízení (použijte IP adresu vašeho PC v lokální síti)

### 3.2 Instalace závislostí

```bash
flutter pub get
```

### 3.3 Generování kódu (Freezed / JSON serializace)

Projekt používá `freezed` a `json_serializable` pro modely. Po prvním stažení musíte spustit code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3.4 Spuštění aplikace

Ujistěte se, že máte spuštěný emulátor nebo připojené zařízení:

```bash
flutter devices
```

Spusťte aplikaci:

```bash
flutter run
```

Nebo z Android Studio / VS Code: otevřete `checkfood_client/`, vyberte zařízení a stiskněte Run.

---

## 4. Rychlý start (vše najednou)

```bash
# 1. Klonovat
git clone https://github.com/RJ-B/CheckFood.git
cd CheckFood

# 2. Databáze
cd checkfood_service
cp .env.example .env
# ... upravte .env (viz sekce 2.2) ...
docker compose up -d

# 3. Backend (nový terminál)
cd checkfood_service
./mvnw spring-boot:run

# 4. Frontend (nový terminál)
cd checkfood_client
cp .env.example .env
# ... upravte .env (viz sekce 3.1) ...
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Struktura projektu

```
CheckFood/
├── checkfood_service/          # Backend (Spring Boot)
│   ├── src/main/java/          # Zdrojový kód
│   │   └── com/checkfood/
│   │       ├── client/         # Klienti (mail, platby)
│   │       ├── config/         # Aplikační konfigurace
│   │       ├── event/          # Domain events
│   │       ├── exception/      # Globální exception handling
│   │       ├── feature/        # Feature flags
│   │       ├── listener/       # Event listeners
│   │       ├── logging/        # Structured logging
│   │       ├── monitoring/     # Health checks, metriky
│   │       ├── scheduler/      # Cron joby
│   │       └── security/       # Auth, JWT, MFA, OAuth, Users
│   ├── src/main/resources/     # Konfigurace (properties)
│   ├── src/test/               # Testy
│   ├── docker-compose.yml      # PostgreSQL kontejner
│   ├── Dockerfile              # Multi-stage build
│   └── pom.xml                 # Maven závislosti
│
├── checkfood_client/           # Frontend (Flutter)
│   ├── lib/
│   │   ├── components/         # Znovupoužitelné UI komponenty
│   │   ├── core/               # DI, theme, utils, services
│   │   ├── features/           # Obrazovky (explore, cart, orders...)
│   │   ├── models/             # Datové modely
│   │   ├── navigation/         # Router, guards, shell
│   │   └── security/           # Auth BLoC, interceptory, repozitáře
│   ├── assets/                 # Ikony, obrázky, 3D scéna
│   └── pubspec.yaml            # Flutter závislosti
│
└── README.md
```

---

## API Endpointy (přehled)

### Autentizace (`/api/auth`)
| Metoda | Endpoint | Popis |
|--------|----------|-------|
| POST | `/register` | Registrace nového uživatele |
| POST | `/login` | Přihlášení |
| GET | `/verify?token=...` | Verifikace emailu |
| POST | `/resend-code` | Znovuzaslání verifikačního emailu |
| POST | `/refresh` | Obnova access tokenu |
| POST | `/logout` | Odhlášení |
| GET | `/me` | Aktuální uživatel |

### Uživatel (`/api/user`)
| Metoda | Endpoint | Popis |
|--------|----------|-------|
| GET | `/me` | Profil uživatele |
| PATCH | `/profile` | Aktualizace profilu |
| POST | `/change-password` | Změna hesla |
| POST | `/logout-all` | Odhlášení ze všech zařízení |
| DELETE | `/devices/{id}` | Odhlášení konkrétního zařízení |
| GET | `/` | Seznam uživatelů (ADMIN) |
| POST | `/assign-role` | Přiřazení role (ADMIN) |

### OAuth (`/api/oauth`)
| Metoda | Endpoint | Popis |
|--------|----------|-------|
| POST | `/login` | OAuth přihlášení (Google/Apple) |

### MFA (`/api/mfa`)
| Metoda | Endpoint | Popis |
|--------|----------|-------|
| POST | `/setup/start` | Zahájení MFA nastavení |
| POST | `/setup/verify` | Dokončení MFA nastavení |
| POST | `/challenge/verify` | Ověření MFA kódu při přihlášení |
| POST | `/disable` | Vypnutí MFA |
| GET | `/status` | Stav MFA |

---

## Licence

Tento projekt je licencován pod MIT licencí.