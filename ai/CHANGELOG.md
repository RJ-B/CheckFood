# CHANGELOG

---

2026-03-04 DIRECTOR
Vytvořena složka ai/ s workflow soubory. T-0001 vytvořen.

2026-03-04 DIRECTOR
Konsolidace — smazány zastaralé root workflow soubory. Jediný zdroj pravdy: ai/.

2026-03-04 ARCHITECT
T-0001 DONE. Audit architektury: 19 controllerů, ~90 endpointů, 21 entit, 12 rizik. 8 rozhodnutí (D-0001–D-0008).

2026-03-04 DIRECTOR
T-0002 vytvořen: Refaktor rezervací — odstranění endTime, ukončení staffem.

2026-03-05 ARCHITECT
T-0002 analýza dokončena. D-0009: endTime nullable, nové rezervace endTime=null, staff /complete nastaví endTime=now(). Implementation Plan předán.

2026-03-05 DIRECTOR
Konsolidace ai/ souborů na finální strukturu: CLAUDE.md, STATUS.md, TASKS.md, SPRINT.md, DECISIONS.md, IMPLEMENTATION.md, QA.md, CHANGELOG.md.

2026-03-05 DIRECTOR
Oprava struktury ai/ dle definitivního workflow: doplněny PROJECT_CONTEXT.md, WORKFLOW.md, NOTES.md. STATUS.md rozšířen o CURRENT_TASK. Kompletní sada: 11 souborů.

2026-03-05 QA
T-0002 QA DONE. 6 bugfixů (StorageService profil, test profily, double DB query, dead code, 8 testů přepsáno pro open-ended model). 77/80 testů PASS.
