# TASKS

---

## [T-0014] Migrace Render → Google Cloud Platform (Cloud Run + Cloud SQL + GCS)

- **status:** DONE
- **priority:** P0
- **owner:** ARCHITECT → BACKEND DEV + DEVSECOPS → TESTER
- **description:** Kompletní migrace produkčního prostředí z Render.com na Google Cloud Platform:
  1. **Cloud Run** — backend API jako serverless container
  2. **Cloud SQL** — PostgreSQL 15 + PostGIS 3.4
  3. **Google Cloud Storage** — nahradit Supabase Storage
  4. **Artifact Registry** — Docker image repository
  5. **GitHub Actions** — CI/CD pipeline: build → push to AR → deploy Cloud Run
  6. **Odstranit stitcher** — Python microservice, veškeré reference z kódu
  7. **Odstranit Render** — render.yaml, render-related konfigurace
  8. **Odstranit Supabase Storage** — nahrazeno GCS
  9. **Doména** — připravit Cloud Run domain mapping (vlastní doména později)
- **GCP:**
  - Project ID: `checkfood-system-478116`
  - Region: `europe-central2` (Varšava, nejblíž ČR)
- **akceptační kritéria:**
  - [ ] Dockerfile optimalizovaný pro Cloud Run (single backend, bez stitcher)
  - [ ] GcsStorageService nahrazuje SupabaseStorageService (profil prod)
  - [ ] application-prod.properties aktualizovány pro Cloud SQL + GCS
  - [ ] GitHub Actions workflow: build → push Artifact Registry → deploy Cloud Run
  - [ ] render.yaml smazán
  - [ ] Stitcher reference odstraněny (docker-compose, PanoramaController, config)
  - [ ] Supabase Storage reference odstraněny (SupabaseStorageService, SupabaseStorageConfig)
  - [ ] .env.example aktualizován s GCP proměnnými
  - [ ] Kompilace OK, testy prochází

---

## [T-0010] Zapomenuté heslo — forgot password flow (request → email → reset)

- **status:** DONE
- **priority:** P1
- **owner:** ARCHITECT → FRONTEND DEV + BACKEND DEV → TESTER
- **description:** Implementovat kompletní "Zapomenuté heslo" flow:
  1. Na login stránce existuje tlačítko "Zapomenuté heslo" (UI už existuje)
  2. Klik → obrazovka pro zadání emailu → backend ověří existenci emailu
  3. Backend pošle email s odkazem/tlačítkem na reset hesla
  4. Klik na odkaz v emailu → deep link redirect do aplikace
  5. V aplikaci obrazovka pro zadání nového hesla + potvrzení hesla
  6. Backend přepíše staré heslo za nové (validace dle PasswordPolicy)
  7. Existující tokeny (access/refresh) zůstávají platné — reset hesla je nezávislý
- **akceptační kritéria:**
  - [ ] Tlačítko na login stránce otevře "zadej email" obrazovku
  - [ ] Backend endpoint pro request password reset (ověří existenci emailu, pošle email)
  - [ ] Email obsahuje odkaz/tlačítko s reset tokenem
  - [ ] Klik na odkaz otevře aplikaci (deep link) s reset tokenem
  - [ ] V aplikaci obrazovka pro nové heslo + potvrzení
  - [ ] Backend endpoint pro reset hesla (validace tokenu + nové heslo)
  - [ ] Staré heslo je přepsáno, existující sessions zůstávají
  - [ ] Chybové stavy: neexistující email, expirovaný token, slabé heslo

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
- **existující kód:**
  - Backend: `PanoramaController` (6 endpointů), `PanoramaService`, `PanoramaSession`/`PanoramaPhoto` entity — COMPLETE
  - Backend: `RestaurantTable` má `yaw`, `pitch` (Double) pro pozici v panoramatu
  - Backend: `/reservation-scene` endpoint vrací panoramaUrl + tables s yaw/pitch/capacity
  - Stitcher: Python/FastAPI/OpenCV — COMPLETE
  - Frontend: `PanoramaCaptureScreen` (kamera + kompas, 8 úhlů) — existuje ale **NUTNO PŘEPSAT na AR Photo Sphere**
  - Frontend: `PanoramaEditorScreen` (WebView + markers) — existuje v onboarding
  - Frontend: `StepPanorama` widget — existuje v onboarding wizardu
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

---

## [T-0005] Supabase Storage — migrace fotek z lokálního disku do cloudu

- **status:** TODO (zbývá vytvořit bucket v Supabase Dashboard)
- **priority:** P0
- **description:** Kód je implementován (SupabaseStorageService, stitcher dual mode). Zbývá manuální krok: vytvořit bucket v Supabase Dashboard.

---
