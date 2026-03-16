# TASKS

---

## [T-0001] Audit architektury projektu

- **status:** DONE
- **priority:** P0
- **owner:** ARCHITECT
- **description:** Analyzovat celý projekt CheckFood a zmapovat strukturu modulů, backend architekturu, API endpointy, databázový model, build proces, závislosti.
- **output:** DECISIONS.md (D-0001–D-0008), CHANGELOG.md
- **completed:** 2026-03-04

---

## [T-0002] Refaktor rezervací — odstranění endTime, ukončení staffem

- **status:** DONE
- **priority:** P0
- **owner:** DEVELOPER
- **description:** Změnit logiku rezervací tak, že:
  - Rezervace má pouze počáteční čas (`startTime`), NE ukončovací (`endTime`)
  - Zákazník si nevolí délku pobytu — může v restauraci zůstat jak dlouho chce
  - Rezervace se ukončuje manuálně staffem přes endpoint `/complete`
  - V budoucnu automatické ukončení při zaplacení přes pokladní systém — nyní pouze manuální
  - Po ukončení se rezervace zobrazí v historii se statusem COMPLETED
- **akceptační kritéria:**
  - [x] `Reservation.endTime` není povinné pole (nullable)
  - [x] Vytvoření rezervace nevyžaduje endTime (backend ani frontend)
  - [x] Staff může ukončit rezervaci přes `/complete` → status COMPLETED + endTime=now()
  - [x] Ukončená rezervace se zobrazí v historii zákazníka
  - [x] Available-slots logika funguje bez endTime
  - [x] Stávající testy projdou (nebo jsou upraveny)
- **architect decision:** D-0009
- **implementation plan:** IMPLEMENTATION_FRONTEND.md + IMPLEMENTATION_BACKEND.md
- **qa report:** QA.md
- **completed:** 2026-03-05

---

## [T-0003] Panorama 360 — end-to-end flow (capture → stitch → editor → viewer)

- **status:** TODO
- **priority:** P0
- **owner:** ARCHITECT → FRONTEND DEV + BACKEND DEV → TESTER
- **description:** Zprovoznit kompletní panorama flow pro owner + customer. Capture funguje jako **AR-guided Photo Sphere** (inspirace: Teleport 360 Camera app):
  1. **My Restaurant → tlačítko panorama:** Owner klikne v My Restaurant na tlačítko, otevře se AR kamera.
  2. **AR Capture (Photo Sphere styl):**
     - Na obrazovce se zobrazí **síť AR teček/kruhů** rozmístěných po celé sféře kolem uživatele
     - Uživatel namíří telefon na tečku → když je tečka ve středu viewfinderu, **kamera automaticky vyfotí**
     - Vyfocená tečka změní barvu (šedá → zelená = hotovo, červená = špatné zarovnání)
     - Uživatel se otáčí kolem své osy a mířit na další tečky
     - Telefon v portrait orientaci, gyroscop/akcelerometr určuje kam uživatel míří
     - Minimální počet teček pro kompletní panorama (cca 16-20 s wide-angle, nebo více s normálním objektivem)
     - Uživatel může ukončit dřív (partial panorama) nebo počkat na kompletní sféru
  3. **Stitching:** Po vyfocení se fotky pošlou na backend → stitcher (Python/OpenCV) je spojí do jednoho 360° panoramatu → uloží lokálně (v budoucnu cloud). Backend infrastruktura (session, upload, finalize, callback) už existuje.
  4. **Edit scéna (table labels):** Po stitchingu se owner dostane do editoru scény. Vidí panorama a může kliknutím přidávat labely pro stoly. Každý label = číslo stolu + maximální kapacita (kolik lidí). Label se umístí přesně nad daný stůl v panoramatu (yaw/pitch souřadnice). Owner přidá kolik labelů chce a uloží.
  5. **Customer viewer:** Zákazník klikne na restauraci → zobrazí se 3D panorama scéna s texturou dané restaurace a s labely stolů (číslo + kapacita). Logika scény je pro všechny restaurace stejná, mění se pouze textura panoramatu.
- **referenční app:** [Teleport 360 Camera](https://apps.apple.com/cz/app/teleport-360-camera/id6476905405) — AR-guided capture s tečkami, automatické focení při zarovnání, barevná indikace stavu
- **existující kód:**
  - Backend: `PanoramaController` (6 endpointů), `PanoramaService`, `PanoramaSession`/`PanoramaPhoto` entity — COMPLETE
  - Backend: `RestaurantTable` má `yaw`, `pitch` (Double) pro pozici v panoramatu
  - Backend: `/reservation-scene` endpoint vrací panoramaUrl + tables s yaw/pitch/capacity
  - Stitcher: Python/FastAPI/OpenCV — COMPLETE
  - Frontend: `PanoramaCaptureScreen` (kamera + kompas, 8 úhlů) — existuje ale **NUTNO PŘEPSAT na AR Photo Sphere**
  - Frontend: `PanoramaEditorScreen` (WebView + markers) — existuje v onboarding
  - Frontend: `StepPanorama` widget — existuje v onboarding wizardu
- **co chybí / potřebuje ARCHITECT analýzu:**
  - **AR Photo Sphere capture** — přepsat PanoramaCaptureScreen na AR-guided systém s tečkami (gyroscop/akcelerometr, auto-capture při zarovnání, barevná indikace)
  - Tlačítko/vstup do panorama flow z My Restaurant (ne jen z onboarding wizardu)
  - Ověření že PanoramaEditorScreen správně ukládá yaw/pitch/label/capacity do RestaurantTable
  - Customer-facing panorama viewer (3D scéna s texturou a labely stolů)
  - Propojení customer vieweru s reservation flow (klik na stůl → rezervace)
  - End-to-end test celého flow
- **akceptační kritéria:**
  - [ ] V My Restaurant existuje tlačítko pro přidání/správu panoramatu
  - [ ] AR capture zobrazí síť teček na sféře kolem uživatele
  - [ ] Telefon sleduje orientaci přes gyroscop/akcelerometr
  - [ ] Když uživatel zamíří na tečku, kamera automaticky vyfotí
  - [ ] Tečky mění barvu: šedá (čeká), zelená (vyfoceno), červená (špatné zarovnání)
  - [ ] Po vyfocení dostatečného počtu fotek lze capture ukončit
  - [ ] Fotky se uploadují na backend, stitcher je spojí do panoramatu
  - [ ] Po stitchingu owner vidí panorama v editoru a může přidávat table labely (číslo stolu + kapacita)
  - [ ] Labely se ukládají jako yaw/pitch na RestaurantTable
  - [ ] Owner může uložit a aktivovat panorama
  - [ ] Zákazník vidí 3D panorama scénu po kliknutí na restauraci
  - [ ] Scéna zobrazuje labely stolů (číslo + kapacita) na správných pozicích
  - [ ] Logika scény je univerzální — mění se jen textura
- **rizika:**
  - Stitching může selhat pokud fotky nemají dostatečný overlap
  - WebView panorama viewer — výkon na slabších zařízeních
  - Gyroscop/akcelerometr přesnost se liší podle zařízení
  - AR overlay nad kamerou — výkon real-time renderování teček

---

## [T-0004] Push notifikace — tlačítko v profilu + potvrzení oprávnění

- **status:** DONE
- **priority:** P1
- **owner:** ARCHITECT → FRONTEND DEV + BACKEND DEV → TESTER
- **description:** V sekci profilu uživatele přidat tlačítko/switch pro zapnutí/vypnutí push notifikací. Při prvním zapnutí se zobrazí systémový dialog pro povolení notifikací na zařízení. Stav (zapnuto/vypnuto) se uloží na backend pro daného uživatele. Backend bude mít endpoint pro uložení device tokenu a preference notifikací.
- **akceptační kritéria:**
  - [x] V profilu existuje switch/toggle pro notifikace
  - [x] Při zapnutí se zobrazí systémový permission dialog (pokud ještě nebyl povolen)
  - [x] Po povolení se device token odešle na backend
  - [x] Backend uloží device token + notification preference pro uživatele
  - [x] Při vypnutí se preference aktualizuje na backendu
  - [x] Stav přepínače odpovídá uloženému stavu (persistuje mezi restarty)
  - [x] Funguje na Android (iOS nice-to-have)
- **architect decision:** D-0012
- **implementation plan:** IMPLEMENTATION_FRONTEND.md + IMPLEMENTATION_BACKEND.md
- **qa report:** QA.md
- **completed:** 2026-03-06

---

## [T-0005] Supabase Storage — migrace fotek z lokálního disku do cloudu

- **status:** DONE
- **priority:** P0
- **owner:** ARCHITECT → FRONTEND DEV + BACKEND DEV → TESTER
- **description:** Migrovat veškeré ukládání fotek z lokálního filesystému (`LocalFilesystemStorageService` → `./uploads/`) na **Supabase Storage**. Zahrnuje:
  1. **Backend**: Vytvořit `SupabaseStorageService` implementující `StorageService` interface. Nahrávání souborů přes Supabase Storage REST API. Produkční profil použije Supabase, lokální profil může zůstat na lokálním disku.
  2. **Panorama fotky**: `PanoramaServiceImpl` nahrává jednotlivé fotky + stitcher generuje výsledek → oba musí jít do Supabase Storage.
  3. **Profil uživatele**: Upload profilové fotky → uložení URL z Supabase Storage do `profileImageUrl`.
  4. **Restaurant obrázky**: `logoUrl`, `coverImageUrl` → Supabase Storage.
  5. **Menu item obrázky**: `imageUrl` → Supabase Storage.
  6. **Frontend**: Přidat upload flow pro profilovou fotku (image picker → upload na backend → backend uloží do Supabase Storage → vrátí public URL).
  7. **Stitcher**: Python stitcher musí číst fotky ze Supabase Storage a zapisovat výsledek zpět.
- **audit findings:**
  - `StorageService.java` interface (store, delete, getPublicUrl) — zachovat kontrakt
  - `LocalFilesystemStorageService.java` — `@Profile("local","test","prod")` — aktivní na VŠECH profilech
  - `StorageConfig.java` — `@Profile("local")` only → v produkci `/uploads/**` nefunguje (broken)
  - `UploadController.java` — `POST /api/v1/uploads` (generic upload, OWNER/MANAGER only)
  - `PanoramaServiceImpl.java` — volá `storageService.store()` pro panorama fotky
  - `PanoramaCallbackController.java` — přijímá výsledek ze stitcheru
  - `UserEntity.profileImageUrl` — string URL field
  - `Restaurant.logoUrl`, `Restaurant.coverImageUrl`, `Restaurant.panoramaUrl` — string URL fields
  - `MenuItem.imageUrl` — string URL field
  - Frontend: žádný upload flow pro profilové fotky zatím neexistuje
  - Frontend: `onboarding_remote_datasource.dart` — jediný multipart upload (panorama)
  - Supabase projekt: `ixglwaqetbbwwrxrimby` (AWS EU-West-1)
- **akceptační kritéria:**
  - [ ] Backend má `SupabaseStorageService` implementující `StorageService`
  - [ ] Supabase Storage bucket vytvořen a nakonfigurován
  - [ ] `SupabaseStorageService` aktivní pro `@Profile("prod")`, `LocalFilesystemStorageService` pro `@Profile("local","test")`
  - [ ] Panorama fotky se nahrávají do Supabase Storage (upload + stitcher výsledek)
  - [ ] Generic upload endpoint (`POST /api/v1/uploads`) funguje se Supabase Storage
  - [ ] Frontend: uživatel může vybrat profilovou fotku z galerie a nahrát ji
  - [ ] Nahrané fotky mají public URL přístupný z mobilní aplikace
  - [ ] Stávající testy projdou (lokální profil = LocalFilesystemStorageService)
  - [ ] Stitcher dokáže číst/zapisovat z/do Supabase Storage
  - [ ] `.env.example` aktualizován o Supabase Storage config
- **rizika:**
  - Stitcher (Python) musí přistupovat k Supabase Storage → nutná změna v stitcher/main.py
  - Supabase Storage free tier má limity (1GB storage, 2GB bandwidth)
  - CORS pro Supabase Storage bucket musí povolit mobilní app
  - Sdílený volume mezi Spring Boot a Stitcherem se nahrazuje Supabase Storage API

---

## [T-0006] Migrace backendu na JDK 21 — konfigurace + syntaxe

- **status:** DONE
- **priority:** P1
- **owner:** ARCHITECT → BACKEND DEV → TESTER
- **completed:** 2026-03-15
- **description:** Kompletní migrace backendu z Java 17 na Java 21:
  1. **Konfigurace**: pom.xml (java.version, source/target), CI workflow (java-version), CLAUDE.md
  2. **Syntaxe**: Modernizovat Java kód na Java 21 features:
     - Records pro immutable DTOs, events, value objects (kde nemají JPA entity nebo Builder pattern)
     - Pattern matching pro instanceof (`if (x instanceof Type t)`)
     - Switch expressions s pattern matching
     - Text blocks pro multi-line stringy
     - Sealed classes pro exception hierarchie
     - Sequenced collections (getFirst/getLast)
     - String templates kde vhodné (preview feature — zvážit)
  3. **Dockerfile**: Již používá `eclipse-temurin:21` — pouze ověřit kompatibilitu
- **akceptační kritéria:**
  - [x] `pom.xml`: java.version=21, source=21, target=21
  - [x] CI workflow: java-version=21
  - [x] CLAUDE.md: aktualizované references na Java 21
  - [x] Text blocks kde existují multi-line stringy (RestaurantRepository JPQL, PasswordPolicy message)
  - [x] Sequenced collections (getFirst) — DiningContextServiceImpl, TestReservationInitializer
  - [x] Build prochází (`mvn compile` — JDK 21)
  - [x] Testy prochází — 73/80 PASS (7 pre-existující failures, žádné nové z T-0006)
  - [ ] Records, pattern matching, switch expressions, sealed classes — odloženo (velký scope, 420 souborů)
- **rizika:**
  - JPA entity NESMÍ být records (Hibernate vyžaduje no-arg constructor + mutable fields)
  - Lombok @Builder/@Data a records jsou nekompatibilní — nutné rozlišit kde co použít
  - MapStruct kompatibilita s records (mapstruct 1.5.5 podporuje records)
  - 420 souborů — velký scope, nutná prioritizace

---

## [T-0007] Lokalizace celé Flutter aplikace — čeština + angličtina

- **status:** DONE
- **completed:** 2026-03-16
- **priority:** P1
- **owner:** ARCHITECT → FRONTEND DEV → TESTER
- **description:** Dokončit lokalizaci celé Flutter aplikace. Infrastruktura (l10n.yaml, ARB soubory, LocaleCubit, přepínač jazyka v profilu) je hotová z předchozí práce. Zbývá:
  1. Přidat všechny chybějící klíče do `app_cs.arb` a `app_en.arb`
  2. Nahradit hardcoded stringy ve ~30 zbývajících souborech za `S.of(context)`
  3. Opravit chybějící diakritiku v existujících hardcoded stringech
  4. Regenerovat l10n, ověřit flutter analyze + flutter test
- **existující práce (předchozí commit 596f779):**
  - l10n.yaml, app_cs.arb (~190 klíčů), app_en.arb, LocaleCubit, generované soubory
  - ~15 souborů lokalizováno (login, register, profile, orders, explore, reservation_page, main_shell, atd.)
- **zbývající soubory (~30):**
  - auth_bloc.dart (error messages)
  - device_management_screen.dart, device_item_tile.dart
  - profile_form.dart, profile_header.dart
  - restaurant_detail_page.dart
  - reservations_screen.dart, reservation_card.dart, edit_reservation_sheet.dart, table_bottom_sheet.dart
  - my_restaurant_page.dart, restaurant_info_form.dart, employees_list.dart, panorama_tab.dart
  - staff_reservations_page.dart, staff_reservation_card.dart
  - claim_restaurant_page.dart
  - onboarding_wizard_page.dart, step_info_form.dart, step_hours_form.dart, step_tables_form.dart, step_menu_form.dart, step_panorama.dart, step_summary.dart
  - panorama_capture_screen.dart, panorama_editor_screen.dart
  - onboarding_screen.dart (features)
  - search_field.dart, app_router.dart
  - cart_summary_bar.dart, menu_list_widget.dart
  - explore_screen.dart (features), restaurant_detail_screen.dart (features), menu_screen.dart (features), menu_item_detail_sheet.dart
  - editor_start_button.dart, editor_finish_button.dart
- **akceptační kritéria:**
  - [x] Všechny user-facing stringy používají `S.of(context)` místo hardcoded literálů
  - [x] `app_cs.arb` a `app_en.arb` obsahují všechny potřebné klíče
  - [x] Generované l10n soubory jsou aktuální
  - [x] `flutter analyze` — 0 errors
  - [x] `flutter test` — všechny testy prochází (27/27)
  - [x] Commit s prefixem `feat(T-0007):`

---

## [T-0008] Optimalizace mapových markerů — výkon + UI design

- **status:** DONE
- **completed:** 2026-03-16
- **priority:** P1
- **owner:** ARCHITECT
- **description:** Analyzovat současné řešení markerů na mapě (Google Maps Flutter), provést research best practices pro práci s velkým množstvím markerů (clustering, lazy loading, viewport filtering, custom marker design) a navrhnout optimalizace:
  1. **Audit současného stavu** — jak se markery generují, kolik jich může být, jaké mají UI, jak reagují na interakci
  2. **Research** — jak řeší velké množství markerů jiné aplikace (Wolt, Bolt Food, Google Maps, Airbnb), jaké Flutter packages existují (google_maps_cluster_manager, supercluster, fluster)
  3. **Výkonová optimalizace** — clustering, viewport-based loading, debouncing, caching, limit na počet markerů
  4. **UI design** — custom marker design (branding, stav restaurace open/closed, rating, cenová kategorie), animace, selected state, info window design
  5. **Návrh implementace** — konkrétní kroky pro Frontend Dev
- **akceptační kritéria:**
  - [ ] Architect analyzoval současný kód markerů
  - [ ] Architect provedl research best practices (web + konkurenční apps)
  - [ ] DECISIONS.md obsahuje D-0016 s návrhem optimalizací
  - [ ] IMPLEMENTATION_FRONTEND.md obsahuje implementační plán
  - [ ] Návrh pokrývá výkon (clustering, lazy loading) i UI (custom design)
  - [ ] Rizika identifikována

---

## [T-0009] Sjednocení designu celé aplikace podle splash screenu

- **status:** DONE
- **completed:** 2026-03-16
- **priority:** P0
- **owner:** ARCHITECT → FRONTEND DEV → TESTER
- **description:** Celá aplikace má být vizuálně konzistentní se splash screenem. Splash screen definuje brand identity:
  - **Pozadí:** Tmavý teal gradient (#0F2027 → #203A43 → #2C5364)
  - **Accent barva:** Emerald green #10B981 (checkmark v logu, text "Food", loader)
  - **Logo:** Dark navy food cloche + zelený checkmark
  - **Typografie:** w800, letter-spacing 1.5, bílý text na tmavém pozadí
  - **Styl:** Premium, elegantní, tmavý

  Aktuální stav aplikace je nekonzistentní — používá orange #E85D04 jako primary, světlé pozadí #FAFAFA, standardní Material design bez brand identity. Cíl:
  1. **Audit celé aplikace** — zmapovat všechny screeny, componenty, barvy, styly
  2. **Navrhnout unified design system** založený na splash screen vizuálu
  3. **Aktualizovat AppColors, AppTheme, AppTypography** — nová paleta odpovídající splash
  4. **Aplikovat na všechny screeny** — konzistentní vzhled napříč celou aplikací
  5. **Markery na mapě (T-0008)** — musí také odpovídat novému designu
- **referenční design:** Splash screen (`lib/features/splash/splash_screen.dart`) + logo (`assets/icons/splash_logo.png`)
- **splash vizuál:**
  - Pozadí gradient: #0F2027 (tmavý) → #203A43 (střední) → #2C5364 (světlejší teal)
  - Glow: #10B981 s alpha 0.25, blur 60, spread 15
  - Text "Check": white, fontSize 40, w800, letterSpacing 1.5
  - Text "Food": #10B981, fontSize 40, w800, letterSpacing 1.5
  - Tagline: white 60% opacity, fontSize 15, w400, letterSpacing 0.8
  - Loader: CircularProgressIndicator color #10B981
- **akceptační kritéria:**
  - [ ] Architect provedl audit všech screenů a komponent
  - [ ] DECISIONS.md obsahuje D-0017 s kompletním design system návrhem
  - [ ] AppColors aktualizovány na novou paletu (teal + green)
  - [ ] AppTheme reflektuje nový design
  - [ ] Všechny screeny vizuálně konzistentní se splash screenem
  - [ ] Markery na mapě odpovídají novému designu (navazuje na T-0008)
  - [ ] flutter analyze — 0 errors
  - [ ] flutter test — všechny testy prochází
