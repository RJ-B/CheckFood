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
- **implementation plan:** IMPLEMENTATION.md
- **qa report:** QA.md
- **completed:** 2026-03-05
