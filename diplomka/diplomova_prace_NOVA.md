Univerzita Hradec Králové
Fakulta informatiky a managementu
Katedra informatiky a kvantitativních metod

# Vývoj aplikace pro správu rezervací a objednávek v gastronomii

**Diplomová práce**

Autor: Bc. Rostislav Jirák
Studijní obor: Aplikovaná informatika

Vedoucí práce: doc. Mgr. Tomáš Kozel, Ph.D.
Katedra informatiky a kvantitativních metod

Hradec Králové, srpen 2026

---

## Úvod

Digitalizace gastronomického odvětví představuje jeden z nejvýraznějších trendů posledního desetiletí v oblasti služeb. Zákazníci stále častěji očekávají možnost provádět rezervace, prohlížet nabídku a realizovat platby prostřednictvím mobilních aplikací [1]. Tento posun byl zásadně umocněn pandemií COVID-19, která v letech 2020–2021 přinutila restaurační podniky k rychlé adaptaci na bezkontaktní způsoby obsluhy. Studie společnosti Deloitte z roku 2021 uvádí, že 57 % zákazníků preferuje digitální aplikace pro objednávání jídla a 64 % upřednostňuje digitální objednávání přímo v provozovně [2]. I po odeznění pandemických omezení zůstala zákaznická očekávání trvale na vyšší úrovni.

Na globálním trhu existuje řada platforem, jako jsou OpenTable nebo TheFork, které rezervační funkce částečně pokrývají. Na českém trhu je však situace odlišná. Po ukončení služby Restu.cz ke konci roku 2021 [4] zde chybí komplexní řešení, které by zákazníkům umožňovalo nejen provést rezervaci, ale také interaktivně si zvolit konkrétní stůl, prohlédnout si interiér podniku prostřednictvím panoramatického zobrazení a spravovat objednávky přímo z mobilního zařízení.

Hlavním cílem této diplomové práce je navrhnout, implementovat a otestovat systém pro správu rezervací a objednávek v gastronomii s pracovním názvem CheckFood. K dosažení hlavního cíle je stanoveno pět dílčích cílů: analýza existujících řešení a specifikace požadavků na systém, návrh architektury včetně komunikace mezi vrstvami, návrh databázového modelu s podporou geoprostorových dat, implementace backendové aplikace, mobilního klienta a podpůrné mikroslužby a ověření funkčnosti prostřednictvím automatizovaných testů.

Systém je postaven na frameworku Flutter pro mobilní aplikaci, Spring Boot pro backend a databázi PostgreSQL s rozšířením PostGIS. Infrastruktura využívá služby platformy Google Cloud. Volba technologií vychází z analýzy a srovnání popsaných v kapitolách 2 a 3. Metodika práce vychází ze studia odborné literatury a analýzy požadavků. Při návrhu je uplatněn princip oddělení odpovědností prostřednictvím vrstvené architektury. Funkčnost systému je ověřena prostřednictvím integračních testů backendového API a jednotkových testů stavové logiky mobilní aplikace.

Teoretická část zahrnuje tři kapitoly: analýzu problému se specifikací požadavků (kapitola 1), návrh architektury systému včetně volby technologií (kapitola 2) a návrh databázového modelu (kapitola 3). Praktická část zahrnuje implementaci systému (kapitola 4), testování (kapitola 5) a nasazení do produkčního prostředí (kapitola 6).

---

# Teoretická část

Teoretická část práce se zaměřuje na analýzu problémové domény, specifikaci požadavků na systém, výběr vhodných technologií, návrh celkové architektury a návrh databázového modelu. Poznatky získané v této části tvoří základ pro praktickou realizaci systému popsanou v dalších kapitolách.

---

## 1 Analýza problému

První kapitola se zabývá analýzou současného stavu v oblasti digitálních rezervačních a objednávkových systémů v gastronomii. Na základě přehledu existujících řešení na globálním i českém trhu je identifikována mezera, kterou navrhovaný systém CheckFood hodlá zaplnit. Následně jsou specifikovány funkční a nefunkční požadavky na systém a provedeno srovnání dostupných technologií s odůvodněním jejich výběru.

### 1.1 Současné přístupy a existující řešení

Nejvýznamnější globální platformou v oblasti online rezervací je OpenTable, která obsluhuje více než 55 000 restaurací ve více než 80 zemích a ročně zprostředkuje rezervace pro více než jednu miliardu strávníků [7]. Platforma účtuje restauracím měsíční poplatek a poplatek za každou rezervaci [7]. Druhou významnou platformou je TheFork, působící zejména na evropských trzích ve Francii, Španělsku, Itálii a dalších zemích [8]. Obě platformy fungují primárně jako zprostředkovatelé časových slotů, kde zákazník zvolí datum, čas a počet osob, avšak nemá možnost vizuálně si prohlédnout interiér restaurace nebo si interaktivně vybrat konkrétní stůl. Ani jedna z nich aktivně nepůsobí na českém trhu.

Na českém trhu byla nejvýznamnější službou Restu.cz, která disponovala katalogem více než 25 000 restaurací a měsíčně ji využívalo přes 60 000 uživatelů [4]. Služba byla ukončena ke dni 31. prosince 2021 v důsledku dopadů pandemie COVID-19 [4]. Po jejím ukončení zůstalo aktivní řešení Qerko, specializující se na digitální objednávání a platby prostřednictvím QR kódů, avšak neřešící problematiku online rezervací stolů ani vizualizace interiéru [9]. Pokladní systémy jako Dotykačka a Storyous zajišťují evidenci objednávek a propojení s kuchyní, avšak nezahrnují zákaznicky orientované funkce [10].

Z přehledu vyplývá, že na českém trhu neexistuje řešení kombinující vyhledávání restaurací na mapě, interaktivní výběr stolu s 360° panoramatem interiéru, správu rezervací a objednávek a administrační nástroje pro personál. Tato mezera je primárním motivem pro vznik systému CheckFood.

### 1.2 Funkční požadavky na systém

Funkční požadavky specifikují, co má systém poskytovat uživatelům z pohledu jeho funkcionality, a tvoří základní rámec pro návrh architektury, databázového modelu i uživatelského rozhraní [3]. Systém rozlišuje čtyři základní role uživatelů: zákazník, zaměstnanec, manažer a vlastník restaurace. Toto rozdělení vychází z principu minimálního oprávnění [15].

Systém musí podporovat registraci prostřednictvím e-mailové adresy s verifikací a přihlášení prostřednictvím služeb Google Sign-In a Apple Sign-In [11]. Pro zvýšení bezpečnosti musí být k dispozici dvoufaktorová autentizace prostřednictvím jednorázových časových kódů. Uživatel musí mít možnost spravovat svůj profil, změnit heslo a spravovat přihlášená zařízení včetně možnosti vzdáleného odhlášení.

Zákazník musí mít k dispozici interaktivní mapové zobrazení restaurací v okolí s adaptivním shlukováním značek [13], textové vyhledávání a filtrování podle typu kuchyně, hodnocení a otevírací doby. Detail restaurace zahrnuje profil podniku, otevírací dobu včetně speciálních dnů a svátků, digitální menu a možnost přidání mezi oblíbené.

Klíčovou diferenciační funkcí je rezervace stolu prostřednictvím interaktivního 360° panoramatického zobrazení interiéru, ve kterém jsou stoly barevně odlišeny podle dostupnosti. Zákazník si zvolí stůl, datum, čas a počet osob. Systém musí podporovat úpravu a rušení rezervací, opakující se týdenní rezervace a mechanismus návrhů změn ze strany personálu [3].

Objednávkový modul umožňuje zákazníkovi prohlížet digitální menu, přidávat položky do košíku a odeslat objednávku přiřazenou k aktivní rezervaci [2]. Systém musí podporovat push notifikace pro klíčové události životního cyklu rezervace a objednávky [14].

Personál restaurace přistupuje k přehledu rezervací na zvolené datum s možností potvrzení, odmítnutí, zaznamenání příchodu hosta, dokončení návštěvy, návrhu změny a prodloužení rezervace. Přehled musí být aktualizován v pravidelných intervalech. Vlastník restaurace spravuje informace o podniku, otevírací dobu, speciální dny, rozmístění stolů včetně skupin stolů, digitální menu a panoramatické zobrazení interiéru. Klíčovou funkcí je správa zaměstnanců s konfigurovatelnými oprávněními z předdefinované sady jedenácti typů. Systém musí podporovat správu více restaurací jedním vlastníkem.

Registrace vlastníka restaurace je realizována prostřednictvím registračního formuláře s volbou role vlastníka. Po registraci je automaticky vytvořena testovací restaurace viditelná pouze danému vlastníkovi, který může prostřednictvím šestikrokového průvodce konfigurovat informace o podniku, otevírací dobu, stoly, digitální menu, panoramatický snímek a publikovat restauraci. V produkčním prostředí je publikace restaurace podmíněna manuálním schválením administrátorem systému. Automatizované ověření vlastnictví prostřednictvím registru ARES, služby BankID nebo e-mailové verifikace je identifikováno jako plánované rozšíření.

Klíčové funkční požadavky jsou shrnuty v tabulce 1.

**Tabulka 1: Přehled funkčních požadavků systému CheckFood**

| Funkční oblast | Požadavek | Role |
|----------------|-----------|------|
| Registrace a autentizace | Registrace e-mailem, Google/Apple přihlášení, dvoufaktorová autentizace | Zákazník, Vlastník |
| Správa profilu | Editace osobních údajů, změna hesla, správa zařízení, vzdálené odhlášení | Zákazník |
| Vyhledávání restaurací | Mapové zobrazení se shlukováním, textové vyhledávání, filtrování, oblíbené | Zákazník |
| Detail restaurace | Profil podniku, otevírací doba, speciální dny, digitální menu | Zákazník |
| Rezervace stolů | 360° panorama, interaktivní výběr stolu, opakující se rezervace, návrhy změn | Zákazník |
| Objednávky | Digitální menu, košík, odeslání objednávky k aktivní rezervaci | Zákazník |
| Správa provozu | Přehled rezervací, stavové přechody, návrhy změn, prodloužení rezervace | Zaměstnanec, Manažer |
| Správa restaurace | Informace o podniku, stoly, skupiny stolů, menu, panorama, speciální dny | Vlastník |
| Správa zaměstnanců | Přidání/odebrání zaměstnanců, konfigurovatelná oprávnění (11 typů) | Vlastník |
| Registrace vlastníka | Registrace s rolí vlastníka, testovací restaurace, schválení administrátorem | Vlastník, Admin |
| Onboarding vlastníka | Šestikrokový průvodce konfigurací restaurace | Vlastník |
| Notifikace | Push notifikace pro rezervace a objednávky | Všechny role |
| Lokalizace | Podpora češtiny a angličtiny s možností přepínání | Všechny role |

### 1.3 Nefunkční požadavky na systém

Nefunkční požadavky určují, jakým způsobem má systém fungovat a jaké kvalitativní vlastnosti musí splňovat. Sommerville uvádí, že tyto požadavky často rozhodují o tom, zda bude systém v reálném prostředí použitelný [3].

**Škálovatelnost.** Systém musí podporovat horizontální škálování prostřednictvím bezstavového návrhu backendu, kde veškerý stav je persistován v databázi nebo předáván prostřednictvím autentizačního tokenu [5]. Databázová vrstva musí být optimalizována prostřednictvím indexů na často dotazované sloupce a prostorových indexů pro geolokační dotazy.

**Zabezpečení.** Autentizace musí být řešena prostřednictvím bezstavového tokenového mechanismu s omezenou platností a možností obnovy. Autorizace musí být řízena na základě rolí [15]. Veškerý přenos dat musí probíhat šifrovaně prostřednictvím HTTPS/TLS, hesla musejí být ukládána výhradně jako kryptografický hash a citlivé údaje na klientském zařízení v zabezpečeném úložišti operačního systému. Systém musí být chráněn proti hrozbám popsaným v dokumentu OWASP Top 10 [16] a musí být v souladu s nařízením GDPR [17].

**Výkon a odezva.** Podle heuristik Nielsena uživatelé vnímají odezvu do jedné sekundy jako okamžitou [18]. Běžné operace musejí být zpracovány do jedné sekundy, složitější operace do tří sekund. Operace nevyžadující okamžité potvrzení, jako je zpracování panoramatických snímků, musejí probíhat asynchronně na pozadí.

**Spolehlivost a dostupnost.** Cílem je dostupnost alespoň 99,9 % [19]. Databáze musí být automaticky zálohována s možností obnovy dat k libovolnému bodu v čase [20]. Aplikace musí signalizovat svůj stav prostřednictvím zdravotních kontrol a infrastruktura musí automaticky nahrazovat nefunkční instance [5].

**Použitelnost a přístupnost.** Mobilní aplikace musí respektovat konvence operačních systémů Android a iOS a být navržena v souladu s heuristikami použitelnosti [18]. Navigace musí využívat standardní vzory, kritické akce musejí vyžadovat explicitní potvrzení a aplikace musí podporovat lokalizaci do češtiny a angličtiny.

**Udržovatelnost a rozšiřitelnost.** Systém musí důsledně oddělovat prezentační, doménovou a perzistentní vrstvu [5]. Evoluce databázového schématu musí být řízena verzovanými migracemi. Automatizované testování a průběžná integrace musejí zajistit detekci regresí při každé změně kódu [3].

**Přehled nefunkčních požadavků.** Klíčové nefunkční požadavky jsou shrnuty v tabulce 2.

**Tabulka 2: Přehled nefunkčních požadavků systému CheckFood**

| Oblast | Požadavek | Cílová hodnota |
|--------|-----------|----------------|
| Škálovatelnost | Bezstavový backend, horizontální škálování | Zvládnutí provozní špičky bez degradace |
| Zabezpečení | Tokenová autentizace, RBAC, HTTPS/TLS, GDPR | Soulad s GDPR, ochrana proti OWASP Top 10 |
| Výkon | Odezva běžných operací, asynchronní zpracování | ≤ 1 s běžné, ≤ 3 s složité operace |
| Spolehlivost | Automatické zálohy, zdravotní kontroly | Dostupnost ≥ 99,9 % |
| Použitelnost | Standardní navigační vzory, lokalizace cs/en | Intuitivní ovládání bez návodu |
| Udržovatelnost | Vrstvená architektura, verzované migrace, CI/CD | Automatizované testy a nasazení |

---

## 2 Návrh architektury systému

Funkční a nefunkční požadavky specifikované v kapitole 1 definují, co musí systém poskytovat a jakých kvalitativních vlastností musí dosáhnout. Tato kapitola popisuje architektonické vzory, návrhové principy a technologie, které umožňují tyto požadavky splnit. Výklad postupuje od celkového architektonického stylu systému přes architekturu klientské a serverové části až po mechanismy jejich vzájemné komunikace a zabezpečení. Poznatky uvedené v této kapitole tvoří teoretický základ pro praktickou realizaci popsanou v kapitole 4.

### 2.1 Architektonické styly

Prvním rozhodnutím při návrhu systému je volba architektonického stylu, který určuje celkovou strukturu a způsob komunikace mezi komponentami. Při návrhu webových a mobilních systémů se rozlišují dva základní přístupy, a to monolitická architektura a architektura mikroslužeb.

Monolitická architektura představuje přístup, při kterém je veškerá aplikační logika součástí jediného nasaditelného artefaktu. Výhodou je jednoduchost nasazení, jednotné řízení transakcí a nižší provozní složitost, protože není nutné řešit mezislužební komunikaci, distribuovanou konzistenci dat ani orchestraci více procesů. Nevýhodou je těsnější provázanost komponent, která může komplikovat nezávislý vývoj a škálování jednotlivých částí systému při rostoucím rozsahu projektu [5].

Architektura mikroslužeb dekomponuje systém do samostatně nasaditelných služeb, z nichž každá pokrývá jednu ohraničenou doménu. Newman uvádí, že hlavními přínosy jsou nezávislé nasazení, technologická heterogenita a cílené škálování zatížených služeb [5]. Nevýhodou je vyšší provozní složitost zahrnující mezislužební komunikaci, distribuované transakce a potřebu orchestrace, která se u menších projektů nemusí vyplatit.

Hybridní přístup kombinuje oba styly tak, že jádro systému je realizováno jako monolit a výpočetně náročné nebo specializované funkce jsou vyčleněny do samostatných služeb. Tento přístup přináší jednoduchost monolitu pro většinu obchodní logiky a současně umožňuje asynchronní zpracování úloh, jejichž doba trvání překračuje přijatelnou dobu odezvy HTTP požadavku [5].

### 2.2 Klientská aplikace

Klientská aplikace zajišťuje veškerou interakci s uživatelem a komunikuje se serverovou částí prostřednictvím síťového rozhraní. Následující sekce popisují přístupy k multiplatformnímu vývoji, framework Flutter, principy vnitřní organizace kódu a mechanismy správy stavu.

#### 2.2.1 Multiplatformní mobilní vývoj

Požadavek na podporu platforem Android a iOS definovaný v kapitole 1.2 vyžaduje rozhodnutí o přístupu k mobilnímu vývoji. Vývoj mobilních aplikací pro obě platformy lze realizovat třemi přístupy, a to nativním, hybridním a multiplatformním.

Nativní vývoj využívá pro každou platformu její specifický jazyk a vývojové prostředí, konkrétně Kotlin nebo Java pro Android a Swift nebo Objective-C pro iOS [37]. Výhodou je plný přístup k funkcím platformy a optimální výkon, nevýhodou nutnost udržovat dvě oddělené kódové základny, což zvyšuje náklady na vývoj a údržbu [23].

Hybridní přístup zabaluje webovou aplikaci do nativního kontejneru prostřednictvím komponent WebView. Aplikace je vyvinuta jednou v jazycích HTML, CSS a JavaScript a zobrazena v nativní obálce. Výhodou je sdílení kódové základny, nevýhodou nižší výkon a omezený přístup k nativním funkcím zařízení [22].

Multiplatformní frameworky umožňují vývoj z jediné kódové základny s výkonem blízkým nativním aplikacím. Podle průzkumu Stack Overflow Developer Survey z roku 2024 je nejpoužívanějším multiplatformním frameworkem Flutter s podílem 46 % vývojářů, následovaný frameworkem React Native s 35 % [21]. React Native využívá JavaScript a mapuje deklarativní komponenty na nativní prvky platformy prostřednictvím bridge, což může omezovat výkon při graficky náročných operacích [22]. Framework Xamarin v jazyce C# čelí nejistotě v důsledku přechodu na nástupnickou technologii .NET MAUI [21]. Srovnání multiplatformních frameworků je uvedeno v tabulce 3.

**Tabulka 3: Srovnání multiplatformních mobilních frameworků**

| Kritérium | Flutter | React Native | Xamarin |
|-----------|---------|-------------|---------|
| Jazyk | Dart | JavaScript | C# |
| Vykreslování | Vlastní engine | Nativní přes bridge | Nativní |
| Výkon grafiky | Vysoký | Střední | Střední |
| Podíl vývojářů (2024) | 46 % | 35 % | ~15 % |
| Správce | Google | Meta | Microsoft (ukončováno) |

#### 2.2.2 Framework Flutter a jazyk Dart

Flutter je multiplatformní framework vyvíjený společností Google, který umožňuje vytvářet nativně kompilované aplikace pro platformy Android, iOS, web a desktop z jediné kódové základny v jazyce Dart [23].

Dart je objektově orientovaný jazyk s volitelným statickým typováním, jehož syntaxe vychází z rodiny jazyků C. Klíčovou vlastností je podpora dvou režimů kompilace. JIT (Just-In-Time) kompilace umožňuje rychlý vývojový cyklus s okamžitým promítnutím změn prostřednictvím mechanismu Hot Reload, zatímco AOT (Ahead-Of-Time) kompilace generuje optimalizovaný nativní strojový kód pro produkční nasazení [23].

Flutter vykresluje uživatelské rozhraní vlastním grafickým enginem bez závislosti na nativních komponentách platformy, čímž dosahuje konzistentního vzhledu na všech platformách [36]. Základním stavebním prvkem je widget, tedy neměnný objekt popisující část uživatelského rozhraní. Widgety jsou skládány do hierarchického stromu, přičemž se rozlišují stateless widgety, jejichž zobrazení závisí výhradně na vstupních parametrech, a stateful widgety, které uchovávají vnitřní proměnný stav a při jeho změně se překreslují [23]. Zammetti uvádí, že deklarativní paradigma frameworku Flutter znamená, že vývojář popisuje požadovaný stav uživatelského rozhraní a framework zajistí efektivní aktualizaci pouze těch částí stromu widgetů, které se skutečně změnily [36].

#### 2.2.3 Architektura mobilní aplikace

Volba frameworku řeší technologii vývoje, avšak neřeší vnitřní organizaci kódu. Pro strukturování aplikace do vrstev s jasně oddělenými odpovědnostmi slouží princip čisté architektury formulovaný Martinem [29]. Čistá architektura definuje pravidlo závislostí, podle kterého závislosti mezi vrstvami uvnitř aplikace směřují vždy od vnějších vrstev k vnitřním, přičemž vrstva uživatelského rozhraní závisí na doménové vrstvě, doménová vrstva nezávisí na žádné další. Tímto uspořádáním je doménová logika nezávislá na konkrétním frameworku, databázi nebo síťovém rozhraní, což usnadňuje testování a budoucí změny technologií [29].

V kontextu mobilního vývoje je čistá architektura typicky realizována rozdělením každého funkčního modulu do tří vrstev. Datová vrstva obsahuje vzdálené datové zdroje zajišťující komunikaci se serverem, datové modely pro serializaci a deserializaci a implementace repozitářů. Doménová vrstva obsahuje entity reprezentující doménové koncepty, abstraktní rozhraní repozitářů a use cases zapouzdřující jednotlivé operace obchodní logiky. Vrstva uživatelského rozhraní obsahuje widgety a komponenty pro správu stavu [23]. Klíčovými návrhovými vzory v rámci čisté architektury jsou Repository pattern a Use Case pattern. Vzor repozitáře definuje abstraktní rozhraní v doménové vrstvě, jehož implementace v datové vrstvě zapouzdřuje přístup k datovým zdrojům, ať již síťovým, lokálním nebo kombinovaným. Doménová vrstva tak není závislá na konkrétním zdroji dat a implementace může být nahrazena bez dopadu na obchodní logiku [29]. Vzor případu užití zapouzdřuje jednu operaci obchodní logiky do samostatné třídy, čímž je zajištěn princip jediné odpovědnosti a snadná testovatelnost.

Dependency Injection (DI) je návrhový vzor úzce spjatý s čistou architekturou, jehož účelem je odstranit pevné vazby mezi třídami tím, že závislosti jsou poskytovány zvenčí namísto vytváření uvnitř třídy [29]. V prostředí frameworku Flutter je rozšířeným přístupem Service Locator, který udržuje centrální registr instancí a na vyžádání vrací příslušnou implementaci. Registrace rozlišuje dvě strategie životního cyklu. Strategie singleton udržuje jedinou sdílenou instanci po celou dobu běhu aplikace, zatímco strategie factory vytváří novou instanci při každém vyžádání [23].

#### 2.2.4 Správa stavu a reaktivní programování

Čistá architektura definuje rozdělení do vrstev, avšak nespecifikuje, jakým způsobem vrstva uživatelského rozhraní reaguje na změny dat. Správa stavu představuje jeden z klíčových architektonických problémů při vývoji mobilních aplikací, protože stav zahrnuje data zobrazená uživateli, průběh probíhajících operací, autentizační informace a lokální preference. Při každé změně stavu musí být uživatelské rozhraní synchronizováno s aktuálními daty [30].

Ve frameworku Flutter existuje několik přístupů ke správě stavu. Vzor BLoC (Business Logic Component) odděluje obchodní logiku od uživatelského rozhraní prostřednictvím jednosměrného toku dat. Uživatelské rozhraní odesílá události do komponenty BLoC, která provede příslušnou operaci a emituje nový neměnný stav, na jehož základě se widget překreslí. Jednosměrnost toku dat zajišťuje předvídatelnost a usnadňuje ladění [30]. Knihovna Provider představuje jednodušší přístup založený na mechanismu InheritedWidget, avšak nevynucuje oddělení obchodní logiky od uživatelského rozhraní [23]. Knihovna Riverpod přináší typovou bezpečnost v době kompilace a nezávislost na stromu widgetů za cenu vyšší vstupní složitosti [23]. Knihovna GetX kombinuje správu stavu, navigaci a závislosti v jednom balíku s důrazem na minimální kód, avšak s nižší strukturovaností [23]. Srovnání je uvedeno v tabulce 7.

**Tabulka 7: Srovnání přístupů ke správě stavu ve frameworku Flutter**

| Kritérium | BLoC | Provider | Riverpod | GetX |
|-----------|------|----------|----------|------|
| Tok dat | Jednosměrný | Volný | Deklarativní | Reaktivní |
| Oddělení logiky od UI | Vynucené | Doporučené | Doporučené | Volné |
| Testovatelnost | Vysoká | Střední | Vysoká | Nižší |
| Strukturovanost | Vysoká | Nízká | Střední | Nízká |
| Vstupní složitost | Vyšší | Nízká | Střední | Nízká |

Tok dat vzoru BLoC je znázorněn na obrázku 1. Uživatelská akce vyvolá událost, která prostřednictvím případu užití a repozitáře odešle požadavek na server, a odpověď se transformovaná na doménovou entitu vrací zpět do komponenty BLoC, která emituje nový stav a widget se překreslí.

*Obrázek 1: Sekvenční diagram toku dat v klientské aplikaci (vlastní zpracování)*

S problematikou správy stavu úzce souvisí generování kódu prostřednictvím knihoven Freezed a json_serializable. Knihovna Freezed generuje neměnné datové třídy s podporou porovnávání hodnot, kopírování s modifikací a zpracování vzorů, čímž zajišťuje, že stavy emitované komponentou BLoC jsou neměnné a jejich změny jsou spolehlivě detekovány frameworkem [23]. Knihovna json_serializable generuje serializační a deserializační kód pro převod mezi objekty a formátem JSON, čímž eliminuje manuální a chybové parsování síťových odpovědí.

### 2.3 Serverová aplikace

Serverová aplikace zajišťuje obchodní logiku, přístup k datům a zabezpečení systému. Následující sekce popisují volbu backendového frameworku, principy vnitřní organizace kódu a mechanismus přístupu k relační databázi.

#### 2.3.1 Backendové frameworky

Při výběru frameworku pro serverovou část byly zvažovány tři přístupy odpovídající odlišným programovacím jazykům a architektonickým modelům.

Node.js je běhové prostředí jazyka JavaScript postavené na engine V8. Framework Express poskytuje minimalistickou vrstvu pro definici koncových bodů a middleware. Klíčovou vlastností Node.js je asynchronní architektura založená na event loop, při které jediné vlákno zpracovává požadavky neblokujícím způsobem a vstupně-výstupní operace jsou delegovány na systémové prostředky [39]. Tento model je efektivní pro aplikace s velkým počtem souběžných připojení s nízkými nároky na výpočetní výkon. Nevýhodou je dynamické typování jazyka JavaScript, které komplikuje údržbu rozsáhlejších projektů, protože chyby typů jsou odhaleny až za běhu, nikoli při kompilaci. Bezpečnostní moduly pro autentizaci a autorizaci jsou závislé na knihovnách třetích stran, což vyžaduje pečlivý výběr a údržbu závislostí [39].

Django je framework jazyka Python, který poskytuje robustní výchozí funkcionalitu zahrnující ORM, administrační rozhraní, autentizační modul a systém šablon. Přístup frameworku „batteries included" umožňuje rychlý start projektu bez nutnosti výběru a konfigurace externích knihoven [3]. Rozšíření GeoDjango přidává podporu pro geoprostorové datové typy a dotazy. Nevýhodou je synchronní architektura, která při zpracování každého požadavku blokuje vlákno po dobu trvání vstupně-výstupních operací, což může omezovat propustnost při velkém počtu souběžných požadavků. Asynchronní podpora byla přidána ve verzi 3.1, avšak ekosystém knihoven ji dosud plně nepřijal [3].

Spring Boot je framework jazyka Java postavený na platformě Spring, který zjednodušuje konfiguraci a nasazení aplikací prostřednictvím principu konvence nad konfigurací [34]. Reddy uvádí, že Spring Boot automaticky konfiguruje komponenty na základě závislostí přítomných v projektu, čímž eliminuje manuální konfiguraci typickou pro starší verze platformy Spring [34]. Framework poskytuje komplexní ekosystém modulů zahrnující Spring Security pro autentizaci a autorizaci, Spring Data JPA pro přístup k relačním databázím, Spring MVC pro zpracování HTTP požadavků a Spring Boot Actuator pro monitoring a zdravotní kontroly [33]. Od verze 3 s Java 21 je podporováno využití virtuálních vláken projektu Loom, které umožňují efektivní zpracování tisíců souběžných požadavků bez režie tradičních platformových vláken [24]. Cosmina uvádí, že IoC kontejner platformy Spring automaticky spravuje životní cyklus komponent a jejich závislosti, čímž je dosaženo volné vazby mezi vrstvami aplikace [33]. Srovnání frameworků je uvedeno v tabulce 4.

**Tabulka 4: Srovnání backendových frameworků**

| Kritérium | Spring Boot | Node.js + Express | Django |
|-----------|------------|-------------------|--------|
| Jazyk | Java | JavaScript | Python |
| Typování | Statické | Dynamické | Dynamické |
| Model souběžnosti | Virtual threads | Event loop | Synchronní |
| Bezpečnostní framework | Spring Security | Třetí strany | Vestavěný |
| Geoprostorová podpora | Hibernate Spatial | Třetí strany | GeoDjango |
| ORM | Spring Data JPA | Třetí strany (Sequelize) | Vestavěný |
| Monitoring | Spring Actuator | Třetí strany | Omezený |

#### 2.3.2 Vrstvená architektura a průřezové mechanismy

Obdobně jako klientská aplikace vyžaduje vnitřní organizaci podle čisté architektury, i serverová aplikace vyžaduje jasné rozdělení odpovědností. Vrstvená architektura dělí backend do tří vrstev, kde vrstva kontrolerů přijímá HTTP požadavky a validuje vstupní data, servisní vrstva obsahuje obchodní logiku a řídí transakce, repozitářová vrstva zapouzdřuje přístup k databázi [34]. Klíčovým principem je, že žádná vrstva nesmí obcházet bezprostředně nižší vrstvu, tedy kontroler nikdy nepřistupuje přímo k databázi a repozitář nikdy neobsahuje obchodní logiku [3]. Tok požadavku a odpovědi napříč vrstvami backendu je znázorněn na obrázku 2, kde požadavek prochází autentizačním filtrem, kontrolerem, servisní vrstvou a repozitářem až do databáze, odkud se odpověď vrací zpět transformovaná na datový přenosový objekt.

*Obrázek 2: Sekvenční diagram toku požadavku v serverové aplikaci (vlastní zpracování)*

Základním principem umožňujícím fungování vrstvené architektury je Inversion of Control (IoC), při které framework přebírá odpovědnost za vytváření a propojování objektů namísto vývojáře. Cosmina uvádí, že IoC kontejner spravuje životní cyklus komponent a na základě deklarací automaticky vkládá závislosti do konstruktorů nebo polí tříd [33]. Tím je dosaženo volné vazby mezi vrstvami, protože servisní třída deklaruje závislost na abstraktním rozhraní repozitáře a kontejner zajistí vložení konkrétní implementace bez nutnosti explicitního vytváření instancí.

Validace vstupních dat na úrovni kontrolerů je zajištěna prostřednictvím specifikace Jakarta Bean Validation, která umožňuje deklarativní definici omezení přímo na atributech DTO (Data Transfer Object) prostřednictvím anotací definujících neprázdnost, minimální a maximální délku, formát e-mailové adresy a další omezení [33]. Framework při příjmu požadavku automaticky vyhodnotí deklarovaná omezení a v případě jejich porušení vrátí standardizovanou chybovou odpověď bez nutnosti psát validační logiku ručně.

Servisní vrstva zajišťuje řízení transakcí prostřednictvím deklarativního mechanismu, při kterém je metoda opatřena anotací a framework automaticky zahájí transakci před jejím provedením a potvrdí ji po úspěšném dokončení, nebo ji odvolá v případě výjimky. Deinum uvádí, že deklarativní transakce oddělují technický aspekt řízení transakcí od obchodní logiky a zajišťují atomicitu operací bez nutnosti explicitního programování hranic transakcí [35].

Kromě vrstvené organizace kódu vyžadují serverové aplikace řešení cross-cutting concerns, tedy funkcí zasahujících do více vrstev, jako je logování, bezpečnostní audit nebo rate limiting. Aspect-Oriented Programming (AOP) umožňuje definovat tyto funkce na jednom místě a deklarativně je aplikovat na vybrané metody prostřednictvím anotací, aniž by obchodní logika byla znečištěna technickým kódem [33]. Framework na základě deklarací automaticky obalí volání cílové metody kódem aspektu, čímž je zajištěno oddělení obchodní logiky od cross-cutting concerns.

Pro přístup k relační databázi z objektově orientovaného jazyka je využíván vzor Object-Relational Mapping (ORM), který překlenuje impedanční nesoulad mezi objektovým modelem aplikace a relačním modelem databáze [25]. Specifikace JPA (Jakarta Persistence API) definuje standardní rozhraní pro mapování tříd na databázové tabulky, správu životního cyklu entit a formulaci dotazů [33]. Implementace Hibernate poskytuje rozšíření Hibernate Spatial pro mapování geoprostorových datových typů na odpovídající typy rozšíření PostGIS [27]. Transformace mezi interními entitami a datovými přenosovými objekty určenými pro klientskou aplikaci je řešena prostřednictvím mapper rozhraní, čímž je zajištěno, že vnitřní reprezentace dat není vystavena vnějším konzumentům [34].

### 2.4 Komunikace a zabezpečení

Předchozí sekce popsaly architekturu klientské a serverové části systému jako samostatných komponent. Tato sekce se zaměřuje na mechanismy jejich vzájemné komunikace a zabezpečení této komunikace.

#### 2.4.1 REST API

Pro komunikaci mezi klientskou a serverovou částí je využíván architektonický styl REST (Representational State Transfer), který definuje sadu omezení pro návrh síťových aplikací, mezi které patří bezstavovost, jednotné rozhraní, oddělení klienta a serveru a vrstvený systém [3].

Bezstavovost vyžaduje, aby každý požadavek obsahoval veškeré informace potřebné pro jeho zpracování, bez závislosti na stavu uloženém na serveru mezi požadavky. Tento princip je klíčový pro horizontální škálování definované jako požadavek v kapitole 1.3.1, protože umožňuje distribuci požadavků na libovolnou instanci serveru [5]. Jednotné rozhraní je zajištěno prostřednictvím standardních HTTP metod, kde GET slouží pro čtení, POST pro vytvoření, PUT pro úplnou aktualizaci, PATCH pro částečnou aktualizaci a DELETE pro odstranění zdroje [35]. Odpovědi využívají standardní stavové kódy HTTP pro komunikaci výsledku operace, přičemž kódy řady 2xx pro úspěšné operace, 4xx pro chyby na straně klienta a 5xx pro chyby na straně serveru [3]. Pro dokumentaci REST API se využívá specifikace OpenAPI, na jejímž základě je generováno interaktivní rozhraní umožňující prohlížení a testování koncových bodů [24].

#### 2.4.2 Autentizace a autorizace

REST API zpřístupňuje koncové body klientským aplikacím, avšak bez mechanismu ověření identity a oprávnění by veškerá data byla dostupná komukoliv. Zabezpečení proto vyžaduje řešení dvou odlišných problémů. Autentizace zajišťuje ověření identity uživatele, zatímco autorizace ověřuje oprávnění k provedení konkrétní operace [15].

Pro autentizaci v bezstavových systémech je rozšířen mechanismus JSON Web Token (JWT) definovaný standardem RFC 7519. JWT je kompaktní, URL-bezpečný token sestávající ze tří částí, a to hlavičky specifikující algoritmus podpisu, datové části obsahující tvrzení o identitě uživatele a digitálního podpisu zajišťujícího integritu tokenu. Server při přihlášení vydá token podepsaný tajným klíčem a klient jej přikládá ke každému následujícímu požadavku v autorizační hlavičce [15]. V praxi se využívá vzor dvou tokenů, a to přístupového s krátkou platností a obnovovacího s delší platností pro získání nového přístupového tokenu po jeho expiraci. Reddy uvádí, že krátká platnost přístupového tokenu minimalizuje dopad jeho případného odcizení, zatímco obnovovací token eliminuje nutnost opakovaného přihlašování [34].

Pro přihlášení prostřednictvím externích poskytovatelů identity se využívá protokol OAuth 2.0 definovaný standardem RFC 6749. Protokol umožňuje uživateli autorizovat aplikaci k přístupu ke svému profilu u poskytovatele identity bez sdílení přihlašovacích údajů s aplikací [11]. Pro dodatečné zvýšení bezpečnosti slouží dvoufaktorová autentizace prostřednictvím jednorázových časových kódů podle standardu TOTP definovaného v RFC 6238, který využívá sdílený tajný klíč a aktuální čas pro generování kódu s omezenou platností [12].

Autorizace je řízena na základě modelu RBAC (Role-Based Access Control), který přiřazuje uživatelům role a rolím oprávnění. Sandhu uvádí, že RBAC zjednodušuje správu přístupových práv tím, že oprávnění jsou spravována na úrovni rolí namísto jednotlivých uživatelů [15]. Model může být rozšířen o granulární oprávnění na úrovni konkrétního kontextu, čímž je dosaženo jemnějšího řízení přístupu. Ochrana proti zneužití veřejně přístupných koncových bodů je zajištěna mechanismem rate limiting, který definuje maximální počet požadavků v daném časovém okně [16].

### 2.5 Správa verzí a průběžná integrace

Vývoj softwarového systému sestávajícího z více komponent vyžaduje nástroje pro sledování změn zdrojového kódu, koordinaci práce a automatizaci opakujících se úloh.

#### 2.5.1 Distribuované systémy správy verzí

Systém správy verzí uchovává kompletní historii změn zdrojového kódu a umožňuje návrat k libovolnému předchozímu stavu. Distribuované systémy správy verzí, jejichž nejrozšířenějším zástupcem je Git, se od centralizovaných systémů liší tím, že každý vývojář disponuje kompletní kopií repozitáře včetně celé historie [38]. Tím je zajištěna nezávislost na dostupnosti centrálního serveru a možnost práce bez síťového připojení.

Klíčovým konceptem systému Git je větvení (branching), které umožňuje paralelní vývoj několika funkcí bez vzájemného ovlivňování. Každá větev představuje nezávislou linii vývoje, která může být po dokončení sloučena zpět do hlavní větve. Vzdálená úložiště, jako je platforma GitHub, slouží jako centrální bod pro sdílení kódu mezi vývojáři, správu požadavků na sloučení změn a integraci s nástroji pro automatizaci [38].

#### 2.5.2 Průběžná integrace a nasazení

Průběžná integrace (Continuous Integration, CI) je praxe, při které je zdrojový kód po každé změně automaticky sestaven a otestován. Cílem je odhalit chyby co nejdříve po jejich zavedení, čímž se snižují náklady na jejich opravu oproti pozdějšímu odhalení v testovací nebo produkční fázi [3]. Sommerville uvádí, že automatizované testování při každé změně kódu je předpokladem pro udržení kvality systému v průběhu jeho evoluce [3].

Průběžné nasazení (Continuous Deployment, CD) rozšiřuje průběžnou integraci o automatické nasazení úspěšně otestovaného kódu do produkčního prostředí. Kombinace obou přístupů, označovaná jako CI/CD pipeline, zajišťuje, že cesta od změny zdrojového kódu po její dostupnost v produkčním prostředí je plně automatizovaná a reprodukovatelná.

#### 2.5.3 Kontejnerizace

Kontejnerizace je technika virtualizace na úrovni operačního systému, která umožňuje zabalit aplikaci společně s jejími závislostmi do izolované jednotky označované jako kontejner [28]. Na rozdíl od virtuálních strojů sdílejí kontejnery jádro hostitelského operačního systému, čímž dosahují výrazně nižší režie a rychlejšího startu.

Klíčovým přínosem kontejnerizace je zajištění konzistentního prostředí napříč vývojem, testováním a produkcí. Aplikace zabalená do kontejneru se chová identicky bez ohledu na prostředí, ve kterém je spuštěna, čímž je eliminována kategorie chyb způsobených rozdíly v konfiguraci prostředí. Nástroje pro orchestraci kontejnerů umožňují definovat celé vývojové prostředí sestávající z více služeb, jako je aplikační server, databáze a podpůrné mikroslužby, a spustit je jedním příkazem [28].

Tato kapitola popsala teoretická východiska pro architekturu celého systému, klientské a serverové části, mechanismy jejich komunikace a zabezpečení a nástroje pro správu kódu a automatizaci. Následující kapitola se zaměřuje na datovou vrstvu, konkrétně na návrh databázového modelu, geoprostorové dotazy a optimalizaci přístupu k datům.

## 3 Návrh databáze

Předchozí kapitola popsala architektonické principy a technologie pro klientskou a serverovou část systému. Datová vrstva, jejíž návrh je předmětem této kapitoly, zajišťuje perzistentní uložení veškerých strukturovaných dat a musí splňovat požadavky na výkon a spolehlivost definované v kapitolách 1.3.3 a 1.3.4. Výklad postupuje od volby databázové technologie přes principy relačního modelování a geoprostorových dotazů až po strategie optimalizace přístupu k datům [25].

### 3.1 Databázové modely a technologie

#### 3.1.1 Typy databázových modelů

Pro perzistentní ukládání dat v informačních systémech existuje několik databázových modelů, které se liší způsobem organizace dat a typem operací, pro které jsou optimalizovány.

Relační model organizuje data do tabulek s pevně definovanými sloupci a datovými typy, přičemž vztahy mezi tabulkami jsou vyjádřeny prostřednictvím cizích klíčů. Klíčovou vlastností relačního modelu je podpora transakcí splňujících vlastnosti ACID, kde atomicita zajišťuje, že transakce proběhne buď celá, nebo vůbec, konzistence zaručuje přechod databáze z jednoho platného stavu do jiného, izolace odděluje souběžné transakce a trvalost garantuje, že potvrzené změny přetrvají i při selhání systému. Relační model je vhodný pro domény s jasně definovanými entitami, pevnými vztahy a požadavkem na referenční integritu [25].

Dokumentový model ukládá data jako samostatné dokumenty, typicky ve formátu JSON nebo BSON, bez pevně definovaného schématu. Výhodou je flexibilita při vývoji a přirozená reprezentace hierarchických dat, nevýhodou omezená podpora transakcí napříč více dokumenty a absence referenční integrity na úrovni databáze [25].

Grafový model reprezentuje data jako uzly propojené hranami a je optimalizován pro dotazy procházející vztahy mezi entitami, jako jsou sociální sítě nebo doporučovací systémy. Pro aplikace s převážně tabulkovými daty a jednoduchými vztahy nepřináší grafový model výhody oproti relačnímu modelu [25].

Klíčovo-hodnotový model ukládá data jako dvojice klíč a hodnota a je optimalizován pro rychlé čtení a zápis jednotlivých záznamů, avšak neumožňuje složité dotazy ani vztahy mezi záznamy.

Na základě požadavků definovaných v kapitole 1, které zahrnují jasně definované entity s pevnými vztahy, potřebu referenční integrity a atomických transakcí při kontrole dostupnosti zdrojů a geoprostorové dotazy pro vyhledávání restaurací v okolí, byl zvolen relační databázový model jako nejvhodnější přístup [25].

#### 3.1.2 Srovnání relačních databázových systémů

Po volbě relačního modelu je dalším krokem výběr konkrétního databázového systému. V rámci relačního modelu existují systémy s odlišnými vlastnostmi, které se liší zejména v podpoře pokročilých datových typů a geoprostorových operací. MySQL je rozšířený systém s vysokým výkonem pro čtecí operace, avšak s omezenější podporou pokročilých datových typů a prostorových funkcí [25]. PostgreSQL je nejpoužívanější databází mezi vývojáři s podílem 49 % dle průzkumu Stack Overflow z roku 2024 [26] a rozšíření PostGIS přidává více než tisíc funkcí pro práci s geoprostorovými daty [27]. Srovnání je uvedeno v tabulce 5.

**Tabulka 5: Srovnání relačních databázových systémů**

| Kritérium | PostgreSQL | MySQL |
|-----------|-----------|-------|
| Geoprostorová podpora | PostGIS (1000+ funkcí) | Základní |
| Podíl vývojářů (2024) | 49 % | 40 % |
| Pokročilé datové typy | JSONB, pole, rozsahy | Omezené |
| Licence | Open-source | GPL / komerční |

#### 3.1.3 Normalizace a záměrná denormalizace

Zvolený relační model vyžaduje při návrhu schématu rozhodnutí o míře normalizace dat. Normalizace je proces organizace dat do tabulek způsobem, který minimalizuje redundanci a zajišťuje konzistenci. Třetí normální forma vyžaduje, aby každý neklíčový atribut závisel přímo a výhradně na primárním klíči, čímž je eliminována tranzitivní závislost [3].

V praxi je však třetí normální forma někdy záměrně porušena ve prospěch výkonu nebo zachování historické konzistence. Typickým příkladem je entita položky objednávky. Normalizovaný přístup by uchovával pouze odkaz na položku menu a aktuální cenu by vždy načítal z referenční tabulky. Pokud však provozovatel změní cenu položky, normalizovaný přístup by zpětně ovlivnil zobrazení historických objednávek. Proto se v objednávkových systémech uplatňuje vzor denormalizovaného snapshotu, při kterém je název a cena položky zkopírována do záznamu objednávky v okamžiku jejího vytvoření [3].

#### 3.1.4 Entitně-relační modelování

Před samotným vytvořením databázového schématu je nutné identifikovat entity, jejich atributy a vzájemné vztahy. K tomuto účelu slouží entitně-relační modelování, které poskytuje grafickou notaci pro vizualizaci struktury dat nezávisle na konkrétním databázovém systému [3].

Entita reprezentuje objekt reálného světa, o kterém systém uchovává data, jako je uživatel, restaurace nebo rezervace. Každá entita je charakterizována sadou atributů popisujících její vlastnosti. Jeden nebo více atributů tvoří primární klíč, který jednoznačně identifikuje každý výskyt entity v databázi [3].

Vztahy mezi entitami jsou klasifikovány podle kardinality. Vztah jedna-ku-mnoha (1:N) vyjadřuje, že jeden výskyt entity na jedné straně může být spojen s více výskyty entity na druhé straně, například jedna restaurace má více stolů. Vztah mnoho-ku-mnoha (N:M) vyjadřuje, že více výskytů na obou stranách může být vzájemně spojeno, například uživatel může mít více rolí a jedna role může být přiřazena více uživatelům. Vztah mnoho-ku-mnoha je v relační databázi realizován prostřednictvím spojovací tabulky obsahující cizí klíče obou entit [3]. Vztah jedna-ku-jedné (1:1) vyjadřuje, že jeden výskyt entity je spojen s nejvýše jedním výskytem jiné entity, například uživatel má nejvýše jeden záznam dvoufaktorové autentizace.

Výsledkem entitně-relačního modelování je ER diagram, který vizualizuje entity jako obdélníky, atributy jako ovály a vztahy jako čáry s vyznačenou kardinalitou. ER diagram slouží jako komunikační nástroj mezi návrháři a vývojáři a jako podklad pro vytvoření fyzického databázového schématu [3].

### 3.2 Geoprostorové databáze a rozšíření PostGIS

Předchozí sekce popsala principy relačního modelování platné pro libovolnou doménu. Požadavek na vyhledávání restaurací v okolí uživatele definovaný v kapitole 1.2.1 však vyžaduje databázovou podporu přesahující možnosti standardního relačního modelu. Aplikace pracující s geografickými daty, jako je vyhledávání objektů v okolí, výpočet vzdáleností nebo shlukování bodů na mapě, potřebují databázovou podporu přesahující možnosti standardního relačního modelu. Rozšíření PostGIS přidává do databáze PostgreSQL podporu pro geoprostorové datové typy, prostorové indexy a funkce pro práci s geometrickými a geografickými objekty [27].

Základním geoprostorovým datovým typem je geometrický bod (Point) definovaný souřadnicemi zeměpisné délky a šířky. Souřadnicový systém WGS 84 identifikovaný kódem SRID 4326 reprezentuje souřadnice ve stupních a je standardem pro globální polohové systémy a mapové služby [27].

#### 3.2.1 Prostorové indexy

Standardní indexové struktury typu B-tree jsou navrženy pro jednorozměrná data a nejsou schopny efektivně vyhodnocovat dvourozměrné prostorové dotazy. Pro geoprostorová data je využíván index typu GiST (Generalized Search Tree), který organizuje geometrie do hierarchických bounding boxes. Při vyhledávání jsou nejprve vyloučeny celé podstromy, jejichž bounding box nepřekrývá oblast zájmu, čímž je dosaženo logaritmické složitosti vyhledávání místo lineárního průchodu celou tabulkou [31]. Bez prostorového indexu by každý geoprostorový dotaz vyžadoval sekvenční průchod všemi záznamy, což by při rostoucím objemu dat vedlo k nepřijatelné odezvě.

#### 3.2.2 Typy prostorových dotazů

Prostorový index zajišťuje efektivní přístup k datům, avšak samotné dotazy využívají specializované funkce rozšíření PostGIS. V aplikacích s mapovým zobrazením se typicky vyskytují dva vzory prostorových dotazů.

Prvním typem je dotaz na nejbližší objekty v zadaném okruhu od referenčního bodu. Funkce ST_DWithin rozšíření PostGIS je optimalizována pro využití GiST indexu, protože na rozdíl od obecného výpočtu vzdálenosti funkcí ST_Distance nejprve provede filtraci na úrovni indexu a teprve na výsledné kandidátní množině vypočítá přesnou vzdálenost [27]. Výsledky jsou řazeny operátorem vzdálenosti, který rovněž využívá index pro efektivní řazení bez nutnosti třídění celé výsledkové množiny.

Druhým typem je adaptivní shlukování blízkých objektů do klastrů prostřednictvím okenní funkce ST_ClusterDBSCAN. Algoritmus DBSCAN (Density-Based Spatial Clustering of Applications with Noise) přijímá dva parametry. Epsilon definuje maximální vzdálenost mezi dvěma body, aby byly považovány za sousední, zatímco minpoints určuje minimální počet bodů pro vytvoření klastru [31]. Parametr epsilon může být dynamicky odvozován od úrovně přiblížení mapy, přičemž při větším oddálení je epsilon vyšší a více objektů je sloučeno do klastrů, při přiblížení se epsilon snižuje a klastry se rozpadají na jednotlivé značky. Shlukování je klíčové pro mapové aplikace s velkým počtem bodů, kde by zobrazení každého bodu samostatně vedlo k nepřehlednému překrývání značek.

### 3.3 Optimalizace přístupu k datům

Předchozí sekce se zaměřila na geoprostorové dotazy jako specifický případ přístupu k datům. Většina dotazů v aplikační databázi je však negeoprostorového charakteru, jako je vyhledávání uživatele podle e-mailu, načítání rezervací pro konkrétní stůl a datum nebo filtrování restaurací podle stavu. Efektivní zpracování těchto dotazů vyžaduje vhodnou strategii indexování a správu databázového schématu.

#### 3.3.1 Strategie indexování

Indexy urychlují vyhledávání záznamů tím, že databázovému systému umožňují přeskočit sekvenční průchod celou tabulkou. Volba indexů vychází z analýzy nejčastějších vzorů přístupu k datům [25]. Databázový systém PostgreSQL na rozdíl od některých jiných systémů nevytváří indexy na cizích klíčích automaticky, proto je nutné je definovat explicitně.

Rozlišují se tři základní typy indexů relevantní pro aplikační databáze. Jednoduché indexy s omezením jedinečnosti zajišťují, že hodnota atributu je v celé tabulce unikátní, a současně urychlují vyhledávání podle tohoto atributu, typickým příkladem je e-mailová adresa uživatele. Složené indexy pokrývají dotazy filtrující podle více atributů současně, například kontrola časového překrývání rezervací vyžaduje efektivní filtrování podle identifikátoru zdroje a data v jednom dotazu. Omezení jedinečnosti na kombinacích atributů zabraňují duplicitním záznamům a současně slouží jako indexy [25].

#### 3.3.2 Správa databázového schématu

Kromě optimalizace dotazů prostřednictvím indexů je důležitým aspektem správy databáze řízení evoluce schématu v průběhu vývoje. Evoluce databázového schématu může být řízena dvěma přístupy. Automatická synchronizace porovnává při startu aplikace entitní model s aktuálním stavem databáze a automaticky vytváří nebo modifikuje tabulky a sloupce. Tento přístup je vhodný pro ranou fázi vývoje, avšak v produkčním prostředí představuje riziko nechtěných destruktivních změn [24]. Verzované migrace využívají sadu sekvenčně číslovaných skriptů, z nichž každý popisuje jednu inkrementální změnu schématu. Migrační nástroj při startu aplikace vyhodnotí, které skripty již byly aplikovány, a provede pouze dosud neaplikované změny, čímž je zajištěna reprodukovatelnost a auditovatelnost evoluce schématu [24].

Tato kapitola popsala teoretická východiska pro návrh datové vrstvy, a to relační model, geoprostorové dotazy a optimalizaci přístupu k datům. Konkrétní realizace databázového modelu systému CheckFood včetně popisu doménových oblastí, entit a vztahů je popsána v kapitole 4.

# Praktická část

Praktická část práce popisuje implementaci navrženého systému, výsledky testování a nasazení do produkčního prostředí. Vychází z architektonických a databázových rozhodnutí učiněných v teoretické části a dokumentuje konkrétní postupy při realizaci backendové aplikace a mobilního klienta.

---

## 4 Implementace systému

Implementační část diplomové práce je věnována praktické realizaci navrženého systému pro digitální správu rezervací a objednávek v gastronomických provozech. Na základě teoretických východisek popsaných v kapitolách 2 a 3 byl systém realizován jako monolitická aplikace s modulárním uspořádáním v souladu s architektonickými styly popsanými v kapitole 2.1. Zdrojový kód celého systému je spravován prostřednictvím systému správy verzí Git se vzdáleným úložištěm na platformě GitHub v souladu s principy popsanými v kapitole 2.5. Repozitář slouží zároveň jako digitální příloha práce zpřístupňující zdrojové kódy pro účely obhajoby a verifikace dosažených výsledků.

Vývoj systému probíhal v lokálním prostředí, kde databáze PostgreSQL s rozšířením PostGIS běží v kontejneru Docker na portu 5433 prostřednictvím nástroje Docker Compose. Backendová aplikace ve frameworku Spring Boot je spouštěna lokálně mimo Docker na portu 8081 a připojuje se k databázi v kontejneru. Mobilní aplikace ve frameworku Flutter byla vyvíjena a testována na fyzických zařízeních s operačními systémy Android a iOS připojených prostřednictvím kabelu. Přehled lokální architektury je znázorněn na obrázku 3. Produkční nasazení na platformě Google Cloud je popsáno v kapitole 6. Kompletní přehled zvolených technologií je uveden v tabulce 6.

*Obrázek 3: Architektura lokálního vývojového prostředí (vlastní zpracování)*

**Tabulka 6: Technologický zásobník systému CheckFood**

| Vrstva | Technologie | Verze |
|--------|------------|-------|
| Frontend | Flutter + Dart | 3.7.2 |
| Backend | Spring Boot + Java | 3.5.7 / JDK 21 |
| Databáze | PostgreSQL + PostGIS | 15 / 3.4 |
| Lokální vývoj | Docker Compose | — |
| CI/CD | GitHub Actions | — |
| Produkční hosting | Google Cloud Platform | — |

Databázový model systému se skládá z dvaceti tří tabulek logicky rozdělených do pěti doménových oblastí vycházejících z funkčních požadavků definovaných v kapitole 1.2. Bezpečnostní modul pokrývá správu uživatelských účtů, autentizaci a autorizaci, přičemž jádrem je entita uživatele propojená s entitami rolí vazbou mnoho-ku-mnoha, čímž je realizován model RBAC popsaný v kapitole 2.4.2 [15]. Modul restaurací pokrývá správu gastronomických podniků s polohou uloženou jako geoprostorový bod v souladu s principy popsanými v kapitole 3.2. Modul rezervací pokrývá kompletní životní cyklus rezervace se stavovým automatem sedmi stavů. Modul objednávek a menu využívá vzor denormalizovaného snapshotu popsaný v kapitole 3.1.3. Modul panoramat pokrývá proces pořízení a zpracování panoramatických snímků.

Při návrhu modelu jsou uplatněny konvence zajišťující konzistenci napříč všemi entitami. Doménové entity využívají jako primární klíč typ UUID zajišťující nepředvídatelnost identifikátorů ve veřejném API [16], systémové entity využívají typ BIGINT s automatickou generací. Peněžní částky jsou ukládány v nejmenších peněžních jednotkách jako celočíselný typ, čímž jsou eliminovány chyby aritmetiky s plovoucí řádovou čárkou [25]. Výčtové hodnoty jsou ukládány jako textové řetězce zajišťující čitelnost dat a odolnost vůči změně pořadí hodnot ve zdrojovém kódu. Vztahy uvnitř jednoho agregátu jsou realizovány prostřednictvím objektových vazeb s kaskádovými operacemi, zatímco vztahy mezi agregáty z různých doménových oblastí jsou realizovány prostřednictvím prostých hodnot cizích klíčů, čímž jsou oslabeny vazby a umožněn nezávislý vývoj agregátů [5]. Přehled hlavních vztahů mezi entitami je znázorněn na obrázku 2.

*Obrázek 4: ER diagram databázového modelu systému CheckFood (vlastní zpracování)*

### 4.1 Implementace backendu

Backendová aplikace představuje centrální komponentu systému, která zajišťuje zpracování obchodní logiky, správu dat a komunikaci s klientskými aplikacemi. V následujících sekcích je popsán proces implementace od konfigurace vývojového prostředí přes realizaci klíčových funkčních oblastí až po zabezpečení systému.

#### 4.1.1 Konfigurace projektu a vývojového prostředí

Jako běhová platforma byl stanoven JDK 21 distribuce Eclipse Temurin s podporou virtuálních vláken projektu Loom. Sestavení aplikace je automatizováno nástrojem Apache Maven prostřednictvím obálkového skriptu. Základní rámec aplikace byl vytvořen prostřednictvím Spring Initializr [24]. Zdrojové kódy jsou organizovány do balíčků odpovídajících vrstvené architektuře popsané v kapitole 2.3, a to entity, repozitáře, služby, kontrolery, datové přenosové objekty, mapovací rozhraní MapStruct a konfigurace zabezpečení.

Systém je kontejnerizován prostřednictvím platformy Docker v souladu s principy popsanými v kapitole 2.5.3 [28]. Backendová aplikace je zabalena vícefázovým sestavením, kde první fáze provádí kompilaci v obrazu Maven s JDK 21 a druhá fáze vytváří minimalistický JRE obraz pro běh aplikace. Lokální vývojové prostředí využívá Docker Compose pro spuštění databáze PostGIS na portu 5433. Backendová aplikace je spouštěna lokálně mimo Docker na portu 8081 a připojuje se k databázi v kontejneru prostřednictvím JDBC. Konfigurace pro různá prostředí je řízena třemi aplikačními profily Spring Boot, a to lokální s podrobným logováním, testovací s in-memory databází H2 a produkční s připojením ke cloudové databázi na platformě Google Cloud [24].

#### 4.1.3 Implementace entitního modelu

Databázové entity jsou implementovány jako třídy jazyka Java opatřené anotacemi specifikace JPA a knihovny Lombok. Anotace JPA zajišťují mapování tříd na databázové tabulky, definici primárních klíčů, sloupců, vazeb a omezení. Anotace Lombok eliminují nutnost psaní opakujícího se kódu, jako jsou přístupové metody, konstruktory a vzor builder, čímž se kód entit zaměřuje výhradně na definici atributů a jejich omezení.

Jako příklad je uvedena entita rezervace, která ilustruje typickou strukturu JPA entity v systému CheckFood:

```java
@Entity
@Table(name = "reservation", indexes = {
    @Index(name = "idx_reservation_table_date",
           columnList = "table_id, reservation_date"),
    @Index(name = "idx_reservation_user", columnList = "user_id"),
    @Index(name = "idx_reservation_restaurant", columnList = "restaurant_id")
})
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Column(name = "table_id", nullable = false)
    private UUID tableId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    @Builder.Default
    private ReservationStatus status = ReservationStatus.PENDING_CONFIRMATION;

    @Column(name = "reservation_date", nullable = false)
    private LocalDate date;

    @Column(name = "start_time", nullable = false)
    private LocalTime startTime;

    @Column(name = "end_time")
    private LocalTime endTime;

    @Column(name = "party_size", nullable = false)
    @Builder.Default
    private int partySize = 2;
}
```

Na uvedeném příkladu je patrné využití generovaného primárního klíče typu UUID, složeného indexu na kombinaci stolu a data pro efektivní kontrolu překrývání popsanou v kapitole 3.3.1, výčtového stavu ukládaného jako textový řetězec a volitelného koncového času umožňujícího modelování otevřených rezervací.

Entita uživatele implementuje rozhraní Spring Security UserDetails, které umožňuje přímé využití entity v autentizačním procesu. Metoda pro získání uživatelského jména vrací e-mailovou adresu a metoda pro získání oprávnění transformuje přiřazené role na autority Spring Security s povinným prefixem ROLE_. Heslo je ukládáno jako hash algoritmem BCrypt s faktorem náročnosti 12, přičemž pro uživatele přihlášené prostřednictvím externích poskytovatelů identity je pole hesla prázdné.

Entita restaurace představuje nejkomplexnější datový model v systému s více než dvaceti atributy. Poloha restaurace je uložena jako geometrický bod typu PostGIS Point se souřadnicovým systémem WGS 84, reprezentovaný třídou Point z knihovny Java Topology Suite. Adresa je implementována jako vložená struktura, otevírací hodiny a speciální dny jako vložené kolekce uložené v samostatných tabulkách.

Entita zaměstnance restaurace reprezentuje vazbu mezi uživatelem a restaurací s přiřazenou rolí z výčtu čtyř hodnot, a to vlastník, manažer, zaměstnanec a hostitel. Kolekce jedenácti granulárních oprávnění je implementována jako ElementCollection ukládaná do samostatné tabulky. Entita položky objednávky implementuje záměrnou denormalizaci popsanou v kapitole 3.1.3, kdy název položky a jednotková cena jsou uloženy přímo v záznamu objednávky jako snapshot hodnot platných v okamžiku objednání.

#### 4.1.4 Implementace repozitářové vrstvy

Repozitáře systému rozšiřují rozhraní JpaRepository frameworku Spring Data JPA, které poskytuje kompletní sadu operací pro vytváření, čtení, aktualizaci a mazání záznamů bez nutnosti psát implementační kód. Pro složitější dotazy jsou definovány vlastní metody, jejichž implementaci Spring Data JPA automaticky generuje na základě konvence pojmenování. Například metoda pro nalezení restaurací podle stavu a příznaku aktivnosti generuje odpovídající SQL dotaz pouze na základě názvu metody [25].

Pro geoprostorové dotazy nad tabulkou restaurací jsou definovány vlastní nativní SQL dotazy využívající funkce rozšíření PostGIS popsané v kapitole 3.2.2. Dotaz na nejbližší restaurace využívá operátor vzdálenosti pro řazení výsledků podle vzdálenosti od polohy uživatele. Dotaz na značky pro mapové zobrazení využívá algoritmus DBSCAN pro adaptivní shlukování s parametrem epsilon odvozeným od úrovně přiblížení mapy [27] [31]. Klíčová část dotazu je uvedena v následující ukázce:

```sql
WITH filtered_restaurants AS (
    SELECT id, location, name, logo_url
    FROM restaurant
    WHERE is_active = true
      AND location && ST_MakeEnvelope(:minLng, :minLat, :maxLng, :maxLat, 4326)
    LIMIT :inputLimit
),
clusters AS (
    SELECT id, location, name, logo_url,
           ST_ClusterDBScan(location, eps := :distance, minpoints := 1)
               OVER () AS cluster_id
    FROM filtered_restaurants
)
SELECT
    ST_Y(ST_Centroid(ST_Collect(location))) as latitude,
    ST_X(ST_Centroid(ST_Collect(location))) as longitude,
    CAST(COUNT(*) AS INTEGER) as count
FROM clusters GROUP BY cluster_id
```

Dotaz nejprve filtruje restaurace v zobrazené oblasti mapy prostřednictvím operátoru překryvu ohraničujících rámců, následně aplikuje algoritmus DBSCAN s parametrem epsilon odpovídajícím úrovni přiblížení a nakonec pro každý klastr vypočítá centroid a počet restaurací.

Pro entitu uživatele je definován speciální dotaz s direktivou EntityGraph, která zajišťuje současné načtení uživatele, jeho rolí a zařízení v jediném databázovém dotazu. Tento přístup eliminuje problém N+1 dotazů popsaný v kapitole 3.2.3 a je klíčový pro výkon autentizačního procesu, který probíhá při každém požadavku.

#### 4.1.5 Implementace servisní vrstvy

Servisní vrstva implementuje veškerou obchodní logiku systému prostřednictvím servisních tříd anotovaných jako komponenty Spring s podporou deklarativního řízení transakcí. Každá servisní metoda, která modifikuje data, probíhá v rámci databázové transakce, která zajišťuje atomicitu operace, tedy buď jsou všechny změny úspěšně uloženy, nebo jsou v případě chyby kompletně odvolány.

**Servis rezervací** implementuje nejkomplexnější obchodní logiku v systému, jejíž požadavky byly definovány v kapitole 1.2. Při vytváření nové rezervace servis provádí řetězec validačních kroků, jehož průběh je znázorněn na obrázku 5.

*Obrázek 5: Validační řetězec při vytváření rezervace (vlastní zpracování)*

Prvním krokem je ověření existence a aktivního stavu restaurace. Druhým krokem je ověření existence stolu a jeho příslušnosti k dané restauraci. Třetím krokem je kontrola souladu požadovaného počtu osob s kapacitou stolu. Čtvrtým krokem je ověření, zda zvolený čas spadá do otevírací doby restaurace, přičemž jsou zohledněny speciální dny a svátky. Pátým krokem je kontrola překrývání s existujícími rezervacemi na daném stole, která využívá složený index popsaný v kapitole 3.3.1. Dále je implementována ochrana proti zneužití omezující maximální počet aktivních rezervací na uživatele. Ukázka klíčové části validační logiky:

```java
public ReservationResponse createReservation(
        CreateReservationRequest request, Long userId) {
    var restaurant = findRestaurant(request.getRestaurantId());
    var table = findTableInRestaurant(request.getTableId(),
                                      request.getRestaurantId());
    validateNotInPast(request.getDate(), request.getStartTime());

    if (request.getPartySize() > table.getCapacity()) {
        throw ReservationException.partySizeExceedsCapacity(
            request.getPartySize(), table.getCapacity());
    }

    boolean conflict = reservationRepository.existsOverlappingReservation(
        request.getTableId(), request.getDate(),
        request.getStartTime(), endTime);

    if (conflict) {
        throw ReservationException.slotConflict();
    }
    // ... vytvoření a uložení rezervace
}
```

Pokud jakákoli kontrola selže, servis vyvolá příslušnou výjimku transformovanou na HTTP chybovou odpověď se stavovým kódem 404 pro neexistující entitu, 400 pro neplatný vstup a 409 pro časový konflikt.

Rezervace prochází životním cyklem definovaným stavovým automatem se sedmi stavy a přípustnými přechody, který je znázorněn na obrázku 6.

*Obrázek 6: Stavový automat rezervace (vlastní zpracování)*

**Servis objednávek** implementuje mechanismus stravovacího kontextu, který propojuje objednávku s aktivní rezervací zákazníka. Při dotazu na kontext systém vyhledá aktuální nebo nadcházející potvrzenou rezervaci zákazníka v dané restauraci. Vyhledávání zohledňuje časové okno tolerance, kdy rezervace je považována za relevantní, pokud její plánovaný čas začátku leží v přiměřeném intervalu od aktuálního času, čímž je zákazníkovi umožněno objednat si jídlo krátce před plánovaným příchodem. Na základě nalezené rezervace je automaticky určen stůl a restaurace, ke kterým bude objednávka přiřazena, a zákazník nemusí tyto údaje zadávat ručně. Pokud žádná relevantní rezervace není nalezena, klientská aplikace informuje zákazníka o nutnosti nejprve vytvořit rezervaci. Při vytváření objednávky servis nejprve ověří existenci a aktivní stav všech požadovaných položek v menu restaurace. Pro každou položku je z databáze načtena aktuální cena a porovnána s cenou zaslanou klientem. V případě nesouladu je objednávka odmítnuta s informací o změně ceny, čímž je zajištěno, že zákazník vždy potvrzuje aktuální částku. Celková cena objednávky je vypočítána jako součet součinů jednotkových cen a množství v haléřích, jak je popsáno v kapitole 3.3. Záznamy položek objednávky jsou vytvořeny s denormalizovanými snímky názvů a cen platnými v okamžiku objednání.

**Servis zaměstnanců** implementuje správu granulárních oprávnění. Při přidání nového zaměstnance je automaticky přiřazena výchozí sada oprávnění odpovídající jeho roli. Vlastník obdrží kompletní sadu všech jedenácti oprávnění, manažer obdrží většinu oprávnění s výjimkou správy zaměstnanců a hostitel obdrží základní oprávnění pro práci s rezervacemi. Vlastník restaurace může následně oprávnění jednotlivých zaměstnanců individuálně upravovat.

**Plánované úlohy** zajišťují automatizaci provozních procesů. Úloha automatického potvrzení se spouští v pravidelných intervalech a potvrdí všechny rezervace, které jsou ve stavu čekající na potvrzení déle než patnáct minut. Úloha generování instancí opakujících se rezervací vytváří jednotlivé rezervace pro nadcházející období. Úloha čištění auditních záznamů odstraňuje záznamy starší než definované retenční období. Všechny plánované úlohy jsou konfigurovány prostřednictvím cron výrazů v anotacích frameworku Spring Boot [24].

#### 4.1.6 Zabezpečení API

Implementace zabezpečení vychází z principů popsaných v kapitole 2.4.2. Bezpečnostní řetězec Spring Security je konfigurován s deaktivovanou CSRF ochranou, bezstavovou správou relací a vlastním autentizačním filtrem zařazeným před standardní filtr přihlášení. Konfigurace autorizačních pravidel definuje, které koncové body jsou veřejně přístupné a které vyžadují autentizaci:

```java
.authorizeHttpRequests(auth -> auth
    .requestMatchers(
        "/api/auth/register", "/api/auth/login",
        "/api/auth/verify", "/api/auth/refresh",
        "/api/oauth/**"
    ).permitAll()
    .requestMatchers(
        "/api/v1/restaurants/markers",
        "/api/v1/restaurants/nearest"
    ).permitAll()
    .anyRequest().authenticated()
)
```

Tokeny jsou podepsány algoritmem HMAC-SHA256 prostřednictvím tříd NimbusJwtEncoder a NimbusJwtDecoder z modulu Spring OAuth2 Resource Server. Přístupový token obsahuje identifikátor vydavatele, čas vydání a expirace, e-mailovou adresu, sadu rolí a typ tokenu [15].

Rate limiting je implementován prostřednictvím vlastní anotace a Aspect-Oriented Programming s mechanismem posuvného okna. Následující ukázka ilustruje použití anotace na registračním endpointu:

```java
@RateLimited(key = "auth:register", limit = 5,
             duration = 15, unit = TimeUnit.MINUTES, perIp = true)
@PostMapping("/register")
public ResponseEntity<Void> register(
        @Valid @RequestBody RegisterRequest request) {
    authService.register(request);
    return ResponseEntity.accepted().build();
}
```

V systému je chráněno čtrnáct koncových bodů s limity od tří požadavků za pět minut po třicet za minutu [16]. Verifikace OAuth tokenů Google je realizována knihovnou Google API Client, verifikace Apple tokenů vlastní implementací s načítáním veřejných klíčů prostřednictvím klienta Feign s dvacetičtyřhodinovou vyrovnávací pamětí.

#### 4.1.7 Registrace vlastníka restaurace

Registrace vlastníka restaurace je realizována prostřednictvím registračního formuláře, ve kterém uživatel zvolí roli vlastníka. Po registraci je automaticky vytvořena testovací restaurace viditelná pouze danému vlastníkovi. Vlastník může prostřednictvím šestikrokového průvodce popsaného v kapitole 4.2.7 konfigurovat restauraci a připravit ji k publikaci. V produkčním prostředí je zveřejnění restaurace podmíněno manuálním schválením administrátorem systému. Automatizované ověření vlastnictví prostřednictvím registru ARES nebo služby BankID je identifikováno jako plánované rozšíření.

#### 4.1.8 Dokumentace API

Kompletní dokumentace rozhraní REST API je automaticky generována z anotací zdrojového kódu prostřednictvím knihovny SpringDoc OpenAPI verze 2.8.5. Výsledná specifikace ve formátu OpenAPI 3.0 je dostupná prostřednictvím interaktivního webového rozhraní Swagger UI na adrese dokumentačního koncového bodu. Swagger UI umožňuje procházet všech sto deset koncových bodů organizovaných do dvaceti skupin, prohlížet strukturu požadavků a odpovědí, testovat volání přímo z prohlížeče a ověřovat autorizační požadavky. Dokumentace je průběžně aktualizována s každou změnou API a slouží jako závazný kontrakt mezi serverovou a klientskou částí systému [24].

### 4.2 Implementace frontendové aplikace

Mobilní aplikace systému CheckFood je implementována ve frameworku Flutter s využitím jazyka Dart verze 3.7.2. Architektura aplikace byla podrobně popsána v kapitole 2.2 z pohledu návrhu — tato kapitola doplňuje implementační detaily, popisuje konkrétní postupy při vývoji, řešení technických problémů a tok dat na úrovni zdrojového kódu.

#### 4.2.1 Generování kódu a datové modely

Významnou součástí implementačního procesu je využití generování kódu prostřednictvím nástroje build_runner, který na základě anotací ve zdrojovém kódu automaticky vytváří podpůrné třídy při kompilaci. V systému CheckFood je generování kódu využíváno pro tři účely.

Knihovna Freezed zajišťuje generování neměnných datových tříd s podporou porovnávání hodnot, kopírování s modifikací a zpracování vzorů. Každý datový model přenášený po síti je definován jako třída s anotací Freezed a s tovární metodou pro deserializaci z formátu JSON. Modely dále obsahují konverzní metodu toEntity, která transformuje síťový model na doménovou entitu. Následující ukázka ilustruje model odpovědi rezervace:

```dart
@freezed
class ReservationResponseModel with _$ReservationResponseModel {
  const ReservationResponseModel._();

  const factory ReservationResponseModel({
    String? id,
    String? restaurantId,
    String? tableId,
    String? date,
    String? startTime,
    String? status,
    int? partySize,
    @Default(false) bool canEdit,
    @Default(false) bool canCancel,
  }) = _ReservationResponseModel;

  factory ReservationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationResponseModelFromJson(json);

  Reservation toEntity() => Reservation(
        id: id ?? '',
        restaurantId: restaurantId ?? '',
        tableId: tableId ?? '',
        date: date ?? '',
        startTime: startTime ?? '',
        status: status ?? 'RESERVED',
        partySize: partySize ?? 2,
        canEdit: canEdit,
        canCancel: canCancel,
      );
}
```

Tento dvoustupňový přístup zajišťuje, že doménová vrstva je nezávislá na konkrétním formátu dat přijímaných ze serveru a změna struktury API odpovědi vyžaduje úpravu pouze v datové vrstvě [29].

Knihovna json_serializable generuje serializační a deserializační kód pro převod mezi objekty jazyka Dart a formátem JSON. V kombinaci s knihovnou Freezed je pro každý model automaticky vygenerována tovární metoda fromJson pro vytvoření instance z mapy klíč-hodnota a metoda toJson pro převod instance zpět na mapu. Vývojář definuje pouze strukturu modelu a anotace, zatímco veškerý opakující se kód pro parsování je generován automaticky. V systému CheckFood je tento přístup aplikován na více než třicet datových modelů pokrývajících odpovědi všech hlavních koncových bodů backendu — modely uživatele, restaurace, rezervace, objednávky, položky menu, zaměstnance a dalších entit.

Třetí oblastí generování kódu je vytváření stavů a událostí komponent BLoC. Každá komponenta BLoC definuje sadu událostí reprezentujících uživatelské akce a sadu stavů reprezentujících aktuální stav zobrazení. Stavy jsou implementovány jako neměnné třídy s knihovnou Freezed, která pro ně generuje metodu copyWith umožňující vytvoření kopie stavu s modifikací vybraných atributů. Tento přístup je klíčový pro reaktivní správu stavu — komponenta BLoC nikdy nemutuje existující stav, nýbrž vždy emituje novou instanci vytvořenou prostřednictvím metody copyWith, čímž je zajištěna detekce změn a překreslení příslušných widgetů [30].

Generování kódu je spouštěno příkazem nástroje build_runner, který prohledá celý projekt, identifikuje třídy opatřené příslušnými anotacemi a vygeneruje odpovídající soubory s příponou .g.dart pro JSON serializaci a .freezed.dart pro neměnné datové třídy. Vygenerované soubory jsou součástí systému správy verzí, čímž je zajištěno, že sestavení aplikace nevyžaduje opětovné spuštění generátoru.

#### 4.2.2 Správa stavu prostřednictvím vzoru BLoC

Implementace správy stavu v mobilní aplikaci důsledně dodržuje vzor BLoC popsaný v kapitole 2.2. Každá komponenta BLoC definuje tři skupiny tříd — události reprezentující uživatelské akce, stav reprezentující aktuální stav zobrazení a vlastní komponentu BLoC obsahující obslužné metody pro jednotlivé události [30].

Události jsou implementovány jako uzavřená hierarchie tříd s využitím knihovny Freezed. Například komponenta ReservationBloc definuje události LoadPanoramaScene pro načtení panoramatické scény, SelectTable pro výběr stolu uživatelem, SelectDate pro změnu data, LoadAvailableSlots pro načtení dostupných časových slotů a SubmitReservation pro odeslání rezervace. Každá událost nese pouze data nezbytná pro její zpracování — událost SelectTable obsahuje identifikátor stolu, událost SelectDate obsahuje zvolené datum. Díky generování kódu knihovnou Freezed jsou události neměnné a podporují porovnávání hodnot, což je klíčové pro správnou funkci deduplikačního mechanismu knihovny flutter_bloc, který zabraňuje opakovanému zpracování identické události.

Stav komponenty BLoC je implementován jako jediná neměnná třída se všemi atributy potřebnými pro vykreslení příslušné obrazovky. Stav komponenty ReservationBloc obsahuje panoramatickou scénu s URL panoramatu a seznamem stolů, identifikátor vybraného stolu, zvolené datum a čas, počet osob, seznam dostupných časových slotů, mapu stavů stolů pro barevné odlišení v panoramatu, příznak probíhajícího načítání, příznak úspěšného odeslání, případnou chybovou zprávu a vytvořenou rezervaci. Při každé změně je vytvořena nová instance stavu prostřednictvím metody copyWith, která zkopíruje všechny atributy a přepíše pouze modifikované hodnoty. Widget BlocBuilder naslouchá na proud stavů a při každé nové emisi překreslí příslušnou část uživatelského rozhraní.

Registrace obslužných metod pro jednotlivé události je provedena v konstruktoru komponenty BLoC prostřednictvím metody on. Následující ukázka ilustruje obsluhu události odeslání rezervace, která demonstruje typický vzor zpracování síťového požadavku:

```dart
Future<void> _onSubmitReservation(
  SubmitReservation event, Emitter<ReservationState> emit,
) async {
  emit(state.copyWith(submitting: true, submitSuccess: false,
                      submitConflict: false, submitError: null));
  try {
    await _createReservationUseCase.call(
      restaurantId: _restaurantId!,
      tableId: state.selectedTableId!,
      date: state.selectedDate,
      startTime: state.selectedStartTime!,
      partySize: state.selectedPartySize,
    );
    emit(state.copyWith(submitting: false, submitSuccess: true));
  } on DioException catch (e) {
    if (e.response?.statusCode == 409) {
      emit(state.copyWith(submitting: false, submitConflict: true));
    } else {
      emit(state.copyWith(submitting: false,
          submitError: e.response?.data?['message']?.toString()));
    }
  }
}
```

Obslužná funkce nejprve emituje stav s příznakem probíhajícího odesílání, následně prostřednictvím případu užití provede operaci a na základě výsledku emituje stav s potvrzením úspěchu nebo chybovou zprávou. Stavový kód 409 je zpracován odděleně jako indikace časového konfliktu.

#### 4.2.3 Tok dat na příkladu vytvoření rezervace

Pro ilustraci toku dat napříč vrstvami aplikace je v této kapitole popsán kompletní průběh vytvoření rezervace stolu — od uživatelské akce po aktualizaci zobrazení.

Proces je iniciován uživatelem, který v rezervačním rozhraní zvolí stůl, datum, čas a počet osob a stiskne tlačítko pro potvrzení. Tato akce vyvolá odeslání události SubmitReservation do komponenty ReservationBloc. Komponenta BLoC přijme událost a prostřednictvím registrované obsluhy spustí případ užití CreateReservationUseCase, který zapouzdřuje operaci vytvoření rezervace. Případ užití deleguje volání na implementaci repozitáře ReservationRepositoryImpl, která prostřednictvím vzdáleného datového zdroje odešle HTTP požadavek typu POST na koncový bod backendu.

Server požadavek zpracuje, provede validaci obchodních pravidel popsaných v kapitole 4.1.5 a v případě úspěchu vrátí odpověď se stavovým kódem 201 a daty vytvořené rezervace ve formátu JSON. Vzdálený datový zdroj přijme odpověď a deserializuje ji do síťového modelu ReservationResponseModel prostřednictvím vygenerované tovární metody. Repozitář následně transformuje síťový model na doménovou entitu Reservation prostřednictvím konverzní metody toEntity a vrátí výsledek případu užití.

Komponenta BLoC na základě úspěšného výsledku aktualizuje svůj stav — nastaví příznak úspěšného odeslání a uloží vytvořenou rezervaci. Widget BlocBuilder, který na daný BLoC naslouchá, detekuje změnu stavu a překreslí uživatelské rozhraní — zobrazí potvrzení úspěšné rezervace. Celý tok je jednosměrný a předvídatelný, což usnadňuje ladění a testování [30].

V případě konfliktu s existující rezervací server vrátí odpověď se stavovým kódem 409. Vzdálený datový zdroj na základě stavového kódu vyvolá specifickou výjimku, kterou repozitář propaguje do případu užití a následně do komponenty BLoC. BLoC na základě typu výjimky nastaví stav indikující konflikt a widget zobrazí uživateli srozumitelnou zprávu o obsazenosti zvoleného stolu v daném čase.

#### 4.2.4 Implementace panoramatické rezervace

Implementace interaktivního 360° panoramatického zobrazení pro výběr stolu představuje z technologického hlediska nejnáročnější součást mobilní aplikace. Řešení využívá komponentu WebView, která zobrazuje HTML stránku s knihovnou Three.js pro vykreslení panoramatické sféry s vyznačenými stoly.

Panoramatická scéna je načtena z backendu prostřednictvím koncového bodu, který vrátí URL panoramatického snímku a seznam stolů s jejich souřadnicemi v panoramatu — horizontálním úhlem yaw a vertikálním úhlem pitch. Tyto souřadnice určují pozici každého stolu na povrchu panoramatické sféry. Mobilní aplikace předá tato data do JavaScriptového kontextu prostřednictvím vyhodnocení JavaScriptového výrazu v komponentě WebView.

Komunikace mezi nativní Flutter aplikací a JavaScriptovým kódem v komponentě WebView probíhá obousměrně prostřednictvím kanálu JavaScriptového zpětného volání. Když uživatel v panoramatu klepne na značku stolu, JavaScriptový kód identifikuje vybraný stůl a prostřednictvím kanálu odešle jeho identifikátor zpět do Flutter aplikace. Aplikace na základě přijatého identifikátoru zobrazí spodní panel s informacemi o zvoleném stole, dostupnými časovými sloty a možností výběru data a počtu osob. Současně aplikace zasílá aktualizace stavů stolů — volný, obsazený nebo rezervovaný — do JavaScriptového kontextu, kde jsou značky stolů barevně odlišeny podle aktuálního stavu.

*Obrázek 7: Obrazovka rezervace stolu s panoramatickým zobrazením (vlastní zpracování)*

Barvy značek stolů v panoramatu jsou dynamicky aktualizovány na základě dat ze serveru. Aplikace po výběru data odešle dotaz na stavy stolů pro dané datum a výsledek předá do JavaScriptu, který aktualizuje barvy značek. Zelená barva indikuje volný stůl, oranžová částečně obsazený a červená plně obsazený. Tím zákazník okamžitě vidí dostupnost stolů pro zvolené datum přímo v panoramatickém zobrazení.

#### 4.2.5 Implementace mapového zobrazení

Obrazovka průzkumu restaurací implementuje interaktivní mapové zobrazení s posuvným panelem prostřednictvím knihoven google_maps_flutter a sliding_up_panel. Implementace řeší několik technických výzev spojených s výkonem a uživatelskou zkušeností.

Při každé změně viditelné oblasti mapy je nutné aktualizovat zobrazené značky restaurací. Bez omezení frekvence by rychlý posun mapy generoval desítky požadavků za sekundu, což by neúměrně zatěžovalo server. Tento problém je řešen mechanismem debounce implementovaným prostřednictvím operátoru knihovny stream_transform:

```dart
on<ViewportChanged>(_onViewportChanged,
  transformer: (events, mapper) =>
    events.debounce(const Duration(milliseconds: 200))
          .switchMap(mapper),
);

on<SearchChanged>(_onSearchChanged,
  transformer: (events, mapper) =>
    events.debounce(const Duration(milliseconds: 400))
          .switchMap(mapper),
);
```

Při změně hranic mapy je zpracování události odloženo o dvě stě milisekund od poslední změny a teprve po uplynutí tohoto intervalu je odeslán požadavek na server. Operátor switchMap zajišťuje, že pokud je spuštěn nový požadavek před dokončením předchozího, předchozí požadavek je zrušen. Obdobný mechanismus s intervalem čtyř set milisekund je aplikován na textové vyhledávání [30].

Značky restaurací na mapě jsou vizualizovány prostřednictvím vlastních ikon ve tvaru kapky, které jsou programově vygenerovány s využitím třídy Canvas jazyka Dart. Při větším oddálení mapy backend prostřednictvím algoritmu DBSCAN shlukuje blízké restaurace do klastrových značek, které zobrazují počet podniků v klastru. Při přiblížení mapy se klastry rozpadají na jednotlivé značky. Na straně klientské aplikace je implementována logika pro rozlišení individuálních a klastrových značek a jejich vizuálně odlišné vykreslení.

*Obrázek 8: Obrazovka průzkumu restaurací s mapovým zobrazením (vlastní zpracování)*

Při dotazu na restaurace aplikace současně odesílá dva paralelní požadavky — na značky pro mapové zobrazení z vlastního backendu a na seznam nejbližších restaurací pro zobrazení v posuvném panelu. Tento paralelní přístup zajišťuje, že načítání jednoho typu dat neblokuje zobrazení druhého. Výsledky obou požadavků jsou agregovány v komponentě ExploreBloc a emitovány jako jediný stav, čímž je zajištěna atomická aktualizace celého zobrazení.

#### 4.2.6 Implementace správy rezervací personálem

Obrazovka správy rezervací personálem implementuje přehled rezervací na zvolené datum s aktualizací v reálném čase prostřednictvím WebSocket spojení, jak bylo definováno v požadavcích v kapitole 1.2.2. Komponenta StaffReservationsBloc udržuje trvalé spojení s backendem a při každé změně stavu rezervace okamžitě aktualizuje zobrazení. Spojení je automaticky navázáno při vstupu na obrazovku a ukončeno při opuštění.

U každé rezervace má personál k dispozici kontextové akce závislé na aktuálním stavu — potvrzení, odmítnutí, zaznamenání příchodu hosta, dokončení návštěvy, návrh změny času nebo stolu a prodloužení doby rezervace. Veškeré akce jsou prováděny prostřednictvím příslušných koncových bodů backendu s okamžitou aktualizací zobrazení.

#### 4.2.7 Implementace průvodce konfigurací restaurace

Průvodce konfigurací restaurace provází vlastníka procesem nastavení podniku v šesti krocích — zadání základních informací, nastavení otevírací doby, konfigurace stolů, vytvoření digitálního menu, pořízení panoramatického snímku a závěrečné shrnutí s publikací. Celý proces je řízen komponentou OnboardingWizardBloc, která uchovává aktuální krok, stav validace a data zadaná v předchozích krocích.

*Obrázek 10: Průvodce konfigurací restaurace (vlastní zpracování)*

Implementačně nejnáročnějším krokem je pořízení panoramatického snímku. Obrazovka pořízení panoramatu využívá fotoaparát mobilního zařízení a gyroskopické senzory prostřednictvím knihoven camera a sensors_plus. Aplikace provede uživatele procesem pořízení osmi snímků, které pokrývají kompletní 360° horizontální rozsah interiéru restaurace. Pro každý snímek je zobrazen vizuální průvodce s vyznačením požadovaného úhlu, přičemž aktuální úhel zařízení je měřen gyroskopem. Uživatel je naveden k otočení na správný úhel a po dosažení cílové pozice pořídí fotografii. Ke každému snímku je zaznamenán zamýšlený a skutečný úhel, což umožňuje mikroslužbě pro zpracování panoramat přesně seřadit a geometricky sloučit jednotlivé fotografie.

Po pořízení všech snímků jsou fotografie nahrány na server a spuštěno asynchronní zpracování mikroslužbou. Obrazovka průvodce zobrazuje průběh zpracování a po dokončení umožňuje přechod do editoru panoramatu, kde vlastník umísťuje značky stolů do panoramatického zobrazení prostřednictvím komponenty WebView s knihovnou Three.js. Obousměrná komunikace mezi Flutter a JavaScriptem zajišťuje přenos souřadnic stolů mezi nativní aplikací a panoramatickým editorem.

#### 4.2.8 Implementace objednávkového modulu

Objednávkový modul implementuje kompletní tok od prohlížení digitálního menu přes správu košíku po odeslání objednávky. Implementace je založena na mechanismu kaskádového načítání, při kterém komponenta OrdersBloc reaguje na událost načtení kontextu automatickým spuštěním navazujících operací — po úspěšném načtení stravovacího kontextu automaticky spustí načtení menu restaurace a aktuálních objednávek uživatele. Tím je zajištěno, že při přechodu zákazníka na obrazovku objednávek jsou veškerá potřebná data načtena v jednom souvislém toku.

*Obrázek 9: Obrazovka objednávek s digitálním menu a košíkem (vlastní zpracování)*

Košík je implementován jako lokální stav komponenty BLoC bez perzistence na serveru. Zákazník může přidávat položky, upravovat množství a odebírat položky, přičemž souhrn košíku je průběžně zobrazován v plovoucím panelu ve spodní části obrazovky. Při odeslání objednávky jsou položky košíku transformovány na požadavek, který je odeslán na server společně s identifikátorem restaurace, stolu a volitelně rezervace, odvozenými ze stravovacího kontextu.

#### 4.2.9 Bezpečné ukládání dat na zařízení

Mobilní aplikace ukládá na zařízení uživatele minimální množství dat, přičemž je důsledně rozlišováno mezi citlivými a necitlivými údaji. Autentizační tokeny — přístupový, obnovovací a identifikátor zařízení — jsou ukládány prostřednictvím knihovny flutter_secure_storage, která využívá zabezpečené úložiště operačního systému. Na platformě Android je využíváno úložiště Keystore, na platformě iOS úložiště Keychain. Tím je zajištěno, že tokeny jsou chráněny šifrováním na úrovni operačního systému a nejsou přístupné jiným aplikacím [23].

Necitlivé preference uživatele, jako je zvolený jazyk aplikace a příznak zobrazení úvodního průvodce, jsou ukládány prostřednictvím knihovny SharedPreferences, která poskytuje jednoduché rozhraní pro perzistenci párů klíč-hodnota. Tyto údaje nejsou citlivé a nevyžadují šifrované úložiště.

Konfigurace prostředí, zejména základní URL adresa backendu a API klíč pro službu Google Maps, jsou načítány z konfiguračního souboru prostřednictvím knihovny flutter_dotenv. Konfigurační soubor není součástí systému správy verzí, čímž je zajištěno, že citlivé klíče nejsou vystaveny v repozitáři.

#### 4.2.10 Lokalizace mobilní aplikace

Mobilní aplikace podporuje lokalizaci do češtiny a angličtiny v souladu s nefunkčním požadavkem na použitelnost a přístupnost definovaným v kapitole 1.3.5. Implementace využívá mechanismus flutter_localizations integrovaný do frameworku Flutter, který na základě konfigurace sestavení generuje typově bezpečné přístupové třídy k lokalizačním řetězcům [23].

Lokalizační řetězce jsou definovány ve dvou souborech ve formátu ARB (Application Resource Bundle) — jednom pro češtinu jako primární jazyk a jednom pro angličtinu. Celkový počet lokalizačních klíčů dosahuje čtyř set třiceti, přičemž jsou pokryty veškeré texty uživatelského rozhraní včetně popisků formulářových polí, chybových zpráv, potvrzovacích dialogů, navigačních prvků a formátovaných řetězců s parametry. Parametrizované řetězce využívají syntaxi ICU MessageFormat, která umožňuje vkládání proměnných hodnot a pluralizaci — například správné skloňování počtu osob nebo stolů v závislosti na číslovce.

Přepínání jazyka je řízeno komponentou LocaleCubit, která uchovává aktuálně zvolenou lokalizaci a při její změně emituje nový stav. Zvolený jazyk je persistován prostřednictvím knihovny SharedPreferences, aby byl zachován mezi jednotlivými spuštěními aplikace. Při startu aplikace je načtena uložená preference, a pokud žádná není k dispozici, je použit jazyk operačního systému zařízení. Widget MaterialApp na nejvyšší úrovni stromu widgetů naslouchá na stav komponenty LocaleCubit a při změně přenastaví parametr locale, čímž je zajištěno překreslení veškerých textů v celé aplikaci bez nutnosti jejího restartu.

#### 4.2.11 Integrace služby Google Places API

Obrazovka průzkumu restaurací integruje službu Google Places API (New) pro doplnění dat z vlastní databáze o informace z platformy Google Maps [13]. Integrace je implementována prostřednictvím třídy GooglePlacesService, která komunikuje s koncovým bodem služby Google Places API na adrese https://places.googleapis.com/v1.

Služba poskytuje dvě metody vyhledávání. Metoda searchNearby vyhledává restaurace v okolí zadaných souřadnic v konfigurovaném okruhu, jehož maximální hodnota je omezena na padesát kilometrů. Metoda searchText umožňuje fulltextové vyhledávání restaurací na základě textového dotazu zadaného uživatelem. Obě metody omezují počet výsledků na dvacet záznamů a specifikují jazyk odpovědi jako češtinu, čímž jsou názvy a adresy vráceny v lokalizované podobě. Požadavky obsahují masku požadovaných polí prostřednictvím hlavičky X-Goog-FieldMask, která omezuje objem přenášených dat pouze na využívané atributy — identifikátor, název, adresu, souřadnice, hodnocení a fotografii.

Výsledky služby Google Places API jsou v komponentě ExploreBloc agregovány s výsledky z vlastního backendu. Při zobrazení značek na mapě jsou restaurace z vlastní databáze vizuálně odlišeny od restaurací nalezených prostřednictvím služby Google Places, čímž je uživateli umožněno rozlišit podniky registrované v systému CheckFood od podniků z externího zdroje. Autentizace vůči službě Google Places API je zajištěna API klíčem načítaným z konfiguračního souboru prostředí, jak je popsáno v kapitole 4.2.9.

### 4.3 Průběžná integrace

Automatizace sestavení a testování je zajištěna pracovními postupy GitHub Actions v souladu s principy průběžné integrace popsanými v kapitole 2.5.2 [28]. Pracovní postup backend.yml je spouštěn při každém začlenění změn do hlavní větve. Tento postup v prvním kroku nastaví prostředí JDK 21, ve druhém kroku provede sestavení projektu nástrojem Maven včetně spuštění kompletní sady integračních testů a ve třetím kroku ověří, že Docker obraz je úspěšně sestaven. Pracovní postup flutter-android.yml sestaví instalační balíček mobilní aplikace ve formátu APK a uloží jej jako artefakt sestavení. Pracovní postup flutter-android-release.yml je spouštěn při vytvoření značky verze a kromě sestavení automaticky publikuje instalační balíček jako vydání na platformě GitHub. Pracovní postup ci-monitor.yml sleduje výsledky ostatních pracovních postupů a v případě selhání automaticky vytváří hlášení o incidentu. Nasazení do produkčního prostředí na platformě Google Cloud je popsáno v kapitole 6.

---

## 5 Testování systému

Testování systému CheckFood je postaveno na kombinaci automatizovaných integračních testů backendu, jednotkových testů komponent BLoC mobilní aplikace a manuálního testování uživatelských scénářů. Sommerville rozlišuje několik úrovní testování — jednotkové testy ověřující správnost izolovaných komponent, integrační testy ověřující spolupráci mezi komponentami a systémové testy ověřující chování celého systému [3].

### 5.1 Testování backendu

Testování backendové aplikace je realizováno prostřednictvím integračních testů, které ověřují správné chování REST API koncových bodů včetně autentizace, autorizace, validace vstupních dat a interakce s databází. Integrační testy byly upřednostněny před čistě jednotkovými testy, protože ověřují systém jako celek od příjmu HTTP požadavku přes zpracování obchodní logiky až po uložení dat do databáze [3].

Testovací infrastruktura je postavena na frameworku JUnit 5 s využitím MockMvc a in-memory databáze H2 aktivované testovacím profilem Spring Boot [24]. Jádrem infrastruktury je abstraktní bázová třída BaseAuthIntegrationTest, ze které dědí všechny testovací třídy vyžadující autentizaci. Tato třída je opatřena anotacemi SpringBootTest pro načtení kompletního aplikačního kontextu a AutoConfigureMockMvc pro automatickou konfiguraci testovacího HTTP klienta. Bázová třída poskytuje instanci MockMvc pro odesílání HTTP požadavků a instanci ObjectMapper pro serializaci a deserializaci JSON dat.

Klíčovým přínosem bázové třídy je sada pomocných metod, které eliminují duplicitu testovacího kódu napříč třinácti testovacími třídami. Metoda pro registraci testovacího uživatele odešle požadavek POST na koncový bod registrace s generovaným e-mailem a heslem a vrátí odpověď serveru. Metoda pro přihlášení odešle požadavek POST na koncový bod přihlášení a z odpovědi extrahuje přístupový a obnovovací token. Metoda pro registraci s přihlášením kombinuje obě předchozí operace a navíc provede automatickou verifikaci e-mailu prostřednictvím přímého přístupu k repozitáři verifikačních tokenů, čímž obchází nutnost simulovat doručení e-mailu. Další pomocné metody zajišťují extrakci tokenů z JSON odpovědi, vytvoření autorizační hlavičky a registraci uživatele s rolí vlastníka. Před každým testem je databáze vyčištěna prostřednictvím metody opatřené anotací BeforeEach, která smaže záznamy ze všech tabulek v definovaném pořadí respektujícím referenční integritu, čímž je zajištěna izolace mezi jednotlivými testovacími metodami.

Backend obsahuje třináct testovacích tříd se sedmdesáti devíti testovacími metodami. Přehled je uveden v tabulce 10.

**Tabulka 10: Přehled testovacích tříd backendu**

| Testovací oblast | Počet | Příklady testovaných scénářů |
|-----------------|-------|------------------------------|
| Registrace uživatele | 5 | Úspěšná registrace, duplicitní e-mail, nevalidní vstup, registrace vlastníka |
| Přihlášení | 5 | Úspěšné přihlášení, nesprávné heslo, neexistující uživatel, neaktivovaný účet |
| Verifikace e-mailu | 6 | Úspěšná verifikace, neplatný token, expirovaný token, limit odeslání |
| Obnova tokenů | 4 | Úspěšná obnova, neplatný token, expirovaný token |
| Odhlášení | 3 | Úspěšné odhlášení, bez tokenu, neplatný token |
| Chráněné koncové body | 7 | Přístup bez tokenu, s expirovaným tokenem, s rolí USER, OWNER, ADMIN |
| OAuth přihlášení | 4 | Přihlášení Google, neplatný token, nový účet, propojení účtu |
| Hraniční případy | 3 | Souběžné požadavky, příliš dlouhý vstup, speciální znaky |
| Správa zařízení | 3 | Výpis zařízení, měkké odhlášení, tvrdé smazání |
| Autorizace správy restaurace | 7 | Přístup vlastníka, manažera, zaměstnance, zákazníka, správa zaměstnanců |
| Oblíbené restaurace | 6 | Přidání, odebrání, duplicitní přidání, výpis, neexistující restaurace |
| Rezervace | 26 | Vytvoření, konflikt časů, neplatný stůl, kapacita, otevírací doba, potvrzení, odmítnutí, check-in, dokončení, zrušení, editace, opakující se, návrhy změn, prodloužení |

Každá testovací metoda dodržuje vzor příprava–akce–ověření a důsledně pokrývá jak úspěšné scénáře, tak chybové stavy — neplatnou autentizaci, nedostatečná oprávnění, nevalidní vstupní data a konflikty s existujícími záznamy. Testovací scénáře pro modul rezervací jsou organizovány do vnořených skupin odpovídajících funkčním oblastem — vytváření, stavové přechody, opakující se rezervace a návrhy změn.

### 5.2 Testování frontendové aplikace

Testování mobilní aplikace je realizováno prostřednictvím jednotkových testů komponent BLoC s využitím knihovny bloc_test pro ověřování sekvencí emitovaných stavů a knihovny mocktail pro vytváření testovacích náhrad závislostí [30]. Aplikace obsahuje čtyři testovací soubory s dvaceti osmi testovacími metodami.

**Tabulka 11: Přehled testovacích souborů mobilní aplikace**

| Testovací soubor | Počet | Příklady testovaných scénářů |
|-----------------|-------|------------------------------|
| ReservationBloc | 10 | Načtení scény, výběr stolu, změna data, načtení slotů, odeslání, konflikt, chyba sítě |
| RestaurantDetailBloc | 6 | Načtení detailu, optimistické přepínání oblíbených, chyba načtení |
| MyRestaurantBloc | 5 | Načtení restaurace, výběr aktivní restaurace, načtení zaměstnanců, aktualizace |
| MyRestaurantVisibility | 7 | Viditelnost záložek pro vlastníka, manažera, zaměstnance, zákazníka, nepřihlášeného |

Testovací scénáře pro komponentu ReservationBloc pokrývají kompletní rezervační tok od načtení panoramatické scény přes výběr stolu a data až po odeslání rezervace. Testy viditelnosti záložek ověřují správné zobrazení navigační lišty v závislosti na roli uživatele. Identifikovanou mezerou v pokrytí je absence widgetových testů a testů datové vrstvy, jejichž rozšíření je identifikováno jako krok pro další rozvoj [29].

### 5.3 Manuální testování

Manuální testování pokrývalo pět klíčových uživatelských toků. Zákaznický tok zahrnoval registraci, verifikaci e-mailu, přihlášení, vyhledání restaurace na mapě, zobrazení detailu s menu, výběr stolu v panoramatu, vytvoření rezervace a objednávku. Tok správy restaurace zahrnoval přihlášení jako vlastník, správu zaměstnanců s oprávněními, aktualizaci informací a správu menu. Tok správy rezervací zahrnoval denní přehled s potvrzováním, odmítáním, check-inem a návrhy změn. Tok onboardingu vlastníka zahrnoval manuální registraci a šestikrokový průvodce konfigurací restaurace. Tok externího přihlášení ověřoval služby Google a Apple.

Manuální testování probíhalo ve třech prostředích, která odpovídají aplikačním profilům popsaným v kapitole 6.1. Primárním testovacím prostředím bylo lokální prostředí s Docker Compose, ve kterém běžely všechny tři služby — databáze PostGIS, mikroslužba panoramat a backendová aplikace — na společné Docker síti. Mobilní aplikace byla spouštěna v emulátoru Android Studio s konfigurací odpovídající zařízení Pixel 7 s operačním systémem Android 14 a připojována k backendu na lokální adrese. Toto prostředí umožňovalo rychlou iteraci díky podrobnému logování aktivovanému v lokálním profilu a přímému přístupu k databázi prostřednictvím nástroje pgAdmin.

Pro testování funkcionalit závislých na hardwarových senzorech — gyroskopické navigace při pořizování panoramatických snímků a ověření push notifikací — bylo využito fyzické zařízení s operačním systémem Android. Emulátor neposkytuje věrohodnou simulaci gyroskopických dat, proto bylo nezbytné ověřit přesnost měření úhlů a responzivitu vizuálního průvodce na skutečném zařízení. Testování na platformě iOS bylo realizováno prostřednictvím simulátoru Xcode na zařízení s operačním systémem macOS, přičemž bylo ověřeno správné vykreslení uživatelského rozhraní, funkčnost navigace a integrace s knihovnou flutter_secure_storage využívající úložiště Keychain.

Třetím testovacím prostředím bylo produkční prostředí na platformě Google Cloud s databází Cloud SQL, ve kterém bylo ověřováno správné chování systému při reálné síťové latenci, automatické nasazení při změně kódu a funkčnost zdravotních kontrol.

### 5.4 Souhrnné zhodnocení

Celkový rozsah automatizovaného testování zahrnuje sedmdesát devět integračních testů backendu a dvacet osm jednotkových testů mobilní aplikace, celkem sto sedm automatizovaných testů. Nejsilnější pokrytí je dosaženo v oblasti autentizačního modulu, kde je pokryto dvacet sedm scénářů zahrnujících registraci, přihlášení, verifikaci e-mailu, obnovu tokenů, odhlášení a OAuth přihlášení, a v oblasti rezervačního systému, kde dvacet šest testovacích metod pokrývá kompletní životní cyklus rezervace od vytvoření přes stavové přechody až po opakující se rezervace a návrhy změn. Testy mobilní aplikace se zaměřují na správnost stavové logiky komponent BLoC, které představují klíčový integrační bod mezi uživatelským rozhraním a datovou vrstvou.

Identifikovanou mezerou v testovacím pokrytí je absence widgetových testů mobilní aplikace, které by ověřovaly správné vykreslení uživatelského rozhraní v závislosti na stavu, a absence testů datové vrstvy, které by ověřovaly správnou serializaci a deserializaci síťových modelů. Rozšíření testovacího pokrytí o tyto oblasti je identifikováno jako krok pro další rozvoj systému. Na straně backendu chybí výkonnostní testy, které by ověřovaly splnění nefunkčního požadavku na dobu odezvy definovaného v kapitole 1.3.3 pod zátěží odpovídající reálnému provozu.

Testy jsou spouštěny automaticky při každé změně kódu prostřednictvím pracovních postupů průběžné integrace popsaných v kapitole 4.4. Pracovní postup backend.yml spouští kompletní sadu backendových testů jako součást ověření každého požadavku na začlenění změn, čímž je zajištěno, že žádná změna narušující existující funkčnost nemůže být sloučena do hlavní větve. V případě selhání jakéhokoli testu je pracovní postup přerušen a monitor průběžné integrace vytvoří hlášení o incidentu, čímž je zajištěna okamžitá viditelnost regresí.

## 6 Provozní příprava systému

Nasazení systému do produkčního prostředí a konfigurace průběžné integrace byly popsány v kapitole 4.4. Tato kapitola doplňuje podrobnosti o konfiguraci produkčních služeb, monitoringu a distribuci mobilní aplikace.

### 6.1 Konfigurace prostředí a aplikační profily

Backendová aplikace využívá mechanismus aplikačních profilů frameworku Spring Boot pro diferenciaci konfigurace mezi vývojovým, testovacím a produkčním prostředím [24]. Každý profil je definován samostatným konfiguračním souborem, který přepisuje nebo doplňuje hodnoty ze společného základního konfiguračního souboru. Aktivní profil je určen proměnnou prostředí SPRING_PROFILES_ACTIVE.

Lokální profil je aktivován při vývoji v prostředí Docker Compose a konfiguruje připojení k databázi PostGIS na lokálním portu 5433, úroveň logování DEBUG pro balíčky aplikace a SQL dotazy, platnost přístupového tokenu prodlouženou na jednu hodinu a obnovovacího tokenu na dvacet čtyři hodin pro usnadnění vývoje, lokální souborové úložiště místo vzdáleného cloudového úložiště a adresu mikroslužby panoramat na lokální Docker síti. Testovací profil je aktivován automaticky při spuštění testovací sady a konfiguruje in-memory databázi H2 s režimem kompatibility PostgreSQL, deaktivované logování SQL dotazů pro přehlednost výstupu testů a zkrácené hodnoty časových limitů pro urychlení testovacího cyklu. Produkční profil je aktivován na platformě Google Cloud a konfiguruje připojení k databázi Cloud SQL prostřednictvím JDBC s parametry z proměnných prostředí, úroveň logování INFO a standardní hodnoty platnosti tokenů.

**Backendová aplikace na platformě Google Cloud.** Backendová aplikace je nasazena jako kontejnerová služba na platformě Google Cloud. Proměnné prostředí zahrnují tajný klíč pro podepisování JWT tokenů, přístupové údaje k databázi Cloud SQL včetně adresy hostitele, názvu databáze, uživatelského jména a hesla, přístupové údaje k úložišti souborů Cloud Storage, identifikátor aktivního Spring profilu a příznak aktivace virtuálních vláken. Veškeré citlivé údaje jsou spravovány v zabezpečeném úložišti platformy a nejsou součástí zdrojového kódu.

Proces nasazení je plně automatizován. Při každém začlenění změn do hlavní větve je sestaven nový Docker obraz, spuštěn kontejner a po úspěšné zdravotní kontrole přepnut provoz na novou verzi. V případě selhání kontroly je provoz automaticky vrácen na předchozí funkční verzi, čímž je zajištěno, že chybný kód neovlivní produkční prostředí.

**Databáze a úložiště souborů.** Databáze PostgreSQL s rozšířením PostGIS je provozována na službě Cloud SQL platformy Google Cloud s automatickými denními zálohami a možností obnovy k libovolnému bodu v čase. Backendová aplikace se připojuje prostřednictvím standardního JDBC připojení s parametry z proměnných prostředí. Úložiště souborů je realizováno prostřednictvím služby Cloud Storage. V lokálním prostředí je aktivní alternativní implementace využívající lokální souborový systém. Přepínání je řízeno aplikačním profilem Spring Boot.

### 6.2 Monitoring a zdravotní kontroly

Zdravotní stav produkčního systému je monitorován na dvou úrovních. Platforma Google Cloud provádí interní kontroly voláním koncového bodu Spring Boot Actuator na cestě /actuator/health a při opakovaných selháních automaticky restartuje kontejner. Koncový bod Actuator ověřuje dostupnost databázového připojení, stav fondu připojení HikariCP a volný diskový prostor, čímž poskytuje komplexní přehled o zdraví aplikace [24].

Na druhé úrovni je implementován externí monitor v podobě pracovního postupu GitHub Actions, který je spouštěn cron výrazem v pravidelných intervalech [28]. Pracovní postup odešle HTTP požadavek GET na veřejnou URL adresu produkční služby s koncovým bodem /actuator/health a vyhodnotí stavový kód odpovědi. V případě, že zdravotní kontrola selže, tedy služba vrátí jiný stavový kód než 200 nebo neodpoví v definovaném časovém limitu, pracovní postup automaticky vytvoří hlášení o incidentu na platformě GitHub prostřednictvím rozhraní GitHub API. Hlášení obsahuje časové razítko výpadku, stavový kód odpovědi a URL služby, čímž je zajištěna okamžitá viditelnost a dokumentace problémů pro vývojový tým. Doplňkový pracovní postup ci-monitor sleduje výsledky ostatních pracovních postupů průběžné integrace a v případě selhání sestavení nebo testů rovněž vytváří hlášení, čímž je centralizována správa incidentů na platformě GitHub.

### 6.3 Distribuce mobilní aplikace

Mobilní aplikace je v aktuální fázi distribuována prostřednictvím instalačních balíčků generovaných pracovním postupem GitHub Actions. Pro platformu Android je výstupem soubor ve formátu APK přiložený k vydání na platformě GitHub a instalovatelný přímo na zařízení. Pro platformu iOS je aplikace testována prostřednictvím simulátoru v prostředí Xcode.

Publikace na distribučních platformách Google Play Store a Apple App Store je identifikována jako následný krok po dokončení diplomové práce. Publikace vyžaduje registraci vývojářského účtu, splnění obsahových a technických požadavků a úspěšné absolvování recenzního procesu. Infrastruktura pro sestavení produkčních balíčků a podepsání aplikace je v rámci pracovních postupů GitHub Actions připravena.

## Závěr

Cílem této diplomové práce bylo navrhnout, implementovat a otestovat komplexní systém pro správu rezervací a objednávek v gastronomii. Na základě analýzy existujících řešení na trhu byla identifikována mezera v podobě absence komplexního systému, který by na českém trhu kombinoval vyhledávání restaurací na mapě, interaktivní výběr stolu prostřednictvím 360° panoramatického zobrazení, správu rezervací a objednávek z jediné mobilní aplikace a administrační nástroje pro personál a vlastníky restaurací. Výsledný systém CheckFood tuto mezeru zaplňuje a stanovené cíle lze považovat za splněné.

Z hlediska rozsahu implementace systém zahrnuje backendovou aplikaci se sto deseti koncovými body REST API organizovanými do dvaceti kontrolerů, databázový model s dvaceti třemi tabulkami pokrývajícími pět doménových oblastí, mobilní aplikaci s dvanácti komponentami BLoC spravujícími stav více než dvaceti obrazovek a podpůrnou mikroslužbu pro zpracování panoramatických snímků. Automatizované testování zahrnuje sedmdesát devět integračních testů na straně backendu a dvacet osm jednotkových testů na straně mobilní aplikace, celkem tedy sto sedm automatizovaných testů.

Systém poskytuje kompletní zákaznický tok od registrace přes vyhledání restaurace na mapě, zobrazení detailu s digitálním menu, interaktivní výběr stolu v panoramatickém zobrazení a vytvoření rezervace až po zadání objednávky od stolu. Na straně provozovatele systém nabízí správu restaurace, konfiguraci zaměstnanců s jedenácti granulárními oprávněními, správu digitálního menu, pořízení a zpracování panoramatického snímku a řízení rezervací s podporou potvrzování, odmítání, check-inu, návrhů změn a prodlužování. Systém dále podporuje opakující se rezervace, přihlášení prostřednictvím služeb Google a Apple a dvoufaktorovou autentizaci.

Hlavní přínos práce spočívá v několika oblastech. Za prvé, implementace interaktivního 360° panoramatického rozhraní pro výběr stolu představuje unikátní funkci, která nemá přímou analogii v existujících řešeních na českém ani zahraničním trhu. Zákazník si může vizuálně prohlédnout interiér restaurace a vybrat si konkrétní stůl podle vlastních preferencí, což výrazně zvyšuje personalizaci rezervačního procesu. Za druhé, využití rozšíření PostGIS pro geoprostorové dotazy s adaptivním shlukováním značek na mapě zajišťuje efektivní vyhledávání restaurací v okolí uživatele i při velkém počtu podniků v databázi. Za třetí, granulární systém zaměstnaneckých oprávnění umožňuje vlastníkům restaurací přesně řídit, jaké operace smí jednotliví pracovníci provádět, což odpovídá reálným potřebám gastronomického provozu s rozdílnými úrovněmi odpovědnosti. Za čtvrté, systém je navržen s ohledem na budoucí integraci s registrem ARES a službou BankID pro automatizované ověření vlastnictví restaurace, což představuje řešení specifické pro český trh.

Z hlediska technologického řešení se ukázalo, že zvolená kombinace frameworku Flutter pro mobilní aplikaci a frameworku Spring Boot pro backend je pro daný typ systému vhodná. Flutter umožnil vývoj pro platformy Android a iOS z jediné kódové základny s dostatečným výkonem pro náročné grafické operace včetně panoramatického zobrazení. Spring Boot s jazykem Java 21 a virtuálními vlákny projektu Loom poskytl robustní a škálovatelný základ pro backendovou aplikaci s vyspělou podporou pro bezpečnost prostřednictvím modulu Spring Security. PostgreSQL s rozšířením PostGIS se osvědčil jako vhodná databáze díky nativní podpoře geoprostorových dat a plné podpoře ACID transakcí.

Při vývoji systému bylo identifikováno několik oblastí pro budoucí rozšíření. Prvním plánovaným rozšířením je integrace platební brány, pro kterou je v systému připravena infrastruktura ve formě modelu objednávek s cenami v nejmenších peněžních jednotkách. Druhým rozšířením je implementace push notifikací, pro kterou je připravena registrace tokenů služby Firebase Cloud Messaging na úrovni jednotlivých zařízení. Třetím rozšířením je modul statistik a analytických přehledů, který by provozovatelům restaurací poskytoval data o obsazenosti, tržbách a preferencích zákazníků. Čtvrtým rozšířením je přechod z periodického dotazování na technologii WebSocket pro správu rezervací personálem, který by umožnil okamžitou aktualizaci zobrazení bez patnáctisekundové prodlevy. Pátým rozšířením je nasazení distribuované vyrovnávací paměti a mechanismu rate limiting prostřednictvím technologie Redis, které by umožnilo efektivní horizontální škálování při vyšší provozní zátěži.

Výstupy práce mohou sloužit jako základ pro budoucí komerční nasazení v reálném prostředí gastronomických podniků. Systém je navržen s důrazem na udržovatelnost a rozšiřitelnost, přičemž modulární architektura a důsledné oddělení odpovědností umožňují přidávat nové funkce bez zásahu do existujícího kódu. Nasazení v cloudovém prostředí s automatizovaným procesem sestavení, testování a nasazení zajišťuje, že systém je připraven na provoz v reálných podmínkách.

---

## Seznam použité literatury

[1] SENSOR TOWER. *State of Mobile 2024*. [online]. Sensor Tower, 2024 [cit. 2025-06-15]. Dostupné z: https://sensortower.com/blog/state-of-mobile-2024

[2] DELOITTE. *The Restaurant of the Future: A Vision Evolves*. [online]. Deloitte Insights, 2021 [cit. 2025-06-15]. Dostupné z: https://www2.deloitte.com/content/dam/Deloitte/us/Documents/consumer-business/us-cb-restaurant-of-the-future.pdf

[3] SOMMERVILLE, Ian. *Software Engineering*. 10th ed. Pearson, 2016. ISBN 978-0-13-394303-0.

[4] CZECHCRUNCH. Používalo ho přes 60 tisíc lidí měsíčně. Kvůli covidu teď český katalog restaurací Restu končí. *CzechCrunch* [online]. 2021 [cit. 2025-06-15]. Dostupné z: https://cc.cz/pouzivalo-ho-pres-60-tisic-lidi-mesicne-kvuli-covidu-ted-cesky-katalog-restauraci-restu-konci/

[5] NEWMAN, Sam. *Building Microservices: Designing Fine-Grained Systems*. 2nd ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.

[6] OPENTABLE. *OpenTable*. In: Wikipedia: the free encyclopedia [online]. Wikimedia Foundation, 2024 [cit. 2025-06-15]. Dostupné z: https://en.wikipedia.org/wiki/OpenTable

[7] OPENTABLE. *Restaurant Solutions*. [online]. OpenTable, Inc., 2024 [cit. 2025-06-15]. Dostupné z: https://www.opentable.com/restaurant-solutions/

[8] THEFORK. *TheFork — A TripAdvisor Company*. [online]. TheFork, 2024 [cit. 2025-06-15]. Dostupné z: https://www.thefork.com

[9] QERKO. *Qerko — platba a objednávky v restauraci*. [online]. Qerko s.r.o., 2025 [cit. 2025-06-15]. Dostupné z: https://www.qerko.com

[10] DOTYKAČKA. *Chytrý pokladní systém pro restaurace*. [online]. Dotykačka s.r.o., 2025 [cit. 2025-06-15]. Dostupné z: https://www.dotykacka.cz

[11] GOOGLE. *Google Identity: Sign-In for Android and iOS*. [online]. Google LLC, 2024 [cit. 2025-06-15]. Dostupné z: https://developers.google.com/identity

[12] M'RAIHI, David et al. TOTP: Time-Based One-Time Password Algorithm. RFC 6238 [online]. IETF, 2011 [cit. 2025-06-15]. Dostupné z: https://datatracker.ietf.org/doc/html/rfc6238

[13] GOOGLE. *Google Maps Platform Documentation*. [online]. Google LLC, 2024 [cit. 2025-06-15]. Dostupné z: https://developers.google.com/maps/documentation

[14] OPENTABLE. *Improve no-show numbers: what restaurants need to know*. [online]. OpenTable, Inc., 2024 [cit. 2025-06-15]. Dostupné z: https://restaurant.opentable.com/resources/no-show-diners-numbers/

[15] SANDHU, Ravi S. et al. Role-Based Access Control Models. *IEEE Computer*, 1996, vol. 29, no. 2, s. 38–47. ISSN 0018-9162.

[16] OWASP FOUNDATION. *OWASP Top 10:2021*. [online]. OWASP, 2021 [cit. 2025-06-15]. Dostupné z: https://owasp.org/Top10/2021/

[17] EVROPSKÝ PARLAMENT A RADA EU. Nařízení (EU) 2016/679 o ochraně fyzických osob v souvislosti se zpracováním osobních údajů a o volném pohybu těchto údajů (GDPR). *Úřední věstník Evropské unie* [online]. 2016 [cit. 2025-06-15]. Dostupné z: https://eur-lex.europa.eu/eli/reg/2016/679/oj

[18] NIELSEN, Jakob. *10 Usability Heuristics for User Interface Design*. [online]. Nielsen Norman Group, 1994, aktualizováno 2024 [cit. 2025-06-15]. Dostupné z: https://www.nngroup.com/articles/ten-usability-heuristics/

[19] GOOGLE CLOUD. *Cloud Run Documentation*. [online]. Google LLC, 2025 [cit. 2025-06-15]. Dostupné z: https://cloud.google.com/run/docs

[20] GOOGLE CLOUD. *Cloud SQL for PostgreSQL Documentation*. [online]. Google LLC, 2025 [cit. 2025-06-15]. Dostupné z: https://cloud.google.com/sql/docs/postgres

[21] STACK OVERFLOW. *2024 Stack Overflow Developer Survey — Technology*. [online]. Stack Overflow, 2024 [cit. 2025-06-15]. Dostupné z: https://survey.stackoverflow.co/2024/technology

[22] META PLATFORMS. *React Native — Learn once, write anywhere*. [online]. Meta Platforms, Inc., 2024 [cit. 2025-06-15]. Dostupné z: https://reactnative.dev

[23] GOOGLE. *Flutter Documentation*. [online]. Google LLC, 2025 [cit. 2025-06-15]. Dostupné z: https://docs.flutter.dev

[24] REDDY, K. Siva Prasad a UPADHYAYULA, Sai. *Beginning Spring Boot 3: Build Dynamic Cloud-Native Java Applications and Microservices*. 2nd ed. Apress, 2023. ISBN 978-1-4842-8791-0.

[25] POSTGRESQL GLOBAL DEVELOPMENT GROUP. *PostgreSQL Documentation*. [online]. PostgreSQL Global Development Group, 2024 [cit. 2025-06-15]. Dostupné z: https://www.postgresql.org/docs/

[26] ENTERPRISEDB. *2024 Stack Overflow survey names Postgres the developers' favorite database for the second year in a row*. [online]. EDB, 2024 [cit. 2025-06-15]. Dostupné z: https://www.enterprisedb.com/blog/postgres-developers-favorite-database-2024

[27] POSTGIS PROJECT. *PostGIS — Spatial and Geographic Objects for PostgreSQL*. [online]. OSGeo, 2024 [cit. 2025-06-15]. Dostupné z: https://postgis.net

[28] DOCKER. *Docker Documentation*. [online]. Docker Inc., 2025 [cit. 2025-06-15]. Dostupné z: https://docs.docker.com

[29] MARTIN, Robert C. *Clean Architecture: A Craftsman's Guide to Software Structure and Design*. Prentice Hall, 2017. ISBN 978-0-13-449416-6.

[30] ANGELOV, Felix. *flutter_bloc — Flutter Widgets that make it easy to implement the BLoC design pattern*. [online]. Pub.dev, 2024 [cit. 2025-06-15]. Dostupné z: https://pub.dev/packages/flutter_bloc

[31] CRUNCHY DATA. *PostGIS Clustering with DBSCAN*. [online]. Crunchy Data, 2024 [cit. 2025-06-15]. Dostupné z: https://www.crunchydata.com/blog/postgis-clustering-with-dbscan

[32] WOOLDRIDGE, Brett. *HikariCP — A solid, high-performance, JDBC connection pool*. [online]. GitHub, 2024 [cit. 2025-06-15]. Dostupné z: https://github.com/brettwooldridge/HikariCP

[33] COSMINA, Iuliana et al. *Pro Spring 6: An In-Depth Guide to the Spring Framework*. 6th ed. Apress, 2023. ISBN 978-1-4842-8639-5.

[34] REDDY, K. Siva Prasad a UPADHYAYULA, Sai. *Beginning Spring Boot 3: Build Dynamic Cloud-Native Java Applications and Microservices*. 2nd ed. Apress, 2023. ISBN 978-1-4842-8791-0.

[35] DEINUM, Marten, RUBIO, Daniel a LONG, Josh. *Spring 6 Recipes: A Problem-Solution Approach*. 5th ed. Apress, 2023. ISBN 978-1-4842-8648-7.

[36] ZAMMETTI, Frank. *Practical Flutter: Improve your Mobile Development with Google's Latest Open-Source SDK*. Apress, 2019. ISBN 978-1-4842-4971-0.

[37] SPATH, Peter. *Pro Android with Kotlin: Developing Modern Mobile Apps*. 2nd ed. Apress, 2022. ISBN 978-1-4842-8744-6.

[38] CHACON, Scott a STRAUB, Ben. *Pro Git*. 2nd ed. Apress, 2014. ISBN 978-1-4842-0076-6. Dostupné z: https://git-scm.com/book

[39] NODE.JS FOUNDATION. *Node.js Documentation*. [online]. OpenJS Foundation, 2025 [cit. 2025-06-15]. Dostupné z: https://nodejs.org/docs

## Seznam zkratek a pojmů

| Zkratka / Pojem | Význam |
|-----------------|--------|
| AOT | Ahead-Of-Time — režim kompilace generující nativní strojový kód před spuštěním |
| AOP | Aspect-Oriented Programming — aspektově orientované programování |
| API | Application Programming Interface — rozhraní pro programování aplikací |
| BLoC | Business Logic Component — návrhový vzor oddělující obchodní logiku od UI |
| Bounding box | Ohraničující rámec — obdélníková oblast pro prostorové indexování |
| Bridge | Komunikační most — vrstva překládající volání mezi platformami |
| Callback | Zpětné volání — mechanismus asynchronní komunikace mezi komponentami |
| Cross-cutting concerns | Průřezové záležitosti — funkce zasahující do více vrstev (logování, audit) |
| DI | Dependency Injection — vkládání závislostí |
| DTO | Data Transfer Object — datový přenosový objekt |
| Event loop | Smyčka událostí — mechanismus neblokujícího zpracování v Node.js |
| GiST | Generalized Search Tree — stromová indexová struktura pro prostorová data |
| Hot Reload | Mechanismus okamžitého promítnutí změn kódu bez restartu aplikace |
| IoC | Inversion of Control — inverze řízení |
| JIT | Just-In-Time — režim kompilace za běhu aplikace |
| JPA | Jakarta Persistence API — specifikace pro Object-Relational Mapping v Javě |
| JWT | JSON Web Token — kompaktní token pro bezstavovou autentizaci |
| ORM | Object-Relational Mapping — objektově-relační mapování |
| RBAC | Role-Based Access Control — řízení přístupu na základě rolí |
| Rate limiting | Omezení četnosti požadavků v daném časovém okně |
| REST | Representational State Transfer — architektonický styl pro síťové aplikace |
| Repository pattern | Návrhový vzor zapouzdřující přístup k datovým zdrojům za abstraktní rozhraní |
| Service Locator | Lokátor služeb — centrální registr instancí pro vkládání závislostí |
| SRID | Spatial Reference Identifier — identifikátor souřadnicového systému |
| TOTP | Time-Based One-Time Password — jednorázový časový kód pro dvoufaktorovou autentizaci |
| Use Case pattern | Návrhový vzor zapouzdřující jednu operaci obchodní logiky |

