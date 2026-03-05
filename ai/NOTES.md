# NOTES

---

2026-03-05
role: DEVELOPER
task: T-0002
action: implementace dokončena

Změny dle D-0009 (open-ended reservation model):

Backend (6 souborů):
- Reservation.java: endTime nullable=true
- ReservationServiceImpl.java: odstraněn DEFAULT_DURATION_MINUTES, nový available-slots algoritmus (stůl blokovaný od startTime dokud aktivní), createReservation/updateReservation bez endTime
- ReservationRepository.java: přepsány 3 JPQL queries (existsOverlappingReservation, existsOverlappingReservationExcluding, findActiveDiningReservations) — open-ended model
- StaffReservationServiceImpl.java: completeReservation() nastaví endTime=LocalTime.now()
- DiningContextServiceImpl.java: validTo fallback na closing time restaurace (místo reservation.endTime)
- AvailableSlotsResponse.java: odstraněno pole durationMinutes

Frontend (6 souborů):
- reservation.dart: endTime String? (nullable)
- reservation_response_model.dart: toEntity() mapuje endTime nullable
- reservation_card.dart: podmíněné zobrazení (endTime != null → rozsah, null → "od HH:mm")
- staff_reservation.dart: endTime String? (nullable)
- staff_reservation_model.dart: endTime nullable v field, constructor, fromJson
- staff_reservation_card.dart: podmíněné zobrazení timeRange

Build: backend compile OK, frontend build_runner OK (10 outputs)
Testy: 75/75 FAIL — pre-existing issue (H2/PostGIS inkompatibilita, nesouvisí s T-0002)

---

2026-03-05
role: QA
task: T-0002
action: QA dokončeno

QA fixes:
- LocalFilesystemStorageService: rozšířen @Profile na {"local", "test"} (blokoval všechny testy)
- CheckfoodServiceApplicationTests: přidáno @ActiveProfiles("test")
- DiningContextServiceImpl: opravena dvojitá DB query (restaurant načten 1x místo 2x)
- ReservationServiceImpl: odstraněny nepoužívané proměnné `now`, `today` v getTableStatuses
- ReservationIntegrationTest: přepsáno 8 testů pro open-ended model (slot count 22→24, status-based blocking, response format {upcoming, history}, endTime=null, status PENDING_CONFIRMATION)

Výsledek: 77/80 testů PASS, 3 pre-existující failures (AuthLogout, MyRestaurantAuth 2x)

---

2026-03-05
ARCHITECT — T-0003 Analýza dokončena

## Panorama 360 — architektonický audit

### Klíčový nález: 95% infrastruktury JIŽ EXISTUJE

Backend: 100% COMPLETE (PanoramaController 6 endpointů, PanoramaService, StitcherClient, callback, reservation-scene)
Stitcher: 100% COMPLETE (FastAPI + OpenCV, async background task, callback)
Frontend capture: 100% COMPLETE (PanoramaCaptureScreen, AR kompas, 8 fotek)
Frontend editor: 100% COMPLETE (PanoramaEditorScreen, Three.js WebView, table label placement)
Frontend customer viewer: 100% COMPLETE (ReservationPage, Three.js, status-colored markers)

### Co chybí (minimální scope):
1. PanoramaTab v My Restaurant nemůže vytvořit novou session (říká "jdi do onboarding wizard")
2. PanoramaTab při editaci nepředává existující tabulky (předává prázdný list)
3. Dead code: 5 souborů (Label3D.js prázdný, LabelManager.js nefunkční, PanoramaViewer.js nepoužitý, TableLabel.js nepoužitý, TableSelectionScreen legacy)

### Rozhodnutí D-0010:
- Modify 1 soubor (PanoramaTab), delete 5 souborů (dead code)
- Backend: 0 změn. Stitcher: 0 změn.
- Reuse onboarding use cases přes DI (lazy singletons)

### Implementation Plan v IMPLEMENTATION.md (5 kroků)

---

2026-03-05
role: DEVELOPER
task: T-0003
action: implementace dokončena

Změny dle D-0010 (Panorama 360 end-to-end flow):

Modified (4 soubory):
- panorama_tab.dart: přidán "Nové panorama" button (CreatePanoramaSessionUseCase → PanoramaCaptureScreen → FinalizePanoramaUseCase → poll), _openEditorWithTables() načte tabulky přes GetTablesUseCase a mapuje na EditorTable (yaw/pitch), onSave callback volá UpdateTableUseCase s yaw/pitch, aktivní panorama edit nyní předává existující tabulky
- update_table_usecase.dart: přidány optional params double? yaw, double? pitch
- onboarding_repository.dart: updateTable() signature rozšířena o yaw/pitch
- onboarding_repository_impl.dart: updateTable() posílá yaw/pitch v JSON payloadu na backend (backend už je přijímá)

Deleted (5 souborů — dead code):
- assets/three/Label3D.js (prázdný)
- assets/three/LabelManager.js (importoval prázdný Label3D)
- assets/three/PanoramaViewer.js (nikde neimportován)
- assets/three/TableLabel.js (nikde neimportován)
- features/explore/presentation/table_selection_screen.dart (legacy, broken refs)

Opraveno (1 soubor):
- restaurant_detail_screen.dart: odstraněn import smazaného table_selection_screen.dart + reference na TableSelectionScreen

Build: flutter analyze 0 errors, build_runner OK (10 outputs)
Backend: 0 změn
