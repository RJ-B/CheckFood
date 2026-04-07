# CLAUDE.md — Diplomová práce FIM UHK
# Autor: Bc. Rostislav Jirák
# Závazné pro: všechny soubory v tomto projektu

---

## 1. IDENTITA PROJEKTU

- **Typ práce:** Diplomová práce
- **Instituce:** Univerzita Hradec Králové, Fakulta informatiky a managementu (FIM UHK)
- **Katedra:** Katedra informatiky a kvantitativních metod
- **Autor:** Bc. Rostislav Jirák
- **Studijní obor:** Aplikovaná informatika
- **Závazná norma:** Výnos děkanky FIM č. 9/2025 (platný od 1. 9. 2025)
- **Název práce:** Vývoj aplikace pro správu rezervací a objednávek v gastronomii
- **Název anglicky:** Development of an Application for Reservation and Order Management in Gastronomy
- **Název projektu:** CheckFood
- **Vedoucí práce:** doc. Mgr. Tomáš Kozel, Ph.D.
- **Datum odevzdání:** srpen 2026

---

## 2. POVINNÁ STRUKTURA PRÁCE

Kapitoly musí být v tomto pořadí:

1. Titulní list
2. Prohlášení
3. Poděkování *(nepovinné)*
4. Abstrakt česky + anglicky + klíčová slova (5 klíčových slov)
5. Obsah
6. Úvod *(začíná na straně 1)*
7. Cíl a metodika práce
8. Vlastní text práce *(více kapitol — viz sekce 14)*
9. Shrnutí a diskuse výsledků
10. Závěry a doporučení
11. Seznam zdrojů
12. Přílohy *(nestránkované)*
13. Zadání práce z IS STAG

---

## 3. ROZSAH PRÁCE — ZÁVAZNÉ HODNOTY

Dle Výnosu děkanky FIM č. 9/2025, kap. 2:

> „Diplomové práce – **50–60 stran** (přibližně **100 000 znaků**)"
> „Započítávají se pouze strany počínaje úvodem a konče závěrem práce."

**Normostrana = 1 800 znaků** (všechny alfanumerické znaky včetně interpunkce a mezer).
Dle definice ČSN používané na UHK (z rektorského výnosu) platí: 100 000 znaků ÷ 1 800 = **přibližně 55–56 normostran**.

### Přepočet na normostranami:
| Hodnota | Strany (formátované) | Normostranám |
|---------|----------------------|--------------|
| Minimum | 50 stran | ~46–50 NS |
| Doporučeno | 55 stran | ~55 NS |
| Maximum | 60 stran | ~63 NS |

**Praktické pravidlo:** Cílový rozsah je **přibližně 100 000 znaků** (= ~55 normostran), což odpovídá 50–60 formátovaným stranám A4 při dodržení předepsaného formátování (Cambria/TNR 12, řádkování 1,5, okraje dle výnosu).

### Hlídání rozsahu kapitol:
Při generování textu vždy odhadovat délku. Orientační počty znaků na kapitolu:

| Kapitola | Podíl | Orientační znaky |
|----------|-------|-----------------|
| Úvod | ~3 % | ~3 000 |
| Cíl a metodika | ~4 % | ~4 000 |
| Analýza + Technologie (kap. 1) | ~20 % | ~20 000 |
| Návrh architektury (kap. 2) | ~10 % | ~10 000 |
| Návrh databáze (kap. 3) | ~10 % | ~10 000 |
| Implementace (kap. 4) | ~35 % | ~35 000 |
| Testování (kap. 5) | ~5 % | ~5 000 |
| Vyhodnocení + Shrnutí + Závěr | ~13 % | ~13 000 |

---

## 4. FORMÁTOVÁNÍ TEXTU

- **Vlastní text:** Cambria nebo Times New Roman, velikost **12**
- **Nadpisy:** Verdana nebo Arial (bezpatkové), velikost **14**
- Nadpisy jsou **číslované**, maximálně **3 úrovně** (1. / 1.1 / 1.1.1)
- Vnitřní okraj (hřbet): **3,5 cm**; ostatní okraje: **2 cm**
- Číslo stránky: **dolní okraj, uprostřed**
- Formát papíru: **A4**, 80 g/m²
- Řádkování: **1,5**, řádků na stránku: **30–35**
- Odstavce: **zarovnány do bloku**, dělení slov: **zapnuto**
- Tisk: preferovaný **oboustranný**

---

## 5. JAZYKOVÝ STYL

### Pasivum — VŽDY povinné v celé práci
- ✅ „je uvedeno", „bylo zjištěno", „byl zvolen", „aplikace byla navržena"
- ❌ ZAKÁZÁNO: „autor se rozhodl", „rozhodl jsem", „rozhodli jsme"
- Osobní forma přípustná POUZE v Úvodu (motivace, předpoklady)

### Styl textu
- Akademická, odborná čeština; stylisticky a pravopisně bezchybná
- Bez odrážkových seznamů v prózovém textu — výčty jako věty; výjimku tvoří přehledové tabulky
- Každou technologii nejprve obecně představit, pak konkrétně v kontextu CheckFood
- Používat skutečné názvy tříd, metod, endpointů z kódu

---

## 6. KŘÍŽOVÉ ODKAZOVÁNÍ — ZÁVAZNÁ PRAVIDLA

### 6.1 Kdy odkazovat
Křížové reference se povinně používají v těchto situacích:

1. **Zpětný odkaz na teorii v implementaci** — kdykoli implementační část popisuje technologii, vzor nebo koncept, který byl vysvětlen v teoretické části.
2. **Odkaz na diagram, obrázek nebo tabulku** z jiné kapitoly.
3. **Odkaz dopředu** — pokud se téma detailně rozebírá v pozdější kapitole.
4. **Odkaz na požadavek** — implementační řešení odkazuje na funkční nebo nefunkční požadavek z kap. 1.
5. **Odkaz v závěru** — každý cíl z kap. 2 (Cíl a metodika) musí být v závěru rekapitulován s odkazem.

### 6.2 Povolené formulace křížových odkazů
Používat tyto akademické formulace (vždy v pasivu nebo třetí osobě):

**Odkaz na kapitolu/sekci:**
- „…jak je popsáno v kapitole 2.1…"
- „…jak bylo uvedeno v sekci 1.3.2…"
- „…v kapitole 1.4.2 bylo provedeno srovnání frameworků, na jehož základě byl zvolen…"
- „…podrobný popis architektury je uveden v kapitole 2.1…"
- „…v souladu s požadavky definovanými v sekci 1.2.1…"
- „…jak je detailněji rozvedeno v kapitole 4.2.6…"

**Odkaz dopředu:**
- „…implementace tohoto mechanismu je popsána v kapitole 4.2.6…"
- „…testování je věnována kapitola 5…"

**Odkaz na obrázek/tabulku z jiné kapitoly:**
- „…architektura systému znázorněná na Obrázku 1 (viz kapitola 2.1)…"
- „…viz Tabulka 3 v sekci 1.4.1…"

**Odkaz na požadavek:**
- „…čímž je splněn funkční požadavek definovaný v sekci 1.2.1…"
- „…v souladu s nefunkčním požadavkem na zabezpečení (sekce 1.3.2)…"

**ZAKÁZÁNO:**
- „…jak jsme viděli dříve…" (bez čísla kapitoly)
- „…viz výše…" / „…viz níže…" (nekonkrétní)
- „…jak bylo zmíněno…" (bez odkazu)

### 6.3 Mapa povinných křížových odkazů pro CheckFood

Níže je seznam odkazů, které MUSÍ být v práci přítomny. Při psaní libovolné sekce zkontrolovat, zda relevantní odkaz byl použit.

**Z kap. 2 (Návrh architektury) → kap. 1:**
- Sekce 2.1 odkazuje na 1.3.1 (škálovatelnost jako důvod volby monolitické architektury)
- Sekce 2.1 odkazuje na 1.3.6 (udržovatelnost jako důvod modulárního uspořádání)
- Sekce 2.2 (Frontend) odkazuje na 1.4.1 (zdůvodnění volby Flutter)
- Sekce 2.3 (Backend) odkazuje na 1.4.2 (zdůvodnění volby Spring Boot)
- Sekce 2.4 (REST API) odkazuje na 1.3.2 (HTTPS jako bezpečnostní požadavek)

**Z kap. 3 (Návrh databáze) → kap. 1 a 2:**
- Sekce 3.1 odkazuje na 1.4.3 (zdůvodnění volby PostgreSQL)
- Sekce 3.2.1 (PostGIS) odkazuje na 1.2.1 (funkční požadavek: zobrazení restaurací na mapě)
- Sekce 3.3 odkazuje na 2.3 (backend jako vrstva komunikující s DB)

**Z kap. 4 (Implementace) → kap. 1, 2, 3:**
- Sekce 4.2.1 odkazuje na 1.4.4 (zdůvodnění Docker pro lokální vývoj)
- Sekce 4.2.3 (Docker Compose) odkazuje na 2.1 (přehled architektury a diagram)
- Sekce 4.2.4 (entity) odkazuje na 3.1.1 (návrh entity v DB kapitole)
- Sekce 4.2.5 (REST API) odkazuje na 2.4 (návrh komunikace mezi vrstvami)
- Sekce 4.2.6 (zabezpečení) odkazuje na 1.3.2 (nefunkční požadavek na zabezpečení)
- Sekce 4.2.6 odkazuje na 2.3 (architektura backendu — SecurityFilterChain)
- Sekce 4.2.7 (rezervace) odkazuje na 1.2.1 (funkční požadavek: rezervace stolů)
- Sekce 4.2.8 (objednávky) odkazuje na 1.2.2 (funkční požadavek: objednávky)
- Sekce 4.3.1 (Flutter Clean Architecture) odkazuje na 1.4.1 (volba Flutter)
- Sekce 4.3.2 (BLoC) odkazuje na 2.2 (návrh frontendu — oddělení vrstev)
- Sekce 4.3.4 (ReservationPage — Three.js) odkazuje na 1.2.1 (požadavek 360° vizualizace)
- Sekce 4.3.4 (ExplorePage) odkazuje na 3.2.1 (PostGIS clustering na backendu)
- Sekce 4.5 (CI/CD, Render.com) odkazuje na 1.4.5 (volba cloudové infrastruktury)

**Z kap. 5 (Testování) → kap. 1 a 4:**
- Sekce 5.1 odkazuje na 4.2.5 (REST API endpointy, které jsou testovány)
- Sekce 5.1 odkazuje na 1.3.3 (nefunkční požadavek na výkon)
- Sekce 5.2 odkazuje na 4.3.2 (BLoC, který je testován)

**Z kap. 6 (Vyhodnocení) → kap. 1:**
- Každý funkční požadavek z 1.2 musí být vyhodnocen s odkazem zpět
- Každý nefunkční požadavek z 1.3 musí být vyhodnocen s odkazem zpět

**Ze Závěru → kap. 2 (Cíl a metodika):**
- Každý cíl definovaný v kap. 2 musí být v závěru rekapitulován s odkazem: „…hlavní cíl práce definovaný v kapitole 2, kterým bylo…, byl splněn…"

### 6.4 Odkaz na obrázky a diagramy při prvním výskytu v textu

Každý obrázek a diagram musí být v textu explicitně uveden PŘED nebo NA místě jeho výskytu. Formulace:
- „Celková architektura systému je znázorněna na **Obrázku 1**."
- „Vztahy mezi entitami zachycuje **Obrázek 3** (ER diagram)."
- „Datový tok požadavku na rezervaci je popsán na **Obrázku 5**."

V pozdějších kapitolách při odkazování na tentýž diagram:
- „…architektura znázorněná na Obrázku 1 v kapitole 2.1…"

---

## 7. DIAGRAMY A OBRÁZKY — WORKFLOW S PLACEHOLDERY

### 7.1 Princip workflow

Claude Code **negeneruje** samotné diagramy ani obrázky. Místo toho vloží do textu práce textový placeholder ve standardizovaném formátu. Tento placeholder pak zpracuje Claude desktop, který diagram vygeneruje a dodá jako obrázek.

### 7.2 Formát placeholderu

Každý placeholder musí být vložen přesně v místě, kde má diagram v textu stát, ve tvaru:

```
[DIAGRAM: <číslo> — <název> | Typ: <typ diagramu> | Obsah: <co má diagram zobrazovat> | Zdroj: vlastní]
```

Bezprostředně za placeholderem se uvede popisek v textu práce (ten se zachová i po vložení obrázku):

```
Obrázek <číslo>: <Název diagramu> (vlastní zpracování)
```

### 7.3 Příklady placeholderů pro CheckFood

```
[DIAGRAM: 1 — Architektura systému CheckFood | Typ: systémový diagram (bloky a šipky) | Obsah: tři vrstvy — PREZENTAČNÍ (Flutter aplikace Android/iOS), APLIKAČNÍ (Spring Boot Backend na Cloud Run), DATOVÁ VRSTVA (PostgreSQL na Cloud SQL); externí služby: Google Maps Platform, Notifikační služba; komunikace přes HTTPS/REST API a JPA/JDBC; styl: černobílý, vhodný pro tisk | Zdroj: vlastní]

[DIAGRAM: 2 — Struktura obrazovek zákaznické části Flutter aplikace | Typ: hierarchický diagram navigace | Obsah: OnboardingScreen → LoginPage/RegisterPage; MainShell s 5 bottom tabs: ExplorePage (mapa restaurací), ReservationsScreen, OrdersPage, ProfileScreen, (podmíněně) MyRestaurantPage; z ExplorePage vychází RestaurantDetailPage → ReservationPage | Zdroj: vlastní]

[DIAGRAM: 3 — Vrstvová architektura Spring Boot backendu | Typ: vertikální vrstvový diagram | Obsah: HTTP klient → Controller vrstva (REST endpoints) → Service vrstva (business logika) → Repository vrstva (JPA) → PostgreSQL; bezpečnostní filtr (SecurityFilterChain + JwtAuthenticationFilter) před Controller vrstvou | Zdroj: vlastní]

[DIAGRAM: 4 — Skupiny REST API endpointů | Typ: tabulkový přehled nebo seskupený diagram | Obsah: 20 controllerů rozdělených do skupin: Auth (/api/auth, 8 EP), User (/api/user, 11 EP), OAuth, MFA, Audit, Restaurants (/api/v1/restaurants), MyRestaurant, Reservations, Staff (/api/v1/staff, 12 EP), Orders, Menu, Panorama, atd.; celkem 110 endpointů | Zdroj: vlastní]

[DIAGRAM: 5 — ER diagram databázového modelu CheckFood | Typ: entitně-relační diagram (zjednodušený) | Obsah: klíčové entity a jejich vztahy: users (1—N) devices; users (N—N) roles (via user_roles); roles (N—N) permissions; restaurant (1—N) restaurant_table; restaurant (1—N) restaurant_employee; reservation (N—1) restaurant_table; reservation (1—N) reservation_change_request; customer_order (1—N) order_item; panorama_session (1—N) panorama_photo; uvést typy PK (UUID vs BIGINT) | Zdroj: vlastní]

[DIAGRAM: 6 — Datový tok BLoC pattern na příkladu rezervace | Typ: sekvenční diagram nebo tok dat | Obsah: UI (BlocBuilder) → SubmitReservation event → ReservationBloc → CreateReservationUseCase → ReservationRepositoryImpl → ReservationRemoteDataSource (Dio POST /api/v1/reservations) → Spring Boot → DB; zpětný tok: response → fromJson() → toEntity() → emit state.copyWith(submitSuccess: true) → UI rebuild | Zdroj: vlastní]

[DIAGRAM: 7 — Schéma JWT autentizace a refresh flow | Typ: sekvenční diagram | Obsah: Flutter klient → POST /api/auth/login → AuthController → JwtServiceImpl (vydá access token 15min + refresh token 30d) → klient uloží do flutter_secure_storage; při 401 → AuthInterceptor → RefreshTokenManager → POST /api/auth/refresh → nové tokeny; device binding přes deviceIdentifier | Zdroj: vlastní]

[DIAGRAM: 8 — Panorama stitching workflow | Typ: vývojový diagram (flowchart) | Obsah: Owner spustí OnboardingWizard → kamera + gyroskop → nahrání fotek přes POST /api/v1/panorama/session + /photos → backend uloží do Supabase Storage → zavolá Stitcher FastAPI microservice → OpenCV pipeline (detect → match → stitch) → výsledné panorama uloží do Supabase → callback na backend → restaurant.panorama_url aktualizováno → zákazník vidí 3D pohled přes Three.js WebView | Zdroj: vlastní]

[DIAGRAM: 9 — CI/CD pipeline GitHub Actions | Typ: vývojový diagram | Obsah: git push na main → spustí se paralelně: backend.yml (Maven build → test → Docker build verify) a flutter-android.yml (Flutter build APK); render-healthcheck.yml běží každých 15 minut samostatně (ping /actuator/health → pokud selže → vytvoří GitHub Issue); ci-monitor.yml sleduje výsledky ostatních workflows | Zdroj: vlastní]
```

### 7.4 Pravidla pro placeholdery

- Každý placeholder má **unikátní číslo** odpovídající číslování v textu práce (Obrázek 1, 2, 3, …)
- Placeholder se vkládá **před** popiskem obrázku, na samostatný řádek
- Po vygenerování diagramu Claude desktopem se placeholder **nahradí** skutečným obrázkem; popisek zůstane
- Diagrams jsou **černobílé** nebo s minimem šedých odstínů — vhodné pro tisk A4
- V textu musí být před každým placeholderem věta, která na diagram odkazuje: „…je znázorněno na Obrázku X."

### 7.5 Kde v textu vložit placeholdery (mapa)

| Obrázek | Sekce v práci |
|---------|--------------|
| Obrázek 1 — Architektura systému | sekce 2.1 |
| Obrázek 2 — Struktura obrazovek Flutter | sekce 2.2 |
| Obrázek 3 — Vrstvová architektura backendu | sekce 2.3 |
| Obrázek 4 — Skupiny REST API endpointů | sekce 2.4 |
| Obrázek 5 — ER diagram databáze | sekce 3.1.2 |
| Obrázek 6 — BLoC datový tok | sekce 4.3.2 |
| Obrázek 7 — JWT autentizace a refresh flow | sekce 4.2.6 |
| Obrázek 8 — Panorama stitching workflow | sekce 4.4 |
| Obrázek 9 — CI/CD pipeline | sekce 4.5.1 |

---

## 8. PROVÁZANOST PRÁCE — VZORY FRÁZÍ

### Přechod z teorie do implementace (kap. 4 odkazuje na kap. 1–3)
- „Na základě analýzy provedené v kapitole 1.4.2 byl pro realizaci serverové části zvolen framework Spring Boot…"
- „V souladu s nefunkčním požadavkem na zabezpečení definovaným v sekci 1.3.2 byl implementován mechanismus JWT autentizace…"
- „Datový model navržený v kapitole 3.1.1 byl implementován prostřednictvím JPA entit…"
- „Architektura systému popsaná v kapitole 2.3 se promítá do balíčkové struktury backendu…"
- „Funkční požadavek na rezervaci konkrétního stolu (sekce 1.2.1) byl realizován prostřednictvím…"

### Přechod z implementace do testování (kap. 5 odkazuje na kap. 4)
- „Testování pokrývá endpointy implementované v sekci 4.2.5…"
- „Integrační testy ověřují správnost komunikace mezi vrstvami popsanými v kapitole 2.4…"

### Přechod z vyhodnocení zpět na požadavky (kap. 6 odkazuje na kap. 1)
- „Funkční požadavek na správu rezervací definovaný v sekci 1.2.1 byl plně implementován…"
- „Nefunkční požadavek na škálovatelnost (sekce 1.3.1) je zajištěn bezstavovým návrhem backendu…"

### Závěr odkazující na cíle
- „Hlavní cíl práce formulovaný v kapitole 2, jímž bylo navrhnout a implementovat systém CheckFood, byl splněn…"
- „Dílčí cíle definované v kapitole 2 — návrh databázového modelu, implementace REST API a realizace mobilního klienta — byly splněny…"

---

## 8. CITACE A ZDROJE

- **Norma:** ČSN ISO 690:2022
- **Styl:** číslované odkazy `[1]` — konzistentně v celé práci
- **Řazení:** dle výskytu v textu
- **Bez lokálních seznamů zdrojů** za podkapitolami — POUZE globální seznam na konci
- Odkaz na zdroj musí být tam, kde se začíná pracovat s převzatou informací
- Vlastní dílo: `zdroj: vlastní`

---

## 9. VYUŽITÍ NÁSTROJŮ AI

Dle kap. 5 Výnosu č. 9/2025 musí být v **metodické části** (kap. 2 — Cíl a metodika) uvedeno:
- Název a verze: **Claude Sonnet 4.6**
- Účel: asistence při psaní textu, reformulace, kontrola stylu
- Způsob a rozsah: konkretizovat v práci

---

## 10. POKYNY PRO PSANÍ

1. **Pasivum** — žádné aktivní sloveso s podmětem „autor" mimo Úvod
2. **Bez odrážek v próze** — výčty jako věty; výjimku tvoří přehledové tabulky
3. **Cituj zdroje** — každé faktické tvrzení s odkazem [číslo]
4. **Rozsah** — cíl 100 000 znaků (~55 NS), max. 60 formátovaných stran
5. **Nadpisy číslovat** — max. 3 úrovně
6. **Abstrakt** — 100–200 slov česky i anglicky, 5 klíčových slov
7. **Žádné lokální seznamy zdrojů** za podkapitolami
8. **Nepoužívat** fráze jako „je zřejmé, že", „je důležité poznamenat", „viz výše/níže"
9. **Křížové reference** — vždy s číslem kapitoly/sekce (viz sekce 6)
10. **Inovativní prvky zdůraznit:** 3D panorama rezervace, PostGIS DBSCAN clustering (backend), owner claim přes ARES/BankID, Overture Maps sync, recurring reservations, reservation change requests, granulární employee permissions (11 typů), Google Places API integrace

---

## 11. TECHNOLOGICKÝ STACK — REÁLNÝ STAV IMPLEMENTACE

### 11.1 Backend — Spring Boot

- **Framework:** Spring Boot **3.5.7**
- **Java:** JDK **21** (Eclipse Temurin) — **NIKOLI JDK 17, jak chybně uvádí starší verze práce**
- **Virtual Threads:** Project Loom (`spring.threads.virtual.enabled=true`)
- **Build:** Apache Maven 3.9+ (Maven Wrapper `mvnw`)
- **Port:** 8081 | **Artifact ID:** `checkfood-service`
- **Balíčkový kořen:** `com.checkfood.checkfoodservice`

**Balíčková struktura:**
- `security.module.*` — auth, user, mfa, oauth, audit, device
- `entity`, `repository`, `service`, `controller`, `dto` (MapStruct mapování)

**Klíčové závislosti (pom.xml):**

| Závislost | Verze | Účel |
|-----------|-------|------|
| spring-boot-starter-web | 3.5.7 | REST API |
| spring-boot-starter-data-jpa | 3.5.7 | JPA/Hibernate |
| spring-boot-starter-security | 3.5.7 | Spring Security 6.4.3 |
| spring-boot-starter-oauth2-resource-server | 3.5.7 | OAuth2 Resource Server |
| spring-boot-starter-mail | 3.5.7 | Email (SMTP) |
| spring-boot-starter-actuator | 3.5.7 | Health checks |
| spring-boot-starter-validation | 3.5.7 | Jakarta Bean Validation |
| spring-cloud-starter-openfeign | 2025.0.0 | Feign HTTP klient |
| postgresql | 42.7.6 | PostgreSQL JDBC driver |
| flyway-core + flyway-database-postgresql | managed | DB migrace |
| hibernate-spatial | managed | PostGIS integrace |
| postgis-jdbc | 2.5.0 | PostGIS JDBC |
| jjwt-api/impl/jackson | 0.12.6 | JWT generování/validace |
| google-api-client | 2.4.1 | Google OAuth verifikace |
| mapstruct | 1.5.5.Final | DTO mapping |
| lombok | 1.18.32 | Boilerplate redukce |
| springdoc-openapi-starter-webmvc-ui | 2.8.5 | Swagger/OpenAPI |
| duckdb_jdbc | 1.4.4.0 | Overture Maps analytics |
| h2 | managed (test) | In-memory test DB |

**Bezpečnostní implementace:**
- JWT: HS256, NimbusJwtEncoder/Decoder (JJWT 0.12.6)
- Access token: 15 min (prod) / 1 h (dev); Refresh token: 30 dní (prod) / 24 h (dev)
- Hesla: BCrypt strength 12
- MFA: TOTP HmacSHA1, 30s time step, 6 číslic, ±1 okno tolerance, 8 backup kódů (BCrypt)
- Rate limiting: AOP `@RateLimited`, sliding window, ConcurrentHashMap, per-IP/per-User
- OAuth: Google IdToken verifikace + Apple JWT (JJWT + Apple signing keys přes Feign, 24h cache)
- Audit log: AOP `@Async @EventListener`, 18 typů AuditAction, denní cleanup

**Role systém — ENTITY, NIKOLI ENUM:**
- `RoleEntity` — tabulka `roles`: USER, OWNER, STAFF, ADMIN, MODERATOR, CUSTOMER
- Spojovací tabulky `user_roles` a `role_permissions` (ManyToMany)
- `UserEntity` implementuje `UserDetails` → `getAuthorities()` = `ROLE_` prefix
- ⚠️ Oprava chyby v původní práci: role nejsou Java enum, jsou entity v DB

**Employee permissions (11 typů):**
CONFIRM_RESERVATION, EDIT_RESERVATION, CANCEL_RESERVATION, CHECK_IN_RESERVATION, COMPLETE_RESERVATION, EDIT_RESTAURANT_INFO, EDIT_RESERVATION_DURATION, VIEW_STATISTICS, VIEW_RESTAURANT_INFO, MANAGE_EMPLOYEES, MANAGE_MENU.

**Architektonické zvláštnosti:**
- Domain event systém: `ApplicationEventPublisher` s async listenery
- Feature flags: Strategy pattern (`BooleanFeatureResolver`, `PercentageFeatureResolver`)
- Reservation auto-confirm: `@Scheduled` cron, automatické potvrzení po 15 minutách
- MapStruct pro DTO mapping

---

### 11.2 Flutter — klientská aplikace

- **Dart SDK:** ^3.7.2 | **Verze aplikace:** 1.0.0+1
- **Architektura:** Clean Architecture per modul: `data/` → `domain/` → `presentation/`

**State management — BLoC (flutter_bloc 8.1.6):**
12 BLoC tříd: `AuthBloc`, `UserBloc`, `ExploreBloc`, `RestaurantDetailBloc`, `ReservationBloc`, `MyReservationsBloc`, `OrdersBloc`, `MyRestaurantBloc`, `StaffReservationsBloc`, `OwnerClaimBloc`, `OnboardingWizardBloc`, `LocaleCubit`

**Datový tok (příklad — rezervace):**
`SubmitReservation` event → `ReservationBloc` → `CreateReservationUseCase` → `ReservationRepositoryImpl` → `ReservationRemoteDataSource` (Dio POST) → server → `ReservationResponseModel.fromJson()` → `model.toEntity()` → emit `state.copyWith(submitSuccess: true)` → `BlocBuilder` rebuilds UI

**HTTP klient — Dio 5.4.3:**
- `dioAuth` (bez interceptoru) pro login/register
- Výchozí Dio s `AuthInterceptor` (QueuedInterceptor): Bearer token, 401 → `RefreshTokenManager` s Completer-based deduplikací

**Navigace:**
- Custom `AppRouter`, named routes: `/`, `/login`, `/register`, `/register-owner`, `/claim-restaurant`, `/verify-email`, `/main`
- `RootGuard`: `needsRestaurantClaim` → ClaimPage | `needsOnboarding` → OnboardingWizard | `authenticated` → MainShell | `unauthenticated` → OnboardingScreen
- `MainShell`: 5 bottom tabs, `isAtLeastEmployee` → MyRestaurant tab, IndexedStack

**DI:** GetIt 7.7.0, `lib/core/di/injection_container.dart`, 12 sekcí

**Klíčové závislosti (pubspec.yaml):**

| Závislost | Verze | Účel |
|-----------|-------|------|
| flutter_bloc | 8.1.6 | State management |
| get_it | 7.7.0 | DI |
| dio | 5.4.3 | HTTP klient |
| freezed_annotation | 2.4.1 | Immutable modely |
| json_annotation | 4.9.0 | JSON serializace |
| google_maps_flutter | 2.10.0 | Google Maps |
| geolocator | 13.0.0 | GPS |
| firebase_core | 3.8.1 | Firebase |
| firebase_messaging | 15.2.1 | Push notifikace (FCM připraven) |
| camera | 0.11.0+2 | Panorama capture |
| sensors_plus | 6.1.1 | Gyroskop (panorama úhly) |
| webview_flutter | 4.8.0 | Three.js 3D panorama |
| qr_flutter | 4.1.0 | QR kódy (MFA) |
| sliding_up_panel | 2.0.0+1 | Explore panel |
| google_sign_in | 6.2.1 | OAuth Google |
| sign_in_with_apple | 6.1.1 | OAuth Apple |
| jwt_decoder | 2.0.1 | JWT klient |
| flutter_secure_storage | 9.2.2 | Tokeny |
| shared_preferences | 2.2.3 | Locale, onboarding flag |
| stream_transform | 2.1.0 | Debounce 400ms/300ms |
| intl | any | Lokalizace cs/en, 430 ARB klíčů |
| app_links | 6.3.2 | Deep linking |
| flutter_dotenv | 5.2.1 | .env konfigurace |

**Klíčové obrazovky:**
- `ExplorePage` — Google Maps + SlidingUpPanel + PostGIS clustering + Google Places API
- `RestaurantDetailPage` — SliverAppBar, opening hours, favourite (optimistic update)
- `ReservationPage` — Three.js WebView 3D panorama + JS channel + TableBottomSheet
- `ReservationsScreen` — upcoming + history, cancel, edit, change requests, recurring
- `OrdersPage` — TabBar Menu/Orders, CartSummaryBar, DiningContext, auto-cascade
- `ProfileScreen` — osobní údaje, zařízení soft/hard logout, jazyk, notifikace
- `MyRestaurantPage` — role-based tabs, multi-restaurant podpora
- `StaffReservationsPage` — date picker, **15s polling**, status transitions, propose change
- `OnboardingWizardPage` — 6 kroků, kamera + gyroskop, Three.js editor
- `ClaimRestaurantPage` — ARES + BankID + email 3-step flow

**Google Places API:** `GooglePlacesService`, endpoint `https://places.googleapis.com/v1`, metody `searchNearby`/`searchText`, max 50 km, max 20 výsledků, jazyk cs

---

### 11.3 Panorama stitcher — Python mikroslužba

- Python 3.12, FastAPI 0.115.6 + Uvicorn 0.34.0
- OpenCV (headless) 4.10.0.84, httpx 0.28.1
- Async background tasks + callback pattern zpět na backend
- Supabase Storage (bucket `checkfood-public`)

---

### 11.4 Infrastruktura

**Lokální (Docker Compose) — 3 služby na `checkfood-network`:**
- `db` — `postgis/postgis:15-3.4-alpine`, port 5433, healthcheck `pg_isready`
- `stitcher` — FastAPI, port 8090, sdílený volume uploads
- `app` — Spring Boot, port 8081, `depends_on db:healthy`

**Dockerfile (multi-stage):**
Stage 1: `maven:3.9-eclipse-temurin-21` → `mvn clean package -DskipTests`
Stage 2: `eclipse-temurin:21-jre`, `java -jar app.jar --server.port=${PORT}`

**Produkce — Render.com + Supabase:**
- Backend: Render.com Docker web service, free plan, auto-deploy z main
- `render.yaml`: service `checkfood-api`, health check `/actuator/health`, port 10000
- DB + Storage: Supabase (PostgreSQL + bucket `checkfood-public`)
- ⚠️ Starší části práce popisují GCP — zachovat jako historickou fázi, doplnit aktuální stav

**Spring profily:** `local` (Docker, DEBUG), `test` (H2), `prod` (Render + Supabase)

**CI/CD — 5 GitHub Actions workflows:**
- `backend.yml` — Maven build + test + Docker verify
- `flutter-android.yml` — build APK artifact
- `flutter-android-release.yml` — build APK + GitHub Release
- `ci-monitor.yml` — auto-creates GitHub Issues on CI failure
- `render-healthcheck.yml` — 15-min health check + auto-issue (ping free tier)

---

## 12. KOMPLETNÍ DATABÁZOVÉ SCHÉMA (26 entit)

### 12.1 Přehled entit

| Entita | PK typ | Popis |
|--------|--------|-------|
| `users` (UserEntity) | BIGINT IDENTITY | Uživatelé; implementuje UserDetails |
| `roles` (RoleEntity) | BIGINT IDENTITY | Role (USER, OWNER, STAFF, ADMIN, MODERATOR, CUSTOMER) |
| `permissions` | BIGINT IDENTITY | Oprávnění systému |
| `user_roles` | composite FK | ManyToMany User ↔ Role (LAZY) |
| `role_permissions` | composite FK | ManyToMany Role ↔ Permission (EAGER) |
| `devices` | BIGINT IDENTITY | Zařízení uživatele (FCM, soft/hard logout) |
| `verification_tokens` | BIGINT IDENTITY | UUID tokeny pro verifikaci emailu (24h) |
| `mfa_secrets` | BIGINT IDENTITY | TOTP secret (Base32), OneToOne UNIQUE |
| `mfa_backup_codes` | BIGINT IDENTITY | 8 backup kódů MFA (BCrypt) |
| `audit_logs` | BIGINT IDENTITY | 18 typů auditních akcí |
| `restaurant` | UUID | Restaurace; PostGIS Point(4326) |
| `restaurant_opening_hours` | kolekce embedded | Otevírací hodiny (7 dnů) |
| `restaurant_special_days` | kolekce embedded | Speciální dny/svátky |
| `restaurant_tag` | kolekce | Tagy restaurace |
| `restaurant_table` | UUID | Stoly; yaw/pitch pro 3D panorama |
| `restaurant_table_group` + `_item` | UUID | Skupiny stolů |
| `restaurant_employee` | BIGINT IDENTITY | Zaměstnanci (OWNER/MANAGER/STAFF/HOST) |
| `restaurant_employee_permissions` | kolekce | Granulární oprávnění (11 typů) |
| `menu_category` | UUID | Kategorie menu |
| `menu_item` | UUID | Položky; `price_minor` INT (haléře) |
| `reservation` | UUID | Rezervace; open-ended (end_time nullable) |
| `recurring_reservation` | UUID | Opakující se rezervace (týdenní) |
| `reservation_change_request` | UUID | Návrhy změn (staff → zákazník) |
| `customer_order` | UUID | Objednávky; `total_price_minor` INT |
| `order_item` | UUID | Položky objednávky; denormalizovaný snapshot |
| `user_favourite_restaurant` | BIGINT IDENTITY | Oblíbené restaurace |
| `panorama_session` | UUID | Session stitchingu |
| `panorama_photo` | UUID | Snímky s úhly (target/actual) |

### 12.2 Klíčová technická rozhodnutí

- **UUID vs BIGINT:** UUID pro doménové entity (brání enumeraci v API), BIGINT pro systémové
- **Minor currency units:** `price_minor`, `unit_price_minor`, `total_price_minor` jako INT (haléře/centy) — eliminace floating-point chyb
- **FK by value:** cross-aggregate FK jako plain UUID/Long bez `@ManyToOne`; JPA join pouze uvnitř agregátu
- **Denormalizovaný snapshot:** `order_item.item_name` + `unit_price_minor` = snapshot v okamžiku objednávky
- **PostGIS:** `location geometry(Point,4326)` v `restaurant`; DBSCAN clustering na backendu, K-NN proximity search

### 12.3 ReservationStatus enum
PENDING_CONFIRMATION, CONFIRMED, RESERVED, CHECKED_IN, REJECTED, CANCELLED, COMPLETED

---

## 13. REST API (110 endpointů, 20 controllerů)

| Controller | Prefix | Poznámka |
|-----------|--------|----------|
| AuthController | `/api/auth` | 8 EP, @RateLimited |
| UserController | `/api/user` | 11 EP, authenticated / ADMIN |
| OAuthController | `/api/oauth` | 1 EP |
| MfaController | `/api/mfa` | 5 EP |
| AuditController | `/api/admin/audit` | 2 EP, ADMIN only |
| RestaurantController | `/api/v1/restaurants` | 9 EP, public / OWNER |
| MyRestaurantController | `/api/my-restaurant` | 11 EP, OWNER/MANAGER/STAFF |
| ReservationController | `/api/v1/reservations` | 11 EP, authenticated / public |
| RecurringReservationController | `/api/v1/recurring-reservations` | 3 EP |
| StaffReservationController | `/api/v1/staff` | 12 EP, OWNER/MANAGER/STAFF |
| OrderController + MenuController + FavouriteController + PanoramaController + ostatní | různé | zbývající EP |

---

## 14. ZÁVAZNÁ OSNOVA — HLAVNÍ KAPITOLY

Hlavní kapitoly jsou závazné, podnadpisy lze upravovat a doplňovat.

```
Úvod
1. Analýza problému
   1.1 Současné přístupy a existující řešení
   1.2 Funkční požadavky na systém
       1.2.1 Funkce zákazníka
       1.2.2 Funkce manažera a zaměstnance
   1.3 Nefunkční požadavky na systém
       1.3.1 Škálovatelnost
       1.3.2 Zabezpečení
       1.3.3 Výkon a odezva databáze
       1.3.4 Spolehlivost a dostupnost
       1.3.5 Použitelnost a přístupnost  ← CHYBÍ, nutno doplnit
       1.3.6 Udržovatelnost a rozšiřitelnost
   1.4 Výběr technologií a jejich srovnání
       1.4.1 Frontend (Flutter vs React Native vs Xamarin)
       1.4.2 Backend (Spring Boot vs Node.js vs Django)
       1.4.3 Databáze (PostgreSQL vs MySQL vs MongoDB)
       1.4.4 Nástroje pro lokální vývoj (Docker)
       1.4.5 Cloudová infrastruktura (historicky GCP, aktuálně Render.com + Supabase)
2. Návrh architektury systému
   2.1 Přehled architektury + Obrázek 1 (systémový diagram)
   2.2 Frontend + Obrázek 2 (struktura obrazovek)
   2.3 Backend + Obrázek 3 (vrstvová architektura)
   2.4 Komunikace mezi vrstvami + Obrázek 4 (API skupiny)
3. Návrh databáze
   3.1 Struktura databázového modelu
       3.1.1 Entity a jejich atributy
       3.1.2 Vztahy mezi entitami + Obrázek 5 (ER diagram)
   3.2 Optimalizace databáze
       3.2.1 Prostorové dotazy a PostGIS  ← NOVÁ SEKCE
   3.3 Implementace v PostgreSQL
4. Realizace a implementace systému
   4.1 Správa verzí a proces vývoje
   4.2 Realizace serverové části (Backend)
       4.2.1 Konfigurace vývojového prostředí (JDK 21, Maven, Virtual Threads)
       4.2.2 Struktura projektu a konfigurace souborů
       4.2.3 Implementace kontejnerizace a konfiguračních profilů
       4.2.4 Implementace datové vrstvy (entity, repozitáře, MapStruct)
       4.2.5 Implementace REST API (110 endpointů, Swagger)
       4.2.6 Zabezpečení API (JWT, MFA/TOTP, OAuth2, RBAC, Rate limiting, Audit)
       4.2.7 Pokročilé rezervační funkce (recurring, change requests, auto-confirm)
       4.2.8 Business logika objednávek a dining context
       4.2.9 Overture Maps data synchronizace (DuckDB, S3 Parquet)
   4.3 Realizace klientské části (Flutter)
       4.3.1 Architektura frontendu (Clean Architecture, BLoC, GetIt)
       4.3.2 State management na příkladu rezervace
       4.3.3 Navigace a autentizace (AppRouter, RootGuard, AuthInterceptor)
       4.3.4 Klíčové obrazovky a jejich implementace
       4.3.5 Komunikace s REST API (Dio, Freezed, error handling)
       4.3.6 Lokalizace (cs/en, flutter_localizations, 430 klíčů, LocaleCubit)
   4.4 Panorama stitcher mikroslužba (Python/FastAPI, OpenCV)
   4.5 Nasazení systému a CI/CD
       4.5.1 GitHub Actions pipelines (5 workflows)
       4.5.2 Nasazení backendu na Render.com
       4.5.3 Databáze a storage na Supabase
5. Testování systému
   5.1 Testování backendu (JUnit 5 + MockMvc — 79 testů ve 13 třídách)
   5.2 Testování klientské aplikace (bloc_test + mocktail — 28 testů)
   5.3 Testování integrace a manuální testování
6. Vyhodnocení výsledků
   6.1 Splnění funkčních a nefunkčních požadavků
   6.2 Výkonnost systému na základě testů
Shrnutí a diskuse výsledků
Závěry a doporučení
Seznam zdrojů
Seznam obrázků
Seznam tabulek
Seznam výpisů kódu
Přílohy
Zadání práce z IS STAG
```

---

## 15. IDENTIFIKOVANÉ CHYBY V AKTUÁLNÍ VERZI PRÁCE

| # | Chyba | Závažnost |
|---|-------|-----------|
| 1 | Abstrakt patří práci „Teorie her v ekonomii" | KRITICKÁ |
| 2 | Lokální seznamy zdrojů za každou podkapitolou | KRITICKÁ |
| 3 | Duplikované číslo podkapitoly 1.2.1 a zduplovaná sekce 1.3.4 | Vysoká |
| 4 | Odrážkové seznamy v sekcích 1.2.2–1.2.5 místo prózy | Střední |
| 5 | GCP popsán jako produkce (správně: Render.com + Supabase) | Střední |
| 6 | JDK 17 uvedeno místo JDK 21 + Project Loom | Střední |
| 7 | Role popsány jako Java enum místo RoleEntity (ManyToMany) | Střední |
| 8 | Zadání bakalářské práce „Teorie her v ekonomii" na poslední straně | Vysoká |
| 9 | Poděkování uvádí „bakalářské práce" místo „diplomové práce" | Nízká |
| 10 | Nedokončené kapitoly (pouze nadpisy bez textu) v kap. 3–7 | KRITICKÁ |
| 11 | Chybí sekce 1.3.5 Použitelnost a přístupnost | Střední |

---

## 16. VĚCI V KÓDU, KTERÉ CHYBÍ V TEXTU PRÁCE

| # | Co chybí | Kde začlenit |
|---|----------|-------------|
| 1 | PostGIS DBSCAN clustering, K-NN | sekce 3.2.1 |
| 2 | OAuth2 + MFA/TOTP + Audit + Rate limiting + Device mgmt | sekce 4.2.6 |
| 3 | Panorama stitcher (FastAPI, OpenCV, callback) | sekce 4.4 |
| 4 | 3D panorama (Three.js WebView, JS channel, yaw/pitch) | sekce 4.3.4 |
| 5 | Overture Maps (DuckDB, S3 Parquet, cron sync) | sekce 4.2.9 |
| 6 | Owner claim (ARES, BankID, email fallback) | sekce 4.3.4 |
| 7 | Onboarding wizard (6 kroků, kamera, gyroskop) | sekce 4.3.4 |
| 8 | CI/CD (5 GitHub Actions workflows) | sekce 4.5 |
| 9 | Dining context + objednávky (grace window, price calc) | sekce 4.2.8 |
| 10 | Lokalizace cs/en (430 ARB klíčů, LocaleCubit) | sekce 4.3.6 |
| 11 | Recurring reservations + change requests | sekce 4.2.7 + 4.3.4 |
| 12 | Google Places API klientská integrace | sekce 4.3.4 |
| 13 | Feature flags (Strategy pattern) | zmínka v kap. 2 |
| 14 | Domain event systém (ApplicationEventPublisher) | zmínka v kap. 2 |
| 15 | MapStruct DTO mapping | zmínka v 4.2 |
| 16 | Reservation auto-confirm (@Scheduled, 15 min) | zmínka v 4.2.7 |
| 17 | Multi-restaurant support | zmínka v 4.3 |

---

## 17. VĚCI V PRÁCI, KTERÉ CHYBÍ V KÓDU

1. **Platby** — stub `StripePaymentClient`/`MockPaymentClient` → **plánované rozšíření**
2. **Push notifikace** — FCM token připraven, odesílání chybí → **plánované rozšíření**
3. **Statistiky** — stub `BusinessMetricsService` → **plánované rozšíření**
4. **Flyway migrace** — `db/migration/` prázdný, Hibernate DDL auto → **přechodný stav**, doporučit migraci
5. **WebSocket** — není; aktuální řešení je **15s polling** na StaffReservationsPage
6. **Caching** — feature flag `CACHE_ENABLED` bez implementace → **budoucí optimalizace**

---

## 18. TESTOVÁNÍ — AKTUÁLNÍ STAV

**Backend (JUnit 5 + MockMvc):** 13 tříd + BaseAuthIntegrationTest, H2 in-memory, **79 testovacích metod**
Pokrytí: registrace (5), login (5), verifikace emailu (6), refresh (4), logout (3), protected EP (7), OAuth (4), edge cases (3), device mgmt (3), MyRestaurant autorizace (7), favourites (6), rezervace (26)

**Flutter (bloc_test + mocktail):** 4 soubory, **28 testovacích metod**
ReservationBloc (10), RestaurantDetailBloc (6), MyRestaurantBloc (5), MyRestaurantVisibility (7)
1 stale `widget_test.dart` — nezapočítávat

---

## 19. SHRNUTÍ DOSAŽENÝCH VÝSLEDKŮ (pro Závěr)

- 110 REST endpointů, 20 controllerů
- 26 databázových entit (vč. embeddables)
- 12 BLoC tříd v klientské aplikaci
- 79 backend + 28 Flutter testů (107 celkem)
- Kompletní zákaznický flow: registrace → verifikace → login → explore → rezervace → objednávka
- Management flow: restaurace, zaměstnanci s 11 granulárními oprávněními, menu, panorama
- Owner onboarding wizard (6 kroků)
- 5 GitHub Actions CI/CD workflows

**Plánovaná rozšíření:** platební integrace (Stripe stub), push notifikace (FCM stub), statistiky, WebSocket (nyní polling), Redis cache, Flyway migrace.

---

## 20. DOPORUČENÉ ZDROJE

**Zachovat:** SOMMERVILLE (SW Engineering), NEWMAN (Microservices), KATAMREDDY+UPADHYAYULA (Spring Boot 3), BAILEY+BIESSEK (Flutter), NIELSEN (Usability), PostgreSQL docs, Flutter docs, Google Maps docs.

**Doplnit:** MARTIN (Clean Architecture, 2017), RFC 7519 (JWT), RFC 6238 (TOTP), RFC 6749 (OAuth 2.0), PostGIS docs, BLoC Library docs, Three.js docs, OpenCV docs, Render.com docs, Supabase docs, Docker docs, Overture Maps Foundation, DELOITTE (Restaurant of the Future, 2021).

**Minimum:** 20–30 zdrojů, alespoň 5 tištěných/e-book.

---

## 21. VZORY POVINNÝCH STRAN

### Titulní list
```
Univerzita Hradec Králové
Fakulta informatiky a managementu
Katedra informatiky a kvantitativních metod

Vývoj aplikace pro správu rezervací a objednávek v gastronomii
Diplomová práce

Autor: Bc. Rostislav Jirák
Studijní obor: Aplikovaná informatika

Vedoucí práce: doc. Mgr. Tomáš Kozel, Ph.D.
Katedra informatiky a kvantitativních metod

Hradec Králové srpen 2026
```

### Abstrakt — klíčová slova
- Česky: Flutter, Spring Boot, PostgreSQL, rezervační systém, mobilní aplikace
- Anglicky: Flutter, Spring Boot, PostgreSQL, reservation system, mobile application

---

*Tento soubor je závazný pro celý projekt.*
*Poslední aktualizace: duben 2026 — Výnos děkanky FIM č. 9/2025 (ověřeno z primárního zdroje) + PDF práce + DIPLOMKA_PROMPT.md*
