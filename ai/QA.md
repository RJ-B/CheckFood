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
