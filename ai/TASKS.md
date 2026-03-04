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

- **status:** IN_QA
- **priority:** P0
- **owner:** DEVELOPER
- **description:** Změnit logiku rezervací tak, že:
  - Rezervace má pouze počáteční čas (`startTime`), NE ukončovací (`endTime`)
  - Zákazník si nevolí délku pobytu — může v restauraci zůstat jak dlouho chce
  - Rezervace se ukončuje manuálně staffem přes endpoint `/complete`
  - V budoucnu automatické ukončení při zaplacení přes pokladní systém — nyní pouze manuální
  - Po ukončení se rezervace zobrazí v historii se statusem COMPLETED
- **akceptační kritéria:**
  - [ ] `Reservation.endTime` není povinné pole (nullable)
  - [ ] Vytvoření rezervace nevyžaduje endTime (backend ani frontend)
  - [ ] Staff může ukončit rezervaci přes `/complete` → status COMPLETED + endTime=now()
  - [ ] Ukončená rezervace se zobrazí v historii zákazníka
  - [ ] Available-slots logika funguje bez endTime
  - [ ] Stávající testy projdou (nebo jsou upraveny)
- **architect decision:** D-0009
- **implementation plan:** IMPLEMENTATION.md
