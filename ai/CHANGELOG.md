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

2026-03-05 DIRECTOR
T-0003 vytvořen: Panorama 360 end-to-end flow (capture → stitch → editor → viewer). Backend + stitcher + frontend capture/editor už existují. Potřeba: tlačítko v My Restaurant, customer 3D viewer, end-to-end propojení.

2026-03-05 DIRECTOR
QA workflow rozšířen: povinné spuštění backendu + frontendu a vizuální ověření na fyzickém telefonu (USB kabel). Aktualizovány WORKFLOW.md a AGENTS.md.

2026-03-05 DIRECTOR
Workflow upřesněn: DEVELOPER commituje pouze lokálně (NEPUSHUJE). Push do main na GitHub provádí QA až po schválení.

2026-03-05 DIRECTOR
Workflow zjednodušen: DEVELOPER necommituje ani nepushuje. Veškerý git (add, commit, push) provádí QA po otestování a schválení.

2026-03-05 DIRECTOR
AGENTS.md kompletně přepsán na detailní manuál. Každá role má: účel, přesný postup, co čte/zapisuje, co nesmí, jak předává práci dalšímu agentovi.

2026-03-05 DIRECTOR
T-0003 přepsán: capture změněn z "8 fotek po 45° s kompasem" na **AR-guided Photo Sphere** (inspirace Teleport 360 Camera). Síť AR teček na sféře, gyroscop/akcelerometr, auto-capture při zarovnání, barevná indikace. PanoramaCaptureScreen nutno přepsat.

2026-03-05 DIRECTOR
T-0003 vrácen ARCHITECTovi. DEVELOPER dokončil D-0010 (PanoramaTab button, editor tables, dead code cleanup) — tyto změny zůstávají. Nový scope: AR Photo Sphere capture vyžaduje přepis PanoramaCaptureScreen. ARCHITECT musí vytvořit D-0011 + nový IMPLEMENTATION.md.

2026-03-05 ARCHITECT
T-0003 D-0011 DONE. AR Photo Sphere: 20-bodový sférický grid (3 prstence), accelerometr+magnetometr tracking, auto-capture se stabilizací, SphereGuidancePainter s 3D→2D projekcí. 10 souborů (4 backend + 6 frontend). Implementation Plan předán.

2026-03-06 DIRECTOR
Restrukturalizace agent systému: 4 samostatné sessions → 1 Director + 4 sub-agenti (Agent tool). Nová složka ai/agents/ s prompt soubory. Separate logy (ai/logs/). Split IMPLEMENTATION na FRONTEND + BACKEND. Smazány AGENTS.md, WORKFLOW.md, NOTES.md.

2026-03-06 ARCHITECT
T-0004 analýza DONE. D-0012: Push notifikace přes rozšíření DeviceEntity (fcmToken + notificationsEnabled). API Contract: PUT + GET /api/user/devices/notifications.

2026-03-06 FRONTEND DEV + BACKEND DEV
T-0004 implementace DONE (paralelně). Frontend: 3 nové + 15 upravených souborů (NotificationService, use cases, UserBloc, ProfileScreen switch, Firebase setup, DI). Backend: 2 nové + 4 upravené soubory (DeviceEntity rozšíření, DTOs, DeviceService, UserController endpointy).

2026-03-06 TESTER
T-0004 QA PASS. Žádné bugy. Backend 77/80 (3 pre-existing), Frontend 27/28 (1 pre-existing), analyze 0 errors. Commit a805358 pushnut.

2026-03-10 FRONTEND DEV + BACKEND DEV
T-0005 implementace DONE (paralelně). Frontend: 9 souborů (image_picker dep, ProfileHeader přepsán s avatar upload, UpdateProfileRequestModel rozšířen, ProfileRemoteDataSource + ProfileRepository + impl rozšířeny, UserEvent + UserBloc rozšířeny, DI aktualizováno). Backend: 11 souborů — 2 nové (SupabaseStorageService, SupabaseStorageConfig) + 9 upravených (LocalFilesystemStorageService profil, PanoramaServiceImpl, StitcherClientImpl, application.properties, application-prod.properties, .env.example, docker-compose.yml, stitcher/main.py, render.yaml).

2026-03-10 TESTER
T-0005 QA PASS. Žádné bugy. Backend compile OK, 77/80 (3 pre-existing), Frontend build_runner OK, analyze 0 errors, testy 27/27 PASS. Supabase Storage migrace kompletní.

2026-03-10 DIRECTOR
T-0005 DONE. Supabase Storage migrace — 28 souborů, 1069 insertions. Commit 4b62142 pushnut na main. Celý flow: Architect (D-0013) → Frontend Dev + Backend Dev (paralelně) → Tester. Zero bugy nalezeny.
