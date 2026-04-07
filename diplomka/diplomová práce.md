



## Univerzita Hradec Králové
Fakulta informatiky a managementu
Katedra informatiky a kvantitativních metod
Vývoj aplikace pro správu rezervací
a objednávek v gastronomii
Diplomová práce
## Autor: Bc. Rostislav Jirák
Studijní obor: Aplikovaná informatika
Vedoucí práce: doc. Mgr. Tomáš Kozel, Ph.D.
Hradec Králové srpen 2025



Prohlášení o autorství práce
Prohlašuji,  že  jsem diplomovou práci  na  téma Vývoj  aplikace  pro  správu  rezervací  a
objednávek v gastronomii vypracoval samostatně pod vedením vedoucího diplomové práce,
na  základě  vlastních  zjištění  a  pouze  s použitím  odborné  literatury  a  jiných  informačních
zdrojů uvedených v seznamu.
Jako autor této diplomové práce dále prohlašuji, že v souvislosti s jejím vytvořením, jsem
neporušil  autorská  práva  a  jsem  si  plně  vědom následků  porušení  ustanovení  §11   a
následujících autorského zákona č. 121/2000 Sb.


V Hradci Králové dne podpis



## Poděkování
Děkuji vedoucímu diplomové práce panu doc. Mgr. Tomášovi Kozlovi,  Ph.D. za  pomoc  a
cenné rady při zpracování bakalářské práce.




## Anotace
V bakalářské práci na téma „Teorie her v ekonomii“ je snaha představit základní typy her jako
například  hra  s konstantním  součtem,  nekonstantním  součtem,  kooperativní  hry  a  další.  U
každé  kapitoly  je  uveden  popis  hry  s definicemi,  algoritmus  pro  vyřešení  hry a popsaný
výpočet praktického příkladu. V praktické části je popis příkladů z teoretické části s řešením
pomocí vytvořených funkcí v programu MATLAB.
## Annotation
In  the  bachelor  thesis  on  "Game  Theory  in  Economics"  an  attempt  is  made  to  introduce  the
basic types of games such as constant sum game, non-constant sum game, cooperative games
and others. For each chapter, a description of the game with definitions and the calculation of
a practical example is described. In the practical part, there is a description of examples from
the theoretical part with solutions using creating MATLAB functions.




## OBSAH
Úvod ................................................................................................................................................................ 1
Použité zdroje ............................................................................................. Chyba! Záložka není definována.
Teoretická část ................................................................................................................................................ 3
- Analýza problému .................................................................................................................................. 4
1.1. Současné přístupy a existující řešení .................................................................................................. 4
1.2. Funkční požadavky na systém ........................................................................................................... 4
1.2 Funkční požadavky na systém (rozšířený úvod) .......................................Chyba! Záložka není definována.
Použité zdroje ............................................................................................. Chyba! Záložka není definována.
1.2.1 Rezervace stolů .................................................................................. Chyba! Záložka není definována.
1.2.1 Rezervace stolů .................................................................................. Chyba! Záložka není definována.
1.2.2 Objednávky jídel a nápojů .................................................................................................................. 11
Použité zdroje ............................................................................................................................................. 12
1.2.3 Online platby ..................................................................................................................................... 13
Použité zdroje ............................................................................................................................................. 14
1.2.4 Správa rezervací a objednávek ........................................................................................................... 14
Použité zdroje ............................................................................................................................................. 16
1.2.5 Statistiky a reporty ............................................................................................................................. 16
Použité zdroje ............................................................................................................................................. 17
1.2.7 Notifikace a komunikace..................................................................................................................... 18
Použité zdroje ............................................................................................................................................. 19
1.3. Nefunkční požadavky na systém ...................................................................................................... 19
Použité zdroje ............................................................................................. Chyba! Záložka není definována.
1.3.1 Škálovatelnost .................................................................................................................................... 19
Použité zdroje ............................................................................................. Chyba! Záložka není definována.
1.3.2 Zabezpečení ....................................................................................................................................... 20



Použité zdroje ............................................................................................. Chyba! Záložka není definována.
1.3.3 Výkon a odezva databáze .................................................................................................................... 21
Použité zdroje ............................................................................................. Chyba! Záložka není definována.
1.3.4 Spolehlivost a dostupnost ................................................................................................................... 22
1.3.5 Použitelnost a přístupnost .................................................................................................................. 24
1.3.6 Udržovatelnost a rozšiřitelnost ........................................................................................................... 25
Použité zdroje ............................................................................................. Chyba! Záložka není definována.
1.4. Výběr technologií a jejich srovnání.................................................................................................. 28
1.4.1. Proč Flutter pro frontend? .............................................................Chyba! Záložka není definována.
1.4.2. Proč Spring Boot pro backend? .....................................................Chyba! Záložka není definována.
1.4.3. Proč Google Cloud a PostgreSQL pro infrastrukturu?.................Chyba! Záložka není definována.
- Návrh architektury systému ................................................................................................................. 35
2.1. Přehled architektury ........................................................................................................................ 35
2.1.1. Vrstvová architektura: frontend, backend, databáze. ................................................................. 43
2.2. Detailní popis komponent................................................................................................................. 43
2.2.1. Frontend: uživatelské rozhraní pro zákazníky a administrátory. ............................................... 43
2.2.2. Backend: logika systému, zpracování dat a API. ......................................................................... 43
2.2.3. Databáze: relační model pro správu dat. ..................................................................................... 43
- Návrh databáze..................................................................................................................................... 43
3.1. Struktura databázového modelu ...................................................................................................... 43
3.1.1. Entity: Uživatelé, Restaurace, Rezervace, Objednávky, Menu. .................................................. 43
3.1.2. Vztahy mezi entitami. ................................................................................................................... 43



3.2. Optimalizace pro velké množství dat ............................................................................................... 43
3.2.1. Indexy, particionování tabulek, caching. ..................................................................................... 43
3.3. Implementace v PostgreSQL ............................................................................................................ 43
Praktická část .................................................................................................Chyba! Záložka není definována.
- Implementace systému ...........................................................................Chyba! Záložka není definována.
4.1. Backend (Spring Boot) ..................................................................................................................... 44
4.1.1. Nastavení projektu a napojení na PostgreSQL............................................................................ 45
4.1.2. Implementace REST API pro funkce (registrace, rezervace, objednávky). ................................ 49
4.1.3. Zabezpečení API pomocí JWT a role-based access control. ........................................................ 52
4.2. Frontend (Flutter) ............................................................................................................................ 52
4.2.1. Vytvoření uživatelského rozhraní pro zákazníky a administrátory. ........................................... 52
4.2.2. Klíčové obrazovky (rezervace, objednávky, historie, statistiky). ................................................ 52
4.2.3. Komunikace s backendem přes REST API. ................................................................................ 52
4.3. Nasazení systému na Google Cloud....................................................Chyba! Záložka není definována.
4.3.1. Nasazení backendu na Google App Engine nebo Cloud Run. .......Chyba! Záložka není definována.
4.3.2. Propojení s databází Google Cloud SQL. ......................................Chyba! Záložka není definována.
4.3.3. Zajištění zabezpečeného připojení a škálovatelnosti. ....................Chyba! Záložka není definována.
- Testování systému................................................................................................................................. 55
5.1. Testování backendu .......................................................................................................................... 55
5.1.1. Unit testy API endpointů. ............................................................................................................. 55



5.1.2. Zátěžové testy pomocí nástrojů jako JMeter nebo k6. ................................................................ 55
5.2. Testování frontendu ......................................................................................................................... 55
5.2.1. Funkční testy (přihlášení, rezervace, platby). .............................................................................. 55
5.2.2. Responsivita na různých zařízeních. ............................................................................................ 55
5.3. Testování integrace........................................................................................................................... 55
5.3.1. Ověření komunikace mezi frontendem, backendem a databází. ................................................. 55
- Nasazení systému .................................................................................................................................. 55
6.1. Zaregistrování domény .................................................................................................................... 55
6.1.1. Výběr vhodného názvu a registrace přes poskytovatele (např. Google Domains, Wedos). ........ 55
6.2. Publikace aplikace na Google Play Store a Apple App Store .......................................................... 83
- Vyhodnocení výsledků .......................................................................................................................... 83
7.1. Splnění požadavků ........................................................................................................................... 83
7.2. Výkonnost systému na základě testů ................................................................................................ 83
Literatura ...................................................................................................................................................... 84
Seznam obrázků ............................................................................................................................................ 86
Seznam tabulek ............................................................................................................................................. 86

## 1

## Úvod
Digitalizace a rozvoj moderních informačních technologií významně proměňují způsob,
jakým lidé komunikují, nakupují i tráví svůj volný čas. Tento trend se v posledních
letech výrazně projevil také v oblasti gastronomie, která byla dlouhou dobu založena
především na osobním kontaktu mezi zákazníkem a provozovatelem. Nástup chytrých
telefonů, mobilních aplikací a rozšíření internetového připojení do každodenního života
způsobil, že zákazníci dnes očekávají možnost rychlého a pohodlného objednávání jídel,
rezervací stolů či plateb prostřednictvím digitálních platforem [1].
Význam digitalizace v gastronomii umocnila pandemie onemocnění COVID-19, která
urychlila přechod k online prostředí. V období uzavřených restaurací a omezeného
provozu se stalo klíčovým faktorem přežití možnost přijímat objednávky na dálku a
nabízet zákazníkům služby prostřednictvím mobilních aplikací nebo webových portálů.
I po ukončení pandemických omezení zůstala zákaznická očekávání trvale na vyšší
úrovni — dnes již není neobvyklé, že zákazníci preferují podniky, kde mohou provést
rezervaci stolu přímo z mobilního telefonu, zaplatit prostřednictvím QR kódu a získat
přístup k digitálnímu menu [2].
Správa rezervací a objednávek přitom představuje jednu z nejnáročnějších oblastí
gastronomického provozu. Nedostatečná koordinace mezi přijímáním rezervací,
zpracováním objednávek a obsluhou zákazníků vede k chybám, zbytečným prodlevám a
v konečném důsledku ke snížení spokojenosti zákazníků i celkové efektivity podniku.
Moderní softwarová řešení nabízejí prostředky, jak tyto procesy automatizovat,
centralizovat a učinit transparentnějšími jak pro provozovatele, tak pro samotné
zákazníky [3].
Cílem této diplomové práce je navrhnout, implementovat a otestovat komplexní systém
pro správu rezervací a objednávek v gastronomii. Výsledná aplikace má přinést
zákazníkům komfortní prostředí pro provádění rezervací a objednávek a současně
poskytnout restauratérům efektivní nástroje pro řízení provozu, sběr dat a
vyhodnocování výsledků. Součástí cíle je nejen vytvoření funkčního prototypu, ale také
ověření jeho spolehlivosti prostřednictvím testování, a to jak z pohledu zákazníka, tak z
pohledu správce podniku [4].
Metodika práce vychází ze studia odborné literatury a analýzy požadavků na moderní
systémy pro správu gastronomického provozu. Na základě této analýzy jsou definovány
funkční a nefunkční požadavky na vyvíjený systém a zvoleny vhodné technologie pro
jeho realizaci. Funkčnost a spolehlivost výsledného systému je následně ověřena
prostřednictvím funkčních, integračních a zátěžových testů [5].
Struktura práce je rozdělena do dvou hlavních částí. Teoretická část se zaměřuje na
analýzu problému, přehled existujících řešení a specifikaci požadavků na systém.
Součástí teoretické části je rovněž srovnání dostupných technologií a zdůvodnění jejich
výběru, návrh architektury systému a návrh databázového modelu. Praktická část
popisuje samotnou implementaci systému, jeho nasazení do produkčního prostředí a

## 2

výsledky testování. V závěru práce je zhodnoceno, do jaké míry byly splněny stanovené
cíle a jaké jsou možnosti dalšího rozvoje systému [6].
Téma vývoje aplikace pro správu rezervací a objednávek v gastronomii je aktuální a
přínosné nejen z pohledu akademického, ale i praktického. Výstupy práce mohou
sloužit jako základ pro budoucí rozšíření a nasazení v reálném prostředí
gastronomických podniků, které se snaží držet krok s rychlým vývojem digitálních
technologií a zároveň poskytovat svým zákazníkům služby na vysoké úrovni [7].

Použité zdroje
[1] STATISTA. Number of mobile app downloads worldwide from 2016 to 2023.
[online]. Statista, 2023 [cit. 2025-10-12]. Dostupné z:
https://www.statista.com/statistics/271644/worldwide-free-and-paid-mobile-app-store-
downloads/
[2] DELOITTE. The Restaurant of the Future: A Vision Evolves. [online]. Deloitte
Insights, 2021 [cit. 2025-10-12]. Dostupné z:
https://www2.deloitte.com/us/en/insights/industry/retail-distribution/restaurant-of-the-
future.html
[3] WIRTZ, Jochen et al. Service management in the digital age: Transforming
customer experience. Journal of Service Management, 2019.
[4] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[5] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[6] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[7] BAILEY, Thomas a BIESSEK, Alessandro. Flutter for Beginners. 2nd ed. Packt
Publishing, 2021. ISBN 978-1-80056-599-2.


## 3

Teoretická část

## 4

- Analýza problému
1.1. Současné přístupy a existující řešení
Digitální rezervační systémy se v gastronomii staly standardem na mnoha zahraničních
trzích. Zákazníkům poskytují pohodlný způsob, jak si vybrat podnik, provést rezervaci a
někdy i zaplatit online, zatímco restauracím umožňují efektivněji řídit obsazenost a
získávat data o návštěvnících. Mezi nejznámější globální platformy patří OpenTable
nebo TheFork, které fungují zejména na americkém a západoevropském trhu. Tyto
aplikace nabízejí správu rezervací, integraci s pokladními systémy a různé
marketingové nástroje. Jejich výhodou je masová uživatelská základna, nevýhodou však
vysoké provize a nízká míra přizpůsobení potřebám jednotlivých podniků [1].
V České republice je situace odlišná. V minulosti fungovala služba Restu.cz, která
kombinovala rezervační systém s průvodcem po restauracích. Restu však ukončilo svůj
provoz ke konci roku 2021 v důsledku pandemie COVID-19 a souvisejících provozních
ztrát [2]. Dalším projektem na českém trhu je Querko, které se specializuje na digitální
menu, objednávky a platby přes QR kód. Querko sice zrychluje obsluhu a snižuje
provozní náklady, avšak neřeší klasické rezervace stolů ani vizualizaci obsazenosti [3].
Z uvedeného vyplývá, že v současné době na českém trhu neexistuje komplexní řešení,
které by umožňovalo zákazníkům online nahlédnout do restaurace, zvolit si konkrétní
stůl a okamžitě zjistit jeho dostupnost. Stávající aplikace řeší buď pouze dílčí funkce,
jako jsou objednávky nebo obecné rezervace, nebo český trh vůbec nepokrývají. To
představuje zásadní mezeru na trhu a zároveň příležitost pro vývoj systému, který
dokáže spojit výhody existujících řešení s přidanou hodnotou v podobě interaktivního
výběru stolu v reálném čase [4].
Použité zdroje
[1] OPENTABLE. OpenTable for Restaurants: Features and Benefits. [online].
OpenTable, Inc., 2024 [cit. 2025-10-12]. Dostupné z: https://restaurant.opentable.com/
[2] RESTAURACE.CZ. Restu.cz ukončuje provoz. [online]. 2021 [cit. 2025-10-12].
Dostupné z: https://www.restu.cz
[3] QUERKO. Querko – digitální menu a objednávky přes QR kód. [online]. Querko
s.r.o., 2024 [cit. 2025-10-12]. Dostupné z: https://www.querko.cz
[4] KAPLAN, Andreas a HAENLEIN, Michael. Rethinking restaurant platforms: The
role of digital intermediaries in gastronomy. Journal of Business Research, 2020.

## 5

1.2. Funkční požadavky na systém
Funkční požadavky představují soubor vlastností, které má systém poskytovat
uživatelům z pohledu jeho funkcionality. Jinými slovy popisují, co má aplikace umět a
jaké služby má zajišťovat. V kontextu informačních systémů v gastronomii zahrnují
funkční požadavky například vyhledávání restaurací, prohlížení jejich nabídky,
rezervace stolů, správu rezervací nebo zasílání notifikací zákazníkům. Tyto požadavky
tvoří základní rámec pro následný návrh architektury systému, databázového modelu i
uživatelského rozhraní [1].
Specifikace funkčních požadavků se obvykle provádí již v rané fázi vývoje systému.
Jejich správné vymezení je klíčové, neboť určuje, jaké problémy má aplikace řešit a
jakým způsobem budou uživatelé se systémem interagovat. Podle Sommervilla
„funkční požadavky popisují služby, které by měl systém poskytovat, reakce na určité
vstupy a chování v konkrétních situacích" [1, s. 112].
Z pohledu metodiky softwarového inženýrství se funkční požadavky zjišťují
prostřednictvím analýzy potřeb uživatelů, studia existujících řešení a konzultací s
odborníky z praxe. V gastronomii to znamená kombinaci dvou perspektiv — zákazníků,
kteří očekávají jednoduché, rychlé a spolehlivé služby, a provozovatelů s personálem,
kteří potřebují efektivní nástroj pro správu rezervací a provozu restaurace.
Funkční požadavky tvoří základní stavební kámen celé aplikace a jsou nezbytné nejen
pro samotný návrh a implementaci, ale také pro následné testování. Každý požadavek
musí být ověřitelný a měřitelný, aby bylo možné objektivně posoudit, zda byl v
implementaci splněn [1].
Navrhovaný systém rozlišuje tři základní role uživatelů s odlišnou úrovní přístupu k
funkcím aplikace. Zákazník využívá aplikaci k vyhledávání restaurací, prohlížení jejich
nabídky a správě vlastních rezervací. Zaměstnanec restaurace má přístup k provozním
funkcím, jako je správa rezervací nebo rozmístění stolů. Manažer disponuje stejnými
oprávněními jako zaměstnanec a navíc může spravovat uživatelská práva ostatních
pracovníků. Toto rozdělení vychází z principu minimálního oprávnění, který zajišťuje,
že každý uživatel má přístup pouze k těm funkcím, jež jsou nezbytné pro výkon jeho
role [2].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.

## 6


1.2.1 Funkce zákazníka
Prvním krokem v interakci zákazníka se systémem je vyhledání a výběr vhodného
gastronomického podniku. Aby byla tato fáze co nejpohodlnější, musí aplikace nabízet
přehledné zobrazení dostupných restaurací včetně jejich umístění na mapě. Integrace
mapových služeb se v mobilních aplikacích stala standardem — zákazníci jsou zvyklí
vyhledávat podniky v okolí na základě své aktuální polohy, hodnocení ostatních
uživatelů nebo konkrétních filtrů, jako je typ kuchyně, cenová kategorie či aktuální
otevírací doba [1].
Základem tohoto modulu je zobrazení restaurací na interaktivní mapě, která zákazníkovi
umožní rychlou orientaci v okolí. Každý podnik je na mapě reprezentován mapovým
špendlíkem, po jehož výběru se zobrazí základní informace — název restaurace, adresa,
hodnocení a aktuální dostupnost rezervace. Tento přístup je uživatelsky intuitivní a
odpovídá vzorcům chování, na které jsou zákazníci zvyklí z aplikací jako Google Maps
nebo Mapy.cz [2].
Vedle mapového zobrazení systém podporuje také vyhledávání podle názvu podniku
nebo lokality a filtrování výsledků podle relevantních kritérií. Mezi nejdůležitější filtry
patří typ kuchyně, cenová kategorie, kapacita restaurace a aktuální dostupnost volných
stolů. Tato kombinace mapového zobrazení a filtrování výrazně zkracuje čas potřebný k
nalezení vhodného podniku a zvyšuje celkovou uživatelskou zkušenost [3].
Pro implementaci mapové funkcionality je vhodné využít Google Maps Platform, která
nabízí dobře zdokumentované API pro integraci do mobilních i webových aplikací.
Tato služba poskytuje nejen mapové podklady, ale také geolokační služby, které
umožňují automatické určení polohy zákazníka a zobrazení restaurací v jeho
bezprostředním okolí [4].
Po výběru konkrétní restaurace přejde zákazník na její detail, který poskytuje veškeré
informace potřebné k rozhodnutí o návštěvě. Detail restaurace zahrnuje adresu a
otevírací dobu, fotografie interiéru a exteriéru, stručný popis podniku a digitální menu s
aktuální nabídkou jídel a nápojů. Menu je strukturováno do kategorií a u každé položky
jsou uvedeny název, popis, cena a případně fotografie pokrmu. Zákazník má také
možnost filtrovat nabídku podle dietních preferencí, například vegetariánských nebo
bezlepkových možností. Kompletní a přehledný profil restaurace umožňuje zákazníkovi
učinit informované rozhodnutí ještě před samotnou rezervací [3].
Klíčovou funkcí aplikace je rezervace stolu. Po rozhodnutí navštívit restauraci zákazník
přejde do rezervačního rozhraní, které zobrazuje interaktivní 360° pohled na interiér
podniku s vyznačenými stoly. Každý stůl je barevně označen podle svého aktuálního
stavu — volný, obsazený nebo rezervovaný — takže zákazník má okamžitý přehled o
dostupnosti. Na základě tohoto zobrazení si zákazník zvolí konkrétní stůl podle svých
preferencí, například u okna nebo v klidné části restaurace, a specifikuje datum, čas a
počet osob. Po potvrzení rezervace systém okamžitě odešle zákazníkovi notifikaci s
potvrzením a shrnutím rezervace. Tento způsob rezervace přináší vyšší míru

## 7

personalizace oproti běžným systémům pracujícím pouze s časovými sloty, a
představuje tak klíčovou přidanou hodnotu navrhovaného systému [1].
Zákazník má v aplikaci k dispozici také přehled svých rezervací a historii předchozích
návštěv. V sekci správy rezervací může zobrazit detail každé aktivní rezervace, provést
její změnu nebo ji zrušit. Historie návštěv pak zákazníkovi umožňuje snadno se vrátit
do oblíbeného podniku nebo zkontrolovat podrobnosti minulé rezervace. Tato funkce
zvyšuje celkový komfort používání aplikace a podporuje opakované využívání systému
## [3].
Nedílnou součástí aplikace je také uživatelský profil, kde zákazník spravuje své osobní
údaje, jako jsou jméno, e-mailová adresa a telefonní číslo. V nastavení profilu má
uživatel možnost upravit preference pro zasílání notifikací — například zvolit, zda chce
dostávat připomenutí rezervací formou push notifikací, e-mailem nebo SMS. Systém
automaticky zasílá notifikace při potvrzení rezervace, před plánovanou návštěvou a v
případě jakékoli změny rezervace ze strany restaurace. Tímto způsobem je zákazník
vždy informován o aktuálním stavu své rezervace bez nutnosti aktivně kontrolovat
aplikaci [5].

[1] DELOITTE. The Restaurant of the Future: A Vision Evolves. [online]. Deloitte
Insights, 2021 [cit. 2025-10-12]. Dostupné z:
https://www2.deloitte.com/us/en/insights/industry/retail-distribution/restaurant-of-the-
future.html
[2] GOOGLE. Google Maps Platform Documentation. [online]. Google LLC, 2024 [cit.
2025-10-12]. Dostupné z: https://developers.google.com/maps/documentation
[3] NIELSEN, Jakob. Usability Engineering. Morgan Kaufmann, 1994. ISBN 978-0-
## 12-518406-9.
[4] GOOGLE. Maps JavaScript API. [online]. Google LLC, 2024 [cit. 2025-10-12].
Dostupné z: https://developers.google.com/maps/documentation/javascript
[5] STATISTA. Share of restaurants reporting reduced no-shows thanks to digital
booking reminders. [online]. Statista, 2022 [cit. 2025-10-12]. Dostupné z:
https://www.statista.com
1.2.2 Funkce manažera a zaměstnance
Zaměstnanci a manažeři restaurace přistupují k systému prostřednictvím
administračního rozhraní, které je navrženo pro potřeby každodenního provozu
podniku. Základní funkcí tohoto rozhraní je správa rezervací — personál má k dispozici
přehledný kalendář rezervací s možností zobrazení obsazenosti stolů v reálném čase. U
každé rezervace jsou viditelné klíčové informace, jako je jméno zákazníka, datum a čas
návštěvy, počet osob a případné speciální požadavky. Zaměstnanec může rezervaci

## 8

potvrdit, upravit nebo zrušit, a to například v situaci, kdy zákazník kontaktuje restauraci
přímo telefonicky nebo osobně. Veškeré změny se okamžitě projeví v systému a
zákazník je o nich automaticky informován prostřednictvím notifikace [1].
Další důležitou funkcí je správa rozmístění stolů. Manažer i zaměstnanec mají možnost
upravovat půdorys restaurace přímo v aplikaci — přesouvat stoly, měnit jejich kapacitu
nebo je seskupovat pro skupinové rezervace. Tato flexibilita je důležitá zejména v
situacích, kdy restaurace mění své uspořádání například při pořádání soukromých akcí
nebo sezónních změnách interiéru. Aktualizované rozmístění stolů se okamžitě
promítne do rezervačního rozhraní dostupného zákazníkům, čímž je zajištěna
konzistence dat napříč celým systémem [2].
Personál má rovněž přístup ke správě informací o restauraci. To zahrnuje aktualizaci
otevírací doby, úpravu popisu podniku, správu fotografií a především správu digitálního
menu. Možnost snadno a rychle aktualizovat nabídku jídel a nápojů, upravovat ceny
nebo označovat dočasně nedostupné položky je pro každodenní provoz restaurace
nezbytná. Veškeré změny v menu se okamžitě zobrazí zákazníkům v detailu restaurace,
čímž je zajištěno, že zákazník má vždy přístup k aktuálním informacím [3].
Rozdíl mezi rolí zaměstnance a manažera spočívá výhradně ve správě uživatelských
práv. Zatímco zaměstnanec disponuje všemi výše popsanými funkcemi, manažer má
navíc možnost přidělovat a odebírat přístupová oprávnění ostatním pracovníkům
restaurace. Manažer může vytvářet nové účty pro zaměstnance, nastavovat jejich úroveň
přístupu a v případě potřeby jejich přístup deaktivovat. Toto rozdělení odpovídá běžné
hierarchii v gastronomickém provozu a zajišťuje, že citlivá nastavení systému jsou
dostupná pouze oprávněným osobám [4].

Použité zdroje
[1] NIELSEN, Jakob. Usability Engineering. Morgan Kaufmann, 1994. ISBN 978-0-
## 12-518406-9.
[2] DELOITTE. The Restaurant of the Future: A Vision Evolves. [online]. Deloitte
Insights, 2021 [cit. 2025-10-12]. Dostupné z:
https://www2.deloitte.com/us/en/insights/industry/retail-distribution/restaurant-of-the-
future.html
[3] OPENTABLE. Restaurant Management Features. [online]. OpenTable, Inc., 2024
[cit. 2025-10-12]. Dostupné z: https://restaurant.opentable.com
[4] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.


## 9


1.2.1 Zobrazení restaurací a jejich vyhledávání
Prvním krokem v interakci zákazníka se systémem je vyhledání a výběr vhodného
gastronomického podniku. Aby byla tato fáze co nejpohodlnější, musí aplikace nabízet
přehledné zobrazení dostupných restaurací včetně jejich umístění na mapě. Integrace
mapových služeb se v mobilních aplikacích stala standardem — zákazníci jsou zvyklí
vyhledávat podniky v okolí na základě své aktuální polohy, hodnocení ostatních
uživatelů nebo konkrétních filtrů, jako je typ kuchyně, cenová kategorie či aktuální
otevírací doba [1].
Základem tohoto modulu je zobrazení restaurací na interaktivní mapě, která zákazníkovi
umožní rychlou orientaci v okolí. Každý podnik je na mapě reprezentován mapovým
špendlíkem, po jehož výběru se zobrazí základní informace — název restaurace, adresa,
hodnocení a aktuální dostupnost rezervace. Tento přístup je uživatelsky intuitivní a
odpovídá vzorcům chování, na které jsou zákazníci zvyklí z aplikací jako Google Maps
nebo Mapy.cz [2].
Vedle mapového zobrazení by měl systém podporovat také vyhledávání podle názvu
podniku nebo lokality a filtrování výsledků podle relevantních kritérií. Mezi
nejdůležitější filtry patří typ kuchyně, cenová kategorie, kapacita restaurace a aktuální
dostupnost volných stolů. Tato kombinace mapového zobrazení a filtrování výrazně
zkracuje čas potřebný k nalezení vhodného podniku a zvyšuje celkovou uživatelskou
zkušenost [3].
Pro implementaci mapové funkcionality je vhodné využít Google Maps Platform, která
nabízí dobře zdokumentované API pro integraci do mobilních i webových aplikací.
Tato služba poskytuje nejen mapové podklady, ale také geolokační služby, které
umožňují automatické určení polohy zákazníka a zobrazení restaurací v jeho
bezprostředním okolí [4].
Z pohledu provozovatele restaurace je důležité, aby systém umožňoval snadnou správu
profilu podniku — nastavení adresy, otevírací doby, fotografií interiéru a popisu
nabídky. Kompletní a aktuální profil restaurace zvyšuje pravděpodobnost, že si
zákazník podnik vybere, a zároveň poskytuje dostatek informací pro informované
rozhodnutí ještě před samotnou rezervací [1].

Použité zdroje
[1] DELOITTE. The Restaurant of the Future: A Vision Evolves. [online]. Deloitte
Insights, 2021 [cit. 2025-10-12]. Dostupné z:
https://www2.deloitte.com/us/en/insights/industry/retail-distribution/restaurant-of-the-
future.html

## 10

[2] GOOGLE. Google Maps Platform Documentation. [online]. Google LLC, 2024 [cit.
2025-10-12]. Dostupné z: https://developers.google.com/maps/documentation
[3] NIELSEN, Jakob. Usability Engineering. Morgan Kaufmann, 1994. ISBN 978-0-
## 12-518406-9.
[4] GOOGLE. Maps JavaScript API. [online]. Google LLC, 2024 [cit. 2025-10-12].
Dostupné z: https://developers.google.com/maps/documentation/javascript
1.2.2 Rezervace stolů
Jedním ze základních funkčních požadavků systému je možnost online rezervace stolů.
Tato funkcionalita je klíčová nejen pro zákazníky, kteří očekávají pohodlný a rychlý
způsob, jak si zajistit místo v restauraci, ale i pro samotné provozovatele, protože jim
umožňuje efektivně řídit obsazenost podniku.
Na rozdíl od běžně dostupných rezervačních řešení, která fungují spíše formou
časových slotů, jako jsou například OpenTable nebo TheFork, má navrhovaný systém
nabídnout vyšší míru interaktivity. Zákazník nebude rezervovat pouze čas a počet osob,
ale získá možnost zvolit si konkrétní stůl v restauraci. Tento přístup odpovídá rostoucím
nárokům zákazníků na personalizaci služeb a zároveň představuje funkci, která na
českém trhu v současné době chybí [1].
Aby byla tato funkcionalita plně využitelná, musí rezervační modul splňovat několik
klíčových požadavků. Aplikace musí zákazníkovi poskytnout grafické znázornění
uspořádání stolů v restauraci s barevným rozlišením jejich aktuálního stavu — volné,
obsazené nebo rezervované stoly musí být na první pohled rozlišitelné. Na základě
tohoto přehledu si zákazník zvolí konkrétní stůl podle svých preferencí, například u
okna, u baru nebo v klidné části restaurace, a specifikuje požadovaný časový interval
návštěvy. Po dokončení výběru systém okamžitě potvrdí rezervaci prostřednictvím
notifikace v aplikaci.
Pro restauraci tato funkcionalita znamená především možnost lépe plánovat kapacitu a
předcházet situacím s nadměrným počtem rezervací. Přesná evidence obsazenosti stolů
v reálném čase zajišťuje vyšší efektivitu obsluhy a umožňuje majitelům pracovat s daty
o vytíženosti jednotlivých částí podniku.
Vzhledem k tomu, že na českém trhu v současné době neexistuje řešení nabízející
rezervaci konkrétního stolu s vizualizací a aktuálním stavem obsazenosti, lze tuto
funkcionalitu považovat za klíčovou konkurenční výhodu navrhovaného systému [2].

Použité zdroje
[1] OPENTABLE. About Us. [online]. OpenTable, Inc., 2024 [cit. 2025-10-12].
Dostupné z: https://www.opentable.com/about

## 11

[2] DELOITTE. The Restaurant of the Future: A Vision Evolves. [online]. Deloitte
Insights, 2021 [cit. 2025-10-12]. Dostupné z:
https://www2.deloitte.com/us/en/insights/industry/retail-distribution/restaurant-of-the-
future.html

1.2.2 Objednávky jídel a nápojů
Druhým zásadním funkčním požadavkem systému je podpora digitálních objednávek
jídel a nápojů. Digitalizace objednávkového procesu je jedním z nejrychleji rostoucích
trendů  v  gastronomii – zákazníci  čím  dál  více  očekávají  možnost  zadat  objednávku
pohodlně přes mobilní aplikaci či tablet přímo od stolu. Podle studie Deloitte až 40 %
zákazníků preferuje podniky, které nabízejí digitální objednávání, protože jim šetří čas a
zvyšuje komfort [1].
Digitální menu
Základem objednávkového modulu je digitální menu dostupné přímo v aplikaci. To by
mělo zákazníkům umožnit:
 přehledně procházet nabídku restaurace,
 filtrovat pokrmy podle kategorií (předkrmy, hlavní jídla, dezerty),
 třídit podle dietních preferencí (vegetariánské, veganské, bezlepkové, alergeny),
 zobrazovat detailní popisy pokrmů a fotografie,
 sledovat aktuální dostupnost jídel (např. vyprodané položky).
Digitální  menu  má  oproti  klasickému  tištěnému  několik  výhod:  lze  ho  snadno
aktualizovat,  obohatit  o  fotografie  a  interaktivní prvky  a  propojit  s  objednávkovým
systémem.  Podobný  přístup  využívají  některé  zahraniční  platformy  (např.  TheFork
Manager, který restauracím nabízí i správu digitálního menu) [2].
Možnosti objednávání
Systém by měl podporovat dva základní režimy objednávání:
- Předobjednávka při rezervaci – zákazník si vybere nejen stůl, ale rovnou i
pokrmy, které chce mít připravené v konkrétní čas. To pomáhá restauracím
optimalizovat přípravu jídel a zrychluje obsluhu.
- Objednávka během návštěvy – zákazník může přes aplikaci objednávat další
položky přímo od stolu, což snižuje čekání na obsluhu a umožňuje rychlejší
servis.
Kombinace  obou  režimů  poskytuje  uživatelům  flexibilitu  a  restauracím  jistotu,  že
objednávky budou efektivně zaznamenány.

## 12

Integrace s provozními systémy
Aby byl tento modul funkční i z pohledu restaurace, je nutná integrace s POS (Point of
Sale) systémy. Většina restaurací  v ČR využívá systémy  jako Dotykačka, Storyous
nebo  R-Keeper,  které  slouží  k  evidenci  objednávek  a  propojení  s  kuchyní.  Pokud
aplikace  dokáže  komunikovat  s  těmito  systémy  přes  API,  může  objednávku
automaticky zaevidovat, odeslat do kuchyně a propojit ji s účtem stolu.
Pokud  by  integrace  s  konkrétním  POS  nebyla  možná  (například  kvůli  licenčním
omezením),  lze  zvolit  náhradní  řešení:  vlastní  objednávkový  modul,  kde  personál
potvrzuje objednávky přímo z administrační aplikace. Tento přístup ale vyžaduje, aby
restaurace vedla paralelně více systémů, což je méně efektivní.
Přínosy digitálních objednávek
 Pro zákazníky: vyšší komfort, kratší čekací doba, přesnější přehled o nabídce a
cenách, možnost opakovaného objednání bez čekání na obsluhu.
 Pro restaurace: snížení chybovosti v objednávkách, efektivnější využití
personálu, možnost sbírat data o preferencích zákazníků a prodeji jednotlivých
položek.
Jak ukazuje průzkum společnosti McKinsey, digitalizace objednávek vede k 10–20%
zvýšení  tržeb  díky  zrychlení  obsluhy  a  vyšší  míře  dodatečných  objednávek
## („upselling“) [3].
Funkce objednávkového modulu
Pro dosažení výše uvedených přínosů by objednávkový modul měl zahrnovat:
 možnost přidávat položky do košíku a editovat objednávku,
 zobrazení souhrnu objednávky a ceny,
 volbu způsobu platby (hotovost, karta, online),
 možnost speciálních požadavků (např. bez cibule, extra příloha),
 propojení s rezervací stolu, aby byla objednávka jednoznačně přiřazena.

Použité zdroje
[1]  Deloitte. The  Restaurant  of  the  Future:  A  Vision  Evolves.  Deloitte  Insights,  2021.
[2]    TheFork.    Restaurant    Manager    Tool.    [online].    Dostupné    z:
https://www.theforkmanager.com
[3]  McKinsey  &  Company. The  next  normal  for  restaurants:  Digital,  delivery,  and
experience. 2021.
[4]  Querko.  Oficiální  stránky.  [online].  Dostupné  z:  https://www.querko.com

## 13

[5]  Dotykačka.  Jak  funguje  chytrý  pokladní  systém.  [online].  Dostupné  z:
https://www.dotykacka.cz
1.2.3 Online platby
Platby patří  mezi klíčové procesy každé restaurace a zároveň představují oblast, kde
digitalizace  přináší  výraznou  přidanou  hodnotu.  Zatímco  ještě  před  několika  lety
dominovala v gastronomii hotovost, dnes zákazníci stále častěji využívají bezkontaktní
karty,  mobilní  peněženky  nebo  QR  kódy.  Podle  studie  Mastercard  více  než  60  %
zákazníků  v  Evropě  preferuje  digitální  platby  před  hotovostí,  přičemž  trend  je
nejvýraznější u mladších generací [1].
Přínosy online plateb
 Pro zákazníky znamenají vyšší pohodlí, rychlost a bezpečnost transakcí. Platbu
mohou uskutečnit přímo z aplikace, bez nutnosti čekat na obsluhu.
 Pro restaurace přináší digitalizace plateb snížení chyb při účtování, rychlejší
obrat stolů a možnost automatizovaného propojení plateb s účty stolů v
pokladním systému [2].
 Z hlediska hygieny a bezpečnosti se online platby staly preferovanou volbou i
během pandemie COVID-19, kdy zákazníci upřednostňovali minimální fyzický
kontakt při placení [3].
Možnosti integrace plateb
Implementace  platební  funkce v rámci rezervační a objednávkové aplikace  může  být
řešena různými způsoby.
- Napojení na externí platební bránu
o nejjednodušší varianta vhodná pro prototyp i pro reálné nasazení,
o využití služeb jako GoPay, ComGate, Stripe, ČSOB platební brána nebo
## Adyen,
o aplikace pošle požadavek na bránu → zákazník zaplatí kartou/mobilní
peněženkou → brána pošle potvrzení o transakci zpět do systému.
o výhoda: rychlá implementace, legislativně zajištěná bezpečnost (PCI
## DSS).
o nevýhoda: restaurace musí spravovat další účet u poskytovatele platební
brány.
- Integrace s POS (pokladním systémem)
o propojení objednávek a plateb přímo s existujícím systémem restaurace
(např. Storyous, Dotykačka, R-Keeper),
o platba se v aplikaci přiřadí ke konkrétnímu účtu stolu v POS a zákazník
může účet rovnou uhradit online,
o výhoda: jednotná evidence, restaurace nemusí nic přenášet ručně,
o nevýhoda: složitější implementace, nutnost přístupu k API od
poskytovatele POS.
- Hybridní model

## 14

o kombinace obou přístupů, kdy aplikace primárně využívá platební bránu,
ale tam, kde to POS dovoluje, se integruje napřímo.
o tento model nabízí flexibilitu a možnost postupného rozšiřování
funkcionality.
Způsob práce s účty stolů
Aby  byly  platby  efektivně  propojeny  s  rezervacemi  a  objednávkami,  je  nutné  mít  v
databázi aplikace evidován stav účtu pro každý stůl. Systém tak dokáže:
 vygenerovat aktuální částku k zaplacení,
 přiřadit platbu ke konkrétní rezervaci,
 rozdělit účet mezi více zákazníků (tzv. split payment),
 potvrdit transakci a uzavřít účet.
Rozdělení účtu je obzvlášť důležité pro skupinové rezervace, kdy více osob chce platit
odděleně – podle  průzkumů  až  35  %  zákazníků  považuje  tuto  možnost  za  velmi
důležitou [4].
Bezpečnost plateb
Bezpečnost  je  zásadním  aspektem  při  zpracování  plateb.  Použití  platební  brány
garantuje  dodržení  standardu PCI  DSS  (Payment  Card  Industry  Data  Security
Standard), což znamená, že aplikace nemusí přímo ukládat citlivé údaje o kartách. Z
pohledu uživatele je důležitá i možnost vícestupňového ověření (3D Secure) a přehledné
potvrzení transakce.

Použité zdroje
## [1] Mastercard. Consumer Payment Attitudes Study. 2022.
[2]  OpenTable.  Digital  payment  solutions  for  restaurants.  [online].  Dostupné  z:
https://restaurant.opentable.com
[3]  Deloitte. The  Restaurant  of  the  Future:  A  Vision  Evolves.  Deloitte  Insights,  2021.
[4]  Statista.  Share  of  consumers  requesting  split  payments  in  restaurants  worldwide.
## 2021.
1.2.4 Správa rezervací a objednávek
Každý rezervační a objednávkový systém musí kromě uživatelské části nabídnout také
nástroje pro správu provozu  restaurace. Bez kvalitního administračního rozhraní by
aplikace nebyla v praxi použitelná, protože personál potřebuje mít okamžitý přehled o
obsazenosti stolů, příchozích rezervacích a aktivních objednávkách.

## 15

Přehled rezervací a stolů
Základní  funkcí  administračního  rozhraní  je  zobrazení aktuální obsazenosti stolů v
reálném čase. Personál má možnost vidět:
 které stoly jsou volné, obsazené nebo rezervované,
 detail rezervace (čas, jméno zákazníka, počet osob, speciální požadavky),
 časový plán obsazení stolů během dne, aby bylo možné předvídat volné
kapacity.
Tento přehled funguje jako digitální „mapa“ restaurace, kterou obsluha používá k řízení
provozu. V zahraničí tuto funkcionalitu poskytuje například OpenTable for Restaurants
## [1].
Správa objednávek
Další  klíčovou  funkcí  je  možnost  spravovat  objednávky,  které  zákazníci  zadají
prostřednictvím aplikace. Personál musí mít možnost:
 potvrdit či odmítnout objednávku,
 označit pokrm jako připravovaný, hotový nebo doručený,
 ručně upravit objednávku v případě změn,
 propojit objednávky s účty stolů a pokladním systémem.
Pokud je aplikace integrována s POS (např. Dotykačka, Storyous), pak se objednávky
automaticky  přenášejí  do  kuchyňského  displeje  a  do  pokladny.  V  opačném  případě
slouží administrační rozhraní jako hlavní místo, kde obsluha objednávky zpracovává.
Role personálu
Administrační  systém  by  měl  podporovat různé  role  uživatelů s  odlišnými
oprávněními:
 obsluha – přístup k aktuálním rezervacím a objednávkám, možnost označovat
jejich stav,
 manažer směny – navíc možnost spravovat rezervace, posouvat hosty, slučovat
stoly,
 majitel/administrátor – plný přístup včetně nastavení menu, cen, reportů a
statistik.
Toto rozdělení rolí zajišťuje, že každý pracovník vidí jen ty informace, které potřebuje
pro svou práci, a zároveň chrání citlivá data restaurace [2].
Uživatelská přívětivost
Důležitým  požadavkem  je  také  jednoduchost  a  intuitivnost  administračního  rozhraní.
Restaurace jsou prostředím, kde dochází k častému střídání personálu, a proto je nutné,

## 16

aby ovládání systému bylo rychlé a snadno pochopitelné i pro nováčky. Podle výzkumů
v  oblasti  HCI  (Human-Computer  Interaction)  patří  mezi  klíčové  faktory  úspěšného
systému  v  gastronomii nízká  kognitivní  zátěž  uživatele,  rychlá  zpětná  odezva
systému a minimalizace počtu kroků potřebných k vykonání akce [3].
Propojení rezervací a objednávek
Velkou výhodou integrovaného systému je propojení rezervací a objednávek. Personál
vidí  nejen  to,  kdo  má  rezervovaný  konkrétní  stůl,  ale  také  zda  zákazník  zadal
předobjednávku  jídel  a  nápojů. Díky  tomu  může  kuchyně  lépe  plánovat  přípravu
pokrmů a obsluha rychleji reagovat na potřeby hostů.

Použité zdroje
[1]   OpenTable.   Restaurant   Management   Features.   [online].   Dostupné   z:
https://restaurant.opentable.com
[2] Cosmina, I. – Harrop, R. – Schaefer, C. – Ho, C. Pro Spring 6. Apress, 2023. ISBN
## 978-1-4842-8639-5.
[3]   Nielsen,   J. Usability   Engineering.   Morgan   Kaufmann,   1994.   ISBN   978-
## 0125184069.
1.2.5 Statistiky a reporty
Moderní rezervační a objednávkové systémy již neslouží pouze k evidenci provozních
údajů, ale stávají se také analytickým nástrojem, který pomáhá restauracím přijímat
informovaná rozhodnutí. Statistiky a reporty umožňují provozovatelům sledovat klíčové
ukazatele výkonu (Key Performance Indicators – KPI), jako je obsazenost stolů, výše
tržeb,  průměrná  doba  strávená  hostem  u  stolu  nebo  popularita  jednotlivých  položek
menu.
Přínosy analytiky v gastronomii
 Optimalizace kapacity – analýza obsazenosti stolů pomáhá majitelům
identifikovat nejvytíženější dny a hodiny. Na základě těchto údajů lze
efektivněji plánovat směny personálu a předcházet nedostatku míst [1].
 Zlepšení nabídky – sledováním nejčastěji objednávaných pokrmů mohou
restaurace přizpůsobit menu preferencím zákazníků a včas vyřadit položky s
nízkým zájmem.
 Zvýšení tržeb – analýza objednávek umožňuje lépe identifikovat příležitosti pro
doplňkový prodej (tzv. upselling). McKinsey uvádí, že restaurace, které aktivně
využívají digitální data, dosahují v průměru o 10–20 % vyšších tržeb [2].

## 17

 Lepší zákaznická zkušenost – sledování preferencí hostů umožňuje
personalizovat nabídku a komunikaci (například zasílat individuální slevy nebo
doporučení).
Typy statistik a reportů
Systém by měl nabízet minimálně tyto typy reportů:
 rezervační reporty – počet rezervací za určité období, míra zrušení, obsazenost
jednotlivých stolů,
 prodejní reporty – tržby podle dní, kategorií jídel či jednotlivých položek
menu,
 personální reporty – výkon obsluhy, rychlost odbavení objednávek,
 zákaznické reporty – návratnost hostů, průměrná útrata, oblíbené položky.
Důležitým  aspektem  je  možnost exportu  dat do  standardních  formátů  (např.  CSV,
XLSX), aby bylo možné dále pracovat s daty v účetních či marketingových systémech.
Vizualizace dat
Pro  zajištění  přehlednosti  je  vhodné  využít grafickou  vizualizaci.  Grafy,  heatmapy
obsazenosti  nebo  dashboardy  umožňují  majitelům  rychle  pochopit  stav  podniku  bez
nutnosti  detailního  studia  čísel.  Podobné  funkce  dnes  nabízí  například  cloudová
analytická služba Power BI nebo Google Data Studio, které lze integrovat i s externími
aplikacemi [3].
Bezpečnost a přístup k reportům
Statistiky obsahují citlivá data o tržbách a chování zákazníků. Proto je nutné nastavit
uživatelská  oprávnění – zatímco  majitel  či  manažer  má  přístup  ke  všem  reportům,
běžný personál vidí jen provozní údaje nutné pro jeho práci. Toto rozdělení rolí chrání
podnik před zneužitím informací a zároveň podporuje efektivní řízení [4].

Použité zdroje
[1]  Deloitte. The  Restaurant  of  the  Future:  A  Vision  Evolves.  Deloitte  Insights,  2021.
[2]  McKinsey  &  Company. The  next  normal  for  restaurants:  Digital,  delivery,  and
experience. 2021.
[3]  Google.  Data  Studio – Business  intelligence  and  analytics.  [online].  Dostupné  z:
https://datastudio.google.com
[4] Cosmina, I. – Harrop, R. – Schaefer, C. – Ho, C. Pro Spring 6. Apress, 2023. ISBN
## 978-1-4842-8639-5.

## 18

1.2.7 Notifikace a komunikace
Efektivní  komunikace  se  zákazníkem  je  jedním  z  klíčových  faktorů  úspěšného
fungování  moderních  rezervačních  a  objednávkových  systémů.  Notifikace  a
automatizované zprávy nejen zvyšují komfort uživatelů, ale také pomáhají restauracím
snižovat  počet  nevyužitých  rezervací,  urychlovat  odbavení  objednávek  a  zlepšovat
zákaznickou zkušenost.
Typy notifikací
Systém  musí  podporovat  různé  druhy  oznámení,  které  reflektují  jednotlivé  fáze
interakce zákazníka s aplikací:
 Potvrzení rezervace – uživatel obdrží okamžité potvrzení, že jeho rezervace
byla přijata a přiřazena ke konkrétnímu stolu.
 Připomenutí rezervace – automatická zpráva zaslaná několik hodin předem,
která snižuje riziko, že zákazník na rezervaci zapomene. Podle průzkumu
Statista tato funkce dokáže snížit počet tzv. no-shows až o 25 % [1].
 Změny a storna – zákazník musí být informován o jakýchkoliv úpravách
rezervace, a to buď z jeho strany, nebo ze strany restaurace (např. přesun
rezervace na jiný stůl).
 Notifikace k objednávkám – potvrzení přijetí objednávky, aktualizace stavu
(připravuje se, hotovo, doručeno k stolu).
 Platební notifikace – informace o provedení online platby, vystavení účtenky a
možnost zpětného přístupu k historii plateb.
Kanály komunikace
Aplikace by měla podporovat více kanálů pro zasílání notifikací:
 Push notifikace v mobilní aplikaci (rychlé, interaktivní, možnost přímého
přechodu na detail rezervace),
 SMS zprávy – vhodné jako záloha v případě, že uživatel nepoužívá mobilní
aplikaci,
 E-mailové zprávy – detailní potvrzení s možností připojit další informace (např.
QR kód k platbě nebo odkaz na digitální menu).
Podle studií v oblasti digitální komunikace je nejefektivnější kombinace push notifikací
a e-mailů – push zprávy zajistí okamžité povědomí a e-mail poskytne detailní informace
v přehledné formě [2].
Obousměrná komunikace
Vedle  jednostranných  notifikací  může  systém  nabízet  také  možnost obousměrné
komunikace. Zákazník by měl mít možnost:

## 19

 odpovědět na potvrzovací zprávu (např. potvrdit účast či změnit počet osob),
 kontaktovat restauraci přes integrovaný chat,
 nahlásit speciální požadavky (např. alergie, dětská židlička).
Pro restaurace je tato funkcionalita cenná zejména proto, že umožňuje pružně reagovat
na změny a poskytovat personalizovanou péči zákazníkům.
Přínosy pro restauraci
 Snížení počtu nevyužitých rezervací (no-shows) díky připomínkám a
potvrzením,
 rychlejší odbavení hostů díky notifikacím o objednávkách,
 lepší zákaznická zkušenost prostřednictvím personalizovaných zpráv,
 zvýšení loajality – restaurace může využít notifikační systém také pro
marketing (např. zasílání pozvánek na speciální akce nebo slevových kuponů).

Použité zdroje
[1]  Statista.  Share  of  restaurants  reporting  reduced  no-shows  thanks  to  digital  booking
reminders. 2022.
[2]  Deloitte. The  Restaurant  of  the  Future: A  Vision  Evolves.  Deloitte  Insights,  2021.
[3]   Nielsen,   J. Usability   Engineering.   Morgan   Kaufmann,   1994.   ISBN   978-
## 0125184069.

1.3. Nefunkční požadavky na systém
Vedle funkčních požadavků, které specifikují co má systém umět, je nezbytné definovat
také nefunkční požadavky. Ty určují jakým způsobem má systém fungovat, jaké má mít
kvalitativní vlastnosti a omezení. Jinými slovy, nefunkční požadavky popisují kritéria,
která ovlivňují použitelnost, výkonnost, bezpečnost či spolehlivost aplikace.
Sommerville uvádí, že „nefunkční požadavky specifikují omezení na služby nebo
funkce systému a často určují kritéria hodnocení jeho provozních vlastností" [1, s. 115].
Nefunkční požadavky bývají často ještě důležitější než ty funkční, protože právě ony
rozhodují o tom, zda bude systém v reálném prostředí použitelný. Rezervační systém,
který by sice umožňoval rezervovat stůl, ale vykazoval by dlouhou odezvu,
nedostatečné zabezpečení nebo by byl náchylný k výpadkům, by zákazníci ani
restaurace nepřijali. Proto je nutné tyto požadavky analyzovat již v návrhové fázi a brát
je jako klíčové vstupy pro architekturu i implementaci [2].

## 20

V případě vyvíjeného systému pro správu rezervací v gastronomii hrají zásadní roli
zejména škálovatelnost, aby aplikace dokázala růst s počtem uživatelů i restaurací,
zabezpečení, jelikož se pracuje s osobními údaji zákazníků, výkon a odezva databáze,
které určují rychlost systému, spolehlivost a dostupnost, aby restaurace mohly aplikaci
používat i během provozní špičky, použitelnost a přístupnost, které zajišťují
srozumitelnost pro zákazníky i personál, a konečně udržovatelnost a rozšiřitelnost, které
jsou nezbytné pro budoucí rozvoj aplikace. Tato kritéria dohromady určují, zda systém
dokáže uspět na trhu, obstát v reálném provozu a dlouhodobě plnit požadavky uživatelů.

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] WIRTZ, Jochen et al. Service management in the digital age: Transforming
customer experience. Journal of Service Management, 2019.
## 1.3.1 Škálovatelnost
Škálovatelnost je jedním z klíčových nefunkčních požadavků informačních systémů.
Definuje schopnost aplikace zvládat rostoucí počet uživatelů, větší objem dat a vyšší
počet požadavků bez výrazného poklesu výkonu. V praxi to znamená, že systém musí
být navržen tak, aby dokázal fungovat nejen v jedné restauraci, ale také v případě
nasazení ve větší síti podniků, kde se počty rezervací násobí.
Škálovatelnost se obvykle řeší dvěma způsoby. Vertikální škálování spočívá v
navyšování výkonu jednotlivého serveru, například přidáním paměti nebo rychlejšího
procesoru. Tento přístup je sice jednodušší, ale má své fyzické a ekonomické limity.
Horizontální škálování naproti tomu spočívá v přidávání dalších serverů nebo instancí
aplikace, je flexibilnější a lépe odpovídá potřebám moderních cloudových prostředí [1].
Důležitou roli v oblasti škálovatelnosti hraje cloudová infrastruktura, která umožňuje
automatické přizpůsobování výkonu systému aktuální poptávce. Cloudové platformy
poskytují mechanismy pro automatické škálování počtu instancí aplikace v závislosti na
zatížení, čímž eliminují nutnost předem dimenzovat infrastrukturu na maximální
možnou zátěž [2].
Databázová vrstva bývá nejčastějším úzkým hrdlem celého systému. Pro zajištění její
škálovatelnosti je nezbytné optimalizovat databázové schéma prostřednictvím indexů a
vhodných datových typů, využívat partitioning pro rozdělení velkých tabulek a nasadit
replikaci, při které více databázových uzlů sdílí zátěž čtení dat. Důležitou roli hraje také
využití vyrovnávací paměti pro ukládání často opakovaných dotazů, čímž se výrazně
snižuje počet přímých přístupů do databáze [2].

## 21

Škálovatelnost lze podpořit také architektonickým řešením. Využití principu
mikroslužeb místo monolitické aplikace umožňuje oddělit jednotlivé části systému a
škálovat je nezávisle na sobě podle aktuální potřeby. Tento přístup je považován za
standard pro vysoce zatížené systémy a přináší větší flexibilitu při budoucím rozšiřování
## [3].
Aby bylo možné škálovatelnost objektivně ověřit, je nutné provádět zátěžové a
výkonnostní testy, které simulují vysoký počet souběžných uživatelů. Cílem těchto testů
je identifikovat slabá místa systému dříve, než ovlivní reálný provoz [4].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] GOOGLE CLOUD. Cloud SQL for PostgreSQL Documentation. [online]. Google
LLC, 2024 [cit. 2025-10-12]. Dostupné z: https://cloud.google.com/sql/docs/postgres
[3] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
[4] APACHE SOFTWARE FOUNDATION. Apache JMeter. [online]. Apache
Software Foundation, 2024 [cit. 2025-10-12]. Dostupné z: https://jmeter.apache.org
## 1.3.2 Zabezpečení
Bezpečnost patří k nejzásadnějším nefunkčním požadavkům každého informačního
systému. U aplikací v gastronomii, které zpracovávají osobní údaje zákazníků a
informace o rezervacích, je význam bezpečnosti obzvláště vysoký. Nedostatečné
zabezpečení může vést nejen ke ztrátě nebo úniku dat, ale také k ohrožení důvěry
uživatelů a reputace celého podniku [1].
Základním bezpečnostním mechanismem každého systému je autentizace a autorizace.
Autentizace zajišťuje jednoznačnou identifikaci uživatele — zákazníci se typicky
registrují prostřednictvím e-mailu nebo telefonního čísla, přičemž bezpečnější variantou
je dvoufaktorová autentizace kombinující heslo s ověřením přes SMS nebo mobilní
aplikaci. Autorizace pak určuje, jaká oprávnění má daný uživatel v systému.
Standardním přístupem je řízení přístupu na základě rolí, tzv. RBAC (Role-Based
Access Control), kdy jsou uživatelům přiřazeny role s předem definovanými právy.
Toto rozdělení zajišťuje, že každý uživatel má přístup pouze k těm funkcím, které jsou
nezbytné pro výkon jeho role [2].
Veškerý přenos dat mezi klientskou aplikací a serverem musí probíhat zabezpečeně
prostřednictvím šifrované komunikace. Standardem je protokol HTTPS s využitím TLS
(Transport Layer Security), který chrání přenášená data proti odposlechu a neoprávněné

## 22

manipulaci. Zvláštní pozornost je třeba věnovat také ukládání hesel — hesla uživatelů
nesmějí být nikdy ukládána v otevřeném textu, ale výhradně jako kryptografický hash
doplněný o náhodnou hodnotu, tzv. salt [1].
Aplikace musí být v souladu s evropskou legislativou GDPR (General Data Protection
Regulation), která stanovuje pravidla pro zpracování osobních údajů. To zahrnuje
zejména možnost uživatele vyžádat smazání svého účtu a všech souvisejících dat,
možnost exportu osobních dat v přenosném formátu a zpracování údajů výhradně pro
účely, k nimž dal uživatel souhlas. Správné nastavení procesů v souladu s GDPR
zajišťuje právní bezpečnost systému a zároveň posiluje důvěru zákazníků [3].
Systém musí být chráněn také proti běžným typům útoků. Mezi nejrozšířenější hrozby
patří SQL injection, při které útočník prostřednictvím vstupních polí manipuluje s
databázovými dotazy, Cross-Site Scripting umožňující vložení škodlivého kódu do
webových stránek, Cross-Site Request Forgery zneužívající důvěru serveru v
přihlášeného uživatele a útoky hrubou silou zaměřené na prolomení přihlašovacích
údajů. Ochrana proti těmto hrozbám musí být součástí návrhu systému od samého
počátku [1].
Nedílnou součástí bezpečnostní politiky je také monitoring a logování. Zaznamenávání
přístupových pokusů a detekce anomálií v provozu umožňují rychle reagovat na
bezpečnostní incidenty a předcházet větším škodám. Aktivní monitoring bezpečnostních
událostí je považován za nezbytnou součást provozu každého informačního systému
pracujícího s osobními údaji [4].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] SANDHU, Ravi S. et al. Role-Based Access Control Models. IEEE Computer,
## 1996.
[3] EVROPSKÝ PARLAMENT A RADA EU. Nařízení (EU) 2016/679 o ochraně
fyzických osob v souvislosti se zpracováním osobních údajů (GDPR). [online]. 2016
[cit. 2025-10-12]. Dostupné z: https://eur-lex.europa.eu/legal-
content/CS/TXT/?uri=CELEX:32016R0679
[4] DEINUM, Marten; RUBIO, Daniel a LONG, Josh. Spring 6 Recipes: A Problem-
Solution Approach to Spring Framework. Apress, 2023. ISBN 978-1-4842-8648-7.


## 23

1.3.3 Výkon a odezva databáze
Výkon systému a jeho schopnost reagovat v reálném čase patří mezi nejzásadnější
nefunkční požadavky. Zákazníci očekávají, že zobrazení nabídky restaurace nebo
provedení rezervace stolu proběhne během několika sekund. Pokud by aplikace
reagovala pomalu, vedlo by to k frustraci uživatelů a k odlivu zákazníků. Podle
výzkumů v oblasti použitelnosti uživatelé vnímají odezvu delší než jednu sekundu jako
zpomalující a odezvu přesahující deset sekund již považují za nepřijatelnou [1].
Z hlediska požadavků na odezvu platí, že běžné operace, jako je zobrazení menu nebo
vytvoření rezervace, musí být zpracovány do jedné sekundy. Složitější operace,
například generování statistik nebo přehledů obsazenosti, by měly být dokončeny do
čtyř sekund. V době provozní špičky, tedy typicky v obědových a večerních hodinách,
musí systém zvládnout vysoký počet souběžných požadavků bez výrazného zpomalení
## [1].
Výkon databáze úzce souvisí s kvalitou jejího návrhu. Správná normalizace schématu
předchází duplicitám a zajišťuje konzistenci dat, zatímco použití indexů na často
dotazované sloupce, jako jsou identifikátory stolů nebo časy rezervací, výrazně
urychluje vyhledávání. Pro optimalizaci složitějších dotazů je vhodné analyzovat jejich
prováděcí plány a průběžně identifikovat operace, které způsobují zbytečnou zátěž
databáze [2].
Pro dosažení nízké odezvy systému se využívají také další techniky. Vyrovnávací
paměť umožňuje ukládat často používaná data, jako je aktuální stav obsazenosti stolů
nebo seznam restaurací, čímž se snižuje počet přímých přístupů do databáze.
Asynchronní zpracování pak zajišťuje, že operace nevyžadující okamžité potvrzení,
například zasílání notifikací, probíhají na pozadí a neblokují odezvu systému pro
uživatele [2].
Aby bylo možné výkon objektivně ověřit, musí být součástí vývoje zátěžové testování.
Cílem těchto testů je zjistit maximální počet souběžných požadavků, které systém
zvládne, sledovat, jak se odezva zvyšuje s rostoucí zátěží, a identifikovat části systému,
které tvoří úzké hrdlo. Výsledky testů se následně využívají k optimalizaci dotazů,
konfigurace databáze a celkového návrhu architektury. Dlouhodobě je pak nezbytné
výkon průběžně monitorovat, aby bylo možné včas identifikovat potenciální problémy
dříve, než ovlivní zákazníky [3].

Použité zdroje
[1] NIELSEN, Jakob. Usability Engineering. Morgan Kaufmann, 1994. ISBN 978-0-
## 12-518406-9.

## 24

[2] POSTGRESQL GLOBAL DEVELOPMENT GROUP. PostgreSQL Documentation.
[online]. PostgreSQL Global Development Group, 2023 [cit. 2025-10-12]. Dostupné z:
https://www.postgresql.org/docs/
[3] DEINUM, Marten; RUBIO, Daniel a LONG, Josh. Spring 6 Recipes: A Problem-
Solution Approach to Spring Framework. Apress, 2023. ISBN 978-1-4842-8648-7.
1.3.4 Spolehlivost a dostupnost
Spolehlivost a dostupnost určují, zda je systém schopný stabilně poskytovat služby a jak
dlouho smí být mimo provoz, aniž by to ohrozilo provoz restaurace. Tyto požadavky
jsou v gastronomii obzvláště důležité, protože výpadek systému v době provozní špičky,
tedy typicky v obědových nebo večerních hodinách, může přímo ovlivnit příjmy
podniku a spokojenost zákazníků. Cílem je proto udržet produkční dostupnost systému
na úrovni alespoň 99,9 %, což odpovídá maximálně přibližně osmi hodinám
neplánované nedostupnosti za rok [1].
Klíčovými ukazateli v oblasti spolehlivosti jsou RTO (Recovery Time Objective) a
RPO (Recovery Point Objective). RTO definuje maximální akceptovatelnou dobu, po
kterou může být systém nedostupný po výpadku, zatímco RPO určuje maximální
akceptovatelnou ztrátu dat měřenou časem. Tyto parametry musí být stanoveny již v
návrhové fázi a musí být zohledněny při volbě infrastruktury a zálohovací strategie [2].
Vysoká dostupnost systému nevychází pouze ze záruky poskytovatele infrastruktury,
ale především z architektonických rozhodnutí. Systém musí být navržen s redundancí na
všech kritických úrovních — jak na úrovni aplikační vrstvy, tak na úrovni databáze.
Redundance zajišťuje, že výpadek jedné komponenty nevede k nedostupnosti celého
systému. Součástí návrhu musí být také automatický mechanismus převzetí služeb, tzv.
failover, který v případě výpadku primární komponenty automaticky přepne provoz na
záložní instanci [2].
Důležitou součástí spolehlivého systému je také pravidelné zálohování dat. Zálohovací
strategie musí zahrnovat jak automatické pravidelné zálohy, tak možnost obnovy dat k
libovolnému bodu v čase v rámci definovaného období. Proces obnovy ze zálohy musí
být pravidelně testován, aby bylo zajištěno, že v případě skutečného výpadku proběhne
obnova v rámci stanoveného RTO [2].
Aplikace musí být schopna průběžně signalizovat svůj stav prostřednictvím zdravotních
kontrol, tzv. health checků. Tyto mechanismy umožňují infrastruktuře automaticky
detekovat nefunkční instance aplikace a nahradit je novými, čímž se minimalizuje doba
nedostupnosti bez nutnosti manuálního zásahu. Tento přístup, označovaný jako self-
healing, je považován za základ spolehlivého provozu moderních cloudových aplikací
## [3].
Součástí strategie spolehlivosti musí být také odolnost vůči chybám při komunikaci
mezi jednotlivými komponentami systému. Při výpadku závislé služby nesmí dojít ke
kaskádovému selhání celého systému. Toho lze dosáhnout využitím vzorů jako circuit

## 25

breaker, který při opakovaných chybách dočasně přeruší volání nedostupné služby, nebo
retry mechanismů s postupně se prodlužujícími intervaly mezi pokusy [3].
Plánované operace, jako jsou aktualizace systému nebo údržba infrastruktury, musí být
prováděny způsobem, který minimalizuje dopad na dostupnost služby. Standardním
přístupem je postupné nasazení nových verzí, při kterém je provoz plynule přesměrován
z původní verze na novou bez přerušení služby [2].

Použité zdroje
[1] GOOGLE CLOUD. Cloud SQL for PostgreSQL Documentation. [online]. Google
LLC, 2024 [cit. 2025-10-12]. Dostupné z: https://cloud.google.com/sql/docs/postgres
[2] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[3] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
1.3.4 Spolehlivost a dostupnost
Spolehlivost a dostupnost určují, zda je systém schopný stabilně poskytovat služby a jak
dlouho smí být mimo provoz, aniž by to ohrozilo provoz restaurace. Tyto požadavky
jsou v gastronomii obzvláště důležité, protože výpadek systému v době provozní špičky,
tedy typicky v obědových nebo večerních hodinách, může přímo ovlivnit příjmy
podniku a spokojenost zákazníků. Cílem je proto udržet produkční dostupnost systému
na úrovni alespoň 99,9 %, což odpovídá maximálně přibližně osmi hodinám
neplánované nedostupnosti za rok [1].
Klíčovými ukazateli v oblasti spolehlivosti jsou RTO (Recovery Time Objective) a
RPO (Recovery Point Objective). RTO definuje maximální akceptovatelnou dobu, po
kterou může být systém nedostupný po výpadku, zatímco RPO určuje maximální
akceptovatelnou ztrátu dat měřenou časem. Tyto parametry musí být stanoveny již v
návrhové fázi a musí být zohledněny při volbě infrastruktury a zálohovací strategie [2].
Vysoká dostupnost systému nevychází pouze ze záruky poskytovatele infrastruktury,
ale především z architektonických rozhodnutí. Systém musí být navržen s redundancí na
všech kritických úrovních — jak na úrovni aplikační vrstvy, tak na úrovni databáze.
Redundance zajišťuje, že výpadek jedné komponenty nevede k nedostupnosti celého
systému. Součástí návrhu musí být také automatický mechanismus převzetí služeb, tzv.
failover, který v případě výpadku primární komponenty automaticky přepne provoz na
záložní instanci [2].
Důležitou součástí spolehlivého systému je také pravidelné zálohování dat. Zálohovací
strategie musí zahrnovat jak automatické pravidelné zálohy, tak možnost obnovy dat k

## 26

libovolnému bodu v čase v rámci definovaného období. Proces obnovy ze zálohy musí
být pravidelně testován, aby bylo zajištěno, že v případě skutečného výpadku proběhne
obnova v rámci stanoveného RTO [2].
Aplikace musí být schopna průběžně signalizovat svůj stav prostřednictvím zdravotních
kontrol, tzv. health checků. Tyto mechanismy umožňují infrastruktuře automaticky
detekovat nefunkční instance aplikace a nahradit je novými, čímž se minimalizuje doba
nedostupnosti bez nutnosti manuálního zásahu. Tento přístup, označovaný jako self-
healing, je považován za základ spolehlivého provozu moderních cloudových aplikací
## [3].
Součástí strategie spolehlivosti musí být také odolnost vůči chybám při komunikaci
mezi jednotlivými komponentami systému. Při výpadku závislé služby nesmí dojít ke
kaskádovému selhání celého systému. Toho lze dosáhnout využitím vzorů jako circuit
breaker, který při opakovaných chybách dočasně přeruší volání nedostupné služby, nebo
retry mechanismů s postupně se prodlužujícími intervaly mezi pokusy [3].
Plánované operace, jako jsou aktualizace systému nebo údržba infrastruktury, musí být
prováděny způsobem, který minimalizuje dopad na dostupnost služby. Standardním
přístupem je postupné nasazení nových verzí, při kterém je provoz plynule přesměrován
z původní verze na novou bez přerušení služby [2].

Použité zdroje
[1] GOOGLE CLOUD. Cloud SQL for PostgreSQL Documentation. [online]. Google
LLC, 2024 [cit. 2025-10-12]. Dostupné z: https://cloud.google.com/sql/docs/postgres
[2] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[3] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
1.3.6 Udržovatelnost a rozšiřitelnost
Udržovatelnost vyjadřuje, jak snadno lze systém opravovat, číst, testovat a aktualizovat.
Rozšiřitelnost pak popisuje, jak rychle a s minimálními zásahy lze do systému přidávat
nové funkce nebo integrovat externí služby. Obě vlastnosti jsou úzce provázané a jejich
zanedbání v návrhové fázi vede k tzv. technickému dluhu, který se s rostoucí
komplexitou systému stále obtížněji splácí. Sommerville řadí udržovatelnost mezi
klíčové kvalitativní požadavky na software vedle funkčnosti a výkonu [1].
Základním předpokladem udržovatelného systému je disciplinované oddělení
odpovědností jednotlivých vrstev aplikace. Prezentační vrstva, která zajišťuje
komunikaci s klientem, musí být striktně oddělena od doménové vrstvy obsahující

## 27

obchodní logiku a od perzistentní vrstvy zajišťující přístup k datům. Toto oddělení
minimalizuje vzájemné závislosti mezi komponentami a zajišťuje, že změna v jedné
vrstvě neovlivní ostatní části systému. Výsledkem je snazší testování, refaktoring i
případná výměna konkrétní technologie bez dopadu na celkovou architekturu [2].
Pro integrace s externími službami je vhodné využít architekturu portů a adaptérů,
označovanou také jako hexagonální architektura. Doménová část systému komunikuje s
okolím prostřednictvím jasně definovaných rozhraní, přičemž konkrétní implementace
jsou zapouzdřeny v adaptérech. Díky tomu lze snadno vyměnit poskytovatele externí
služby bez zásahu do doménové logiky a zároveň testovat doménu nezávisle na
externích závislostech [3].
Stabilita systému z pohledu jeho klientů je zajištěna verzováním rozhraní API a
důslednou politikou zpětné kompatibility. Každá změna kontraktu musí být
dokumentována a řízena tak, aby nedocházelo k neočekávanému narušení funkčnosti
klientských aplikací. Součástí tohoto přístupu je také udržování specifikace API v
aktuálním stavu, která slouží jako závazný kontrakt mezi serverovou a klientskou částí
systému [2].
Evoluce databázového schématu musí být řízena prostřednictvím verzovaných migrací.
Každá změna schématu je zaznamenána jako samostatný migrační skript, který je
opakovatelně spustitelný a součástí systému pro správu verzí. Tento přístup umožňuje
bezpečné nasazování změn napříč různými prostředími a zajišťuje synchronizaci kódu
aplikace s aktuální strukturou databáze [2].
Nezbytnou součástí udržovatelného systému je automatizované testování. Testovací
strategie by měla pokrývat jednotkové testy ověřující správnost doménové logiky,
integrační testy ověřující spolupráci jednotlivých komponent a end-to-end testy
simulující reálné scénáře použití. Vysoké pokrytí testy v kritických částech systému,
jako jsou procesy rezervace, výrazně snižuje riziko regresí při budoucích změnách [1].
Rozšiřitelnost systému závisí také na způsobu, jakým jsou navrženy integrační body s
externími službami. Klíčové funkce, jako jsou notifikační kanály nebo mapové služby,
by měly být navrženy jako vyměnitelné adaptéry řízené konfigurací. Přidání nového
poskytovatele pak nevyžaduje zásah do doménové logiky, ale pouze implementaci
nového adaptéru splňujícího definované rozhraní. Pro mezimodulovou komunikaci je
vhodné zvážit událostmi řízený přístup, který uvolňuje vazby mezi moduly a
zjednodušuje orchestraci složitějších procesů [3].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.

## 28

[2] KATAMREDDY, Siva Prasad Reddy a UPADHYAYULA, Sai Subramanyam.
Beginning Spring Boot 3: Build Dynamic Cloud-Native Java Applications and
Microservices. Apress, 2022. ISBN 978-1-4842-8791-0.
[3] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
1.4. Výběr technologií a jejich srovnání
Výběr vhodných technologií představuje jedno z nejzásadnějších rozhodnutí v procesu
vývoje softwarového systému. Správně zvolené technologie musí nejen splňovat
funkční požadavky na systém, ale zároveň odpovídat nefunkčním požadavkům, jako
jsou škálovatelnost, bezpečnost, výkon nebo udržovatelnost. Nevhodná volba
technologií může naopak vést k technickému dluhu, komplikacím při nasazení nebo k
omezení možností budoucího rozvoje aplikace [1].
Při výběru technologií je důležité zvažovat několik klíčových kritérií. Patří mezi ně
vyspělost technologie a velikost komunity, která přímo ovlivňuje dostupnost
dokumentace, knihoven a odborné podpory. Dalším kritériem je vhodnost technologie
pro daný typ aplikace a její schopnost splnit definované nefunkční požadavky. V
neposlední řadě hraje roli také dlouhodobá udržovatelnost a perspektiva dalšího rozvoje
zvolené technologie [2].
V rámci této práce bylo nutné zvolit technologie pro tři základní vrstvy systému —
frontend, backend a databázovou infrastrukturu. Pro každou vrstvu byly analyzovány
dostupné alternativy a na základě definovaných požadavků byla vybrána nejvhodnější
technologie. Následující sekce popisují toto srovnání a zdůvodňují učiněná rozhodnutí.

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.


## 29

## 1.4.1. Frontend
Vzhledem k tomu, že navrhovaná aplikace je primárně určena pro mobilní zařízení, bylo
nutné zvolit technologii, která umožňuje vývoj pro více platforem současně. Vývoj
samostatných nativních aplikací pro operační systémy Android a iOS by byl časově i
finančně náročný, protože by vyžadoval udržování dvou oddělených kódových
základen. Proto byl zvažován multiplatformní přístup, který umožňuje sdílet kód mezi
platformami a zároveň dosáhnout dostatečného výkonu a kvalitního uživatelského
rozhraní [1].
Mezi nejrozšířenější multiplatformní frameworky patří v současné době React Native,
Xamarin a Flutter. React Native, vyvíjený společností Meta, využívá jazyk JavaScript a
umožňuje vytvářet mobilní aplikace sdílením většiny kódu mezi platformami. Jeho
výhodou je velká komunita a široká dostupnost knihoven, nevýhodou však může být
nižší výkon při náročnějších grafických operacích, protože komunikace mezi
JavaScriptovou vrstvou a nativními komponentami probíhá přes most, který může být
úzkým hrdlem [2].
Xamarin, vyvíjený společností Microsoft, umožňuje vývoj multiplatformních aplikací v
jazyce C#. Výhodou tohoto frameworku je těsná integrace s ekosystémem Microsoftu a
možnost sdílet velkou část kódu mezi platformami. Nevýhodou je však menší komunita
ve srovnání s ostatními frameworky a v posledních letech také nejistota ohledně dalšího
směřování projektu, protože Microsoft přechází na platformu .NET MAUI jako
nástupce Xamarinu [2].
Flutter, vyvíjený společností Google, představuje odlišný přístup oproti výše zmíněným
frameworkům. Namísto mapování na nativní komponenty platformy Flutter vykresluje
veškeré uživatelské rozhraní vlastním grafickým enginem, čímž dosahuje
konzistentního vzhledu a vysokého výkonu na všech platformách. Flutter využívá
programovací jazyk Dart a umožňuje z jediné kódové základny vytvářet aplikace pro
Android, iOS, web i desktopová prostředí. Díky vlastnímu vykreslovacímu enginu
odpadá závislost na nativních komponentách platformy, což přináší vyšší kontrolu nad
vzhledem aplikace a konzistentní chování napříč zařízeními [3].
Pro navrhovaný systém byl zvolen framework Flutter, a to zejména z důvodu jeho
výkonu při práci s interaktivními grafickými prvky, jako je vizualizace půdorysu
restaurace a interaktivní mapa stolů. Dalším důvodem je možnost vývoje z jediné
kódové základny pro Android i iOS, což je vzhledem k rozsahu práce klíčové. Flutter
také poskytuje bohatou sadu předpřipravených komponent a aktivně se rozvíjející
ekosystém s rostoucí komunitou vývojářů [3].

Použité zdroje

## 30

[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] BAILEY, Thomas a BIESSEK, Alessandro. Flutter for Beginners. 2nd ed. Packt
Publishing, 2021. ISBN 978-1-80056-599-2.
[3] GOOGLE. Flutter Documentation. [online]. Google LLC, 2024 [cit. 2025-10-12].
Dostupné z: https://docs.flutter.dev

## 1.4.2. Backend
Backendová vrstva systému zajišťuje zpracování obchodní logiky, správu dat a
komunikaci s klientskými aplikacemi prostřednictvím REST API. Při výběru
backendového frameworku bylo nutné zohlednit požadavky na škálovatelnost,
bezpečnost, výkon a dlouhodobou udržovatelnost systému. Zvažovány byly tři
frameworky, které patří mezi nejrozšířenější v oblasti vývoje webových aplikací —
Node.js s frameworkem Express, Django a Spring Boot [1].
Node.js je prostředí pro spouštění JavaScriptu na straně serveru, které ve spojení s
frameworkem Express umožňuje rychlý vývoj lehkých webových aplikací a REST API.
Jeho hlavní výhodou je neblokující asynchronní architektura, která umožňuje efektivně
zvládat velký počet souběžných požadavků. Nevýhodou je však dynamické typování
jazyka JavaScript, které může v rozsáhlejších projektech vést k obtížnější údržbě kódu a
vyššímu riziku chyb za běhu aplikace. Ekosystém Node.js je sice velmi rozsáhlý, ale
kvalita a udržovatelnost dostupných knihoven se výrazně liší [2].
Django je webový framework pro jazyk Python, který klade důraz na rychlý vývoj a
princip „batteries included" — tedy na to, aby framework poskytoval co nejvíce
funkcionality přímo bez nutnosti instalace externích knihoven. Django nabízí vestavěný
administrační panel, robustní ORM a silnou podporu pro bezpečnost. Jeho nevýhodou je
monolitická architektura, která může komplikovat škálování jednotlivých částí systému,
a nižší výkon ve srovnání s kompilovanými jazyky při zpracování výpočetně náročných
operací [2].
Spring Boot je framework pro jazyk Java, který výrazně zjednodušuje tvorbu
produkčních aplikací tím, že poskytuje předkonfigurované prostředí s rozumným
výchozím nastavením. Spring Boot je součástí širšího ekosystému Spring, který nabízí
komplexní řešení pro bezpečnost, správu transakcí, integraci s databázemi a mnoho
dalšího. Statické typování jazyka Java přispívá k vyšší spolehlivosti kódu a usnadňuje
jeho udržovatelnost v dlouhodobém horizontu. Spring Boot je široce využíván v
podnikových aplikacích, kde jsou kladeny vysoké nároky na spolehlivost a
škálovatelnost [3].

## 31

Pro navrhovaný systém byl zvolen framework Spring Boot, a to zejména z důvodu jeho
robustnosti, vyspělého ekosystému a silné podpory pro bezpečnost prostřednictvím
modulu Spring Security. Důležitým faktorem byl také výkon a škálovatelnost jazyka
Java, které jsou klíčové pro zvládání vysokého počtu souběžných požadavků v době
provozní špičky. Spring Boot dále poskytuje výbornou podporu pro vývoj REST API a
snadnou integraci s relačními databázemi, což přímo odpovídá požadavkům
navrhovaného systému [3].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
[3] KATAMREDDY, Siva Prasad Reddy a UPADHYAYULA, Sai Subramanyam.
Beginning Spring Boot 3: Build Dynamic Cloud-Native Java Applications and
Microservices. Apress, 2022. ISBN 978-1-4842-8791-0.

## 1.4.3. Databáze
Databázová vrstva představuje základ každého informačního systému a její správný
výběr má přímý dopad na výkon, škálovatelnost a spolehlivost celé aplikace. Při výběru
databázového systému bylo nutné zvážit charakter ukládaných dat, požadavky na
integritu dat, výkon při vysokém počtu souběžných operací a dlouhodobou
udržovatelnost. Zvažovány byly tři databázové systémy — MySQL, MongoDB a
PostgreSQL [1].
MySQL je jeden z nejrozšířenějších relačních databázových systémů s dlouhou historií
a velkou komunitou. Nabízí spolehlivý výkon pro standardní operace čtení a zápisu a je
široce podporován většinou hostingových platforem. Jeho nevýhodou je však
omezenější podpora pro pokročilé datové typy a složitější dotazy ve srovnání s
PostgreSQL. MySQL také historicky zaostávalo za PostgreSQL v oblasti dodržování
standardů SQL a podpory pro komplexní transakce [2].
MongoDB je zástupcem dokumentově orientovaných databází, které ukládají data ve
formátu podobném JSON namísto klasických relačních tabulek. Jeho výhodou je
flexibilní schéma, které umožňuje snadno měnit strukturu dat bez nutnosti migrací, a
vysoký výkon při práci s nestrukturovanými nebo častěji se měnícími daty. Nevýhodou
je však absence plné podpory pro transakce přes více kolekcí, která je nezbytná pro

## 32

zajištění konzistence dat v systémech pracujících s rezervacemi a uživatelskými účty.
MongoDB je vhodné zejména pro aplikace s převážně nestrukturovanými daty, což
neodpovídá charakteru navrhovaného systému [2].
PostgreSQL je vyspělý open-source relační databázový systém s důrazem na
dodržování standardů SQL, integritu dat a podporu pro pokročilé funkce. Oproti
MySQL nabízí PostgreSQL širší podporu pro komplexní dotazy, pokročilé datové typy
včetně nativní podpory pro JSON a geografická data, a robustnější implementaci
transakcí. PostgreSQL je také dlouhodobě považován za jeden z nejspolehlivějších
open-source databázových systémů a těší se aktivní podpoře ze strany velké vývojářské
komunity [3].
Pro navrhovaný systém byl zvolen PostgreSQL, a to především z důvodu jeho
vyspělosti, spolehlivosti a bohaté funkcionality. Relační model dat přirozeně odpovídá
struktuře dat v systému pro správu rezervací, kde jsou mezi entitami jako restaurace,
stoly, uživatelé a rezervace jasně definované vztahy vyžadující referenční integritu.
Podpora pro pokročilé datové typy a komplexní dotazy pak poskytuje dostatečnou
flexibilitu pro budoucí rozšiřování systému [3].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
[3] POSTGRESQL GLOBAL DEVELOPMENT GROUP. PostgreSQL Documentation.
[online]. PostgreSQL Global Development Group, 2023 [cit. 2025-10-12]. Dostupné z:
https://www.postgresql.org/docs/


1.4.4 Nástroje pro lokální vývoj
Vedle technologií pro produkční prostředí je nezbytné zvolit také nástroje, které
vývojářům umožní efektivně pracovat v lokálním prostředí. Správná volba vývojových
nástrojů přispívá k reprodukovatelnosti prostředí, zjednodušuje ladění aplikace a
urychluje celkový vývojový cyklus [1].
Pro lokální spouštění a správu backendové aplikace a databáze byl zvolen Docker.
Docker je platforma pro kontejnerizaci aplikací, která umožňuje zabalit aplikaci spolu

## 33

se všemi jejími závislostmi do izolovaného kontejneru. Díky tomu je zajištěna
konzistence prostředí napříč různými vývojářskými stanicemi a eliminuje se problém
závislosti na konkrétní konfiguraci operačního systému. Kontejnery definované
prostřednictvím Docker Compose umožňují spustit celý systém včetně databáze
jediným příkazem, což výrazně zjednodušuje onboarding nových vývojářů a
reprodukovatelnost vývojového prostředí [2].
Pro vývoj a testování klientské aplikace ve Flutteru bylo zvoleno Android Studio, které
představuje oficiální vývojové prostředí pro platformu Android. Android Studio
poskytuje integrovaný emulátor mobilních zařízení umožňující testování aplikace bez
nutnosti fyzického zařízení, nástroje pro ladění a profilování aplikace a plnou podporu
pro Flutter plugin. Díky emulátoru lze ověřovat funkčnost a vzhled aplikace na různých
velikostech obrazovek a verzích operačního systému Android přímo v průběhu vývoje
## [3].
Důležitou vlastností obou nástrojů je jejich přirozené propojení s produkčním
prostředím. Docker kontejnery definované pro lokální vývoj lze s minimálními
úpravami využít také pro nasazení do cloudové infrastruktury, čímž se eliminují rozdíly
mezi vývojovým a produkčním prostředím a snižuje se riziko chyb při nasazení [2].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] DOCKER. Docker Documentation. [online]. Docker Inc., 2024 [cit. 2025-10-12].
Dostupné z: https://docs.docker.com
[3] GOOGLE. Android Studio Documentation. [online]. Google LLC, 2024 [cit. 2025-
10-12]. Dostupné z: https://developer.android.com/studio

1.4.5 Cloudová infrastruktura
Volba cloudové infrastruktury určuje, jakým způsobem bude systém nasazen,
provozován a škálován v produkčním prostředí. Jak bylo zmíněno v předchozí sekci,
Docker kontejnery využívané při lokálním vývoji tvoří základ pro nasazení do cloudu,
přičemž cloudová platforma zajišťuje automatické škálování, vysokou dostupnost a
geografickou redundanci. Oproti tradičnímu hostingu na vlastních serverech přináší
cloudové prostředí také model platby podle skutečného využití, který eliminuje nutnost
vysokých počátečních investic do infrastruktury. Při výběru cloudové platformy byly
zvažovány tři největší poskytovatelé — Amazon Web Services, Microsoft Azure a
## Google Cloud Platform [1].

## 34

Amazon Web Services je největším poskytovatelem cloudových služeb na světě s
nejširším portfoliem dostupných služeb a největší komunitou uživatelů. AWS nabízí
vyspělé nástroje pro správu databází, nasazení kontejnerů i automatické škálování. Jeho
nevýhodou může být složitost konfigurace a správy jednotlivých služeb, která klade
vyšší nároky na znalosti provozního týmu. Cenová struktura AWS je také považována
za jednu z komplexnějších, což může ztěžovat předvídání nákladů [2].
Microsoft Azure je cloudová platforma společnosti Microsoft, která vyniká zejména
těsnou integrací s ekosystémem Microsoftu, včetně nástrojů jako Active Directory nebo
vývojového prostředí Visual Studio. Azure je oblíbenou volbou pro podniky využívající
technologie Microsoftu. Pro projekty postavené primárně na technologiích Java a open-
source nástrojích však Azure nepřináší výrazné výhody oproti ostatním platformám [2].
Google Cloud Platform je cloudová platforma společnosti Google, která vyniká zejména
v oblasti správy kontejnerizovaných aplikací, datové analytiky a strojového učení.
Google Cloud nabízí službu Cloud Run pro nasazení kontejnerů bez nutnosti správy
serverů a Cloud SQL pro plně spravované relační databáze. Výhodou Google Cloud je
také těsná integrace s dalšími službami společnosti Google, jako je Google Maps
Platform, která je součástí navrhovaného systému. Google Cloud poskytuje přehlednou
konzoli a dobře zdokumentované API, což usnadňuje správu infrastruktury [3].
Pro navrhovaný systém byl zvolen Google Cloud Platform, a to především z důvodu
přirozené integrace s Google Maps Platform využívanou pro zobrazení restaurací na
mapě. Dalším důvodem je dostupnost služby Cloud Run, která umožňuje jednoduché
nasazení Docker kontejnerů a jejich automatické škálování, a Cloud SQL, která
poskytuje plně spravované prostředí pro PostgreSQL databázi. Kombinace těchto služeb
v rámci jedné platformy zjednodušuje správu infrastruktury a zajišťuje konzistentní
úroveň zabezpečení a dostupnosti napříč celým systémem [3].

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
[3] GOOGLE CLOUD. Cloud SQL for PostgreSQL Documentation. [online]. Google
LLC, 2024 [cit. 2025-10-12]. Dostupné z: https://cloud.google.com/sql/docs/postgres


## 35

- Návrh architektury systému
Návrh architektury systému představuje klíčovou fázi vývoje softwarové aplikace, která
předchází samotné implementaci. Architektura definuje celkovou strukturu systému,
způsob rozdělení odpovědností mezi jednotlivé komponenty a mechanismy jejich
vzájemné komunikace. Kvalitní architektonický návrh je základním předpokladem pro
splnění nefunkčních požadavků definovaných v předchozí kapitole, jako jsou
škálovatelnost, bezpečnost, výkon a udržovatelnost systému [1].
Navrhovaný systém je postaven na třívrstevné architektuře, která odděluje prezentační
vrstvu zajišťující interakci s uživatelem, aplikační vrstvu obsahující obchodní logiku
systému a datovou vrstvu zajišťující perzistenci dat. Toto oddělení odpovědností
minimalizuje vzájemné závislosti mezi vrstvami a zajišťuje, že změny v jedné vrstvě
mají minimální dopad na ostatní části systému. Komunikace mezi vrstvami probíhá
prostřednictvím jasně definovaných rozhraní, čímž je zajištěna nezávislost jednotlivých
komponent [2].
Následující sekce popisují jednotlivé vrstvy systému z pohledu jejich struktury a
vzájemného propojení. Detailní návrh databázového modelu včetně entit, jejich atributů
a vzájemných vztahů je z důvodu rozsahu a komplexnosti předmětem samostatné
kapitoly 3.

Použité zdroje
[1] SOMMERVILLE, Ian. Software Engineering. 10th ed. Pearson, 2016. ISBN 978-0-
## 13-394303-0.
[2] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.

2.1. Přehled architektury

Navrhovaný systém je realizován jako monolitická aplikace rozdělená do tří jasně
oddělených vrstev — prezentační, aplikační a datové. Monolitická architektura byla
zvolena záměrně vzhledem k rozsahu projektu, protože oproti architektuře mikroslužeb
přináší nižší provozní složitost, jednodušší nasazení a snazší ladění aplikace. Zároveň je
díky důslednému oddělení vrstev a modulárnímu uspořádání kódu připravena na

## 36

případnou budoucí migraci na mikroslužby, pokud by to rostoucí provozní nároky
vyžadovaly [1].
Prezentační vrstvu tvoří mobilní aplikace vyvinutá ve frameworku Flutter, která je
určena pro operační systémy Android a iOS. Aplikace zajišťuje veškerou interakci s
uživatelem — zobrazení restaurací na mapě, rezervaci stolů, správu profilu zákazníka i
administrační rozhraní pro personál restaurace. Komunikace mezi prezentační a
aplikační vrstvou probíhá výhradně prostřednictvím REST API nad protokolem HTTPS
## [2].
Aplikační vrstvu tvoří backendová aplikace vyvinutá ve frameworku Spring Boot.
Backend je strukturován do tří podvrstev — kontrolerů zajišťujících příjem a
zpracování HTTP požadavků, servisní vrstvy obsahující obchodní logiku systému a
repozitářové vrstvy zajišťující přístup k databázi. Toto vrstvové uspořádání zajišťuje
čisté oddělení odpovědností a usnadňuje testování jednotlivých částí systému nezávisle
na sobě [3].
Datovou vrstvu tvoří relační databáze PostgreSQL, která zajišťuje perzistenci veškerých
dat systému — informací o restauracích, stolech, uživatelích a rezervacích. Backend
komunikuje s databází prostřednictvím ORM frameworku, který mapuje databázové
entity na objekty v aplikační vrstvě a zajišťuje typově bezpečný přístup k datům.
Detailní návrh databázového modelu je předmětem kapitoly 3 [4].
Celý systém je nasazen v prostředí Google Cloud Platform. Backendová aplikace běží
jako Docker kontejner ve službě Cloud Run, která zajišťuje automatické škálování
podle aktuální zátěže. Databáze PostgreSQL je provozována ve službě Cloud SQL,
která poskytuje plně spravované databázové prostředí s automatickými zálohami a
vysokou dostupností. Mobilní aplikace je distribuována prostřednictvím Google Play
Store pro platformu Android a Apple App Store pro platformu iOS. Celkový přehled
architektury systému je znázorněn na Obrázku 1 [2].

## 37


Použité zdroje
[1] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
[2] GOOGLE CLOUD. Cloud SQL for PostgreSQL Documentation. [online]. Google
LLC, 2024 [cit. 2025-10-12]. Dostupné z: https://cloud.google.com/sql/docs/postgres
[3] KATAMREDDY, Siva Prasad Reddy a UPADHYAYULA, Sai Subramanyam.
Beginning Spring Boot 3: Build Dynamic Cloud-Native Java Applications and
Microservices. Apress, 2022. ISBN 978-1-4842-8791-0.
[4] POSTGRESQL GLOBAL DEVELOPMENT GROUP. PostgreSQL Documentation.
[online]. PostgreSQL Global Development Group, 2023 [cit. 2025-10-12]. Dostupné z:
https://www.postgresql.org/docs/
## 2.2 Frontend
Prezentační vrstva systému je realizována jako mobilní aplikace vyvinutá ve
frameworku Flutter. Aplikace je navržena pro dvě odlišné skupiny uživatelů —
zákazníky a personál restaurace — přičemž každá skupina má k dispozici vlastní sadu
obrazovek přizpůsobenou jejím potřebám. Obě části aplikace sdílejí společnou kódovou

## 38

základnu, přičemž zobrazení konkrétních obrazovek je řízeno na základě role
přihlášeného uživatele [1].
Aplikace je strukturována podle principu oddělení uživatelského rozhraní od stavové
logiky a datové vrstvy. Uživatelské rozhraní je tvořeno widgety, které se starají
výhradně o vizuální prezentaci dat. Stavová logika zajišťuje správu stavu aplikace a řídí,
jaká data jsou v daném okamžiku zobrazena. Datová vrstva frontendu zajišťuje
komunikaci s backendem prostřednictvím REST API a poskytuje data stavové vrstvě.
Toto oddělení odpovědností usnadňuje testování jednotlivých částí aplikace a
zjednodušuje budoucí rozšiřování [2].
Zákaznická část aplikace se skládá z několika klíčových obrazovek. Hlavní obrazovka
zobrazuje interaktivní mapu s restauracemi v okolí uživatele s možností vyhledávání a
filtrování. Detail restaurace poskytuje informace o podniku včetně digitálního menu a
otevírací doby. Rezervační obrazovka zobrazuje interaktivní 360° pohled na interiér
restaurace s vyznačenými stoly a jejich aktuálním stavem. Dále jsou k dispozici
obrazovky pro správu rezervací, historii návštěv a nastavení uživatelského profilu
včetně preferencí notifikací [1].
Administrační část aplikace určená pro personál restaurace obsahuje obrazovky pro
přehled a správu rezervací, úpravu rozmístění stolů a správu informací o restauraci
včetně digitálního menu. Manažer má navíc k dispozici obrazovku pro správu
uživatelských účtů a přidělování oprávnění zaměstnancům. Přechod mezi zákaznickou a
administrační částí aplikace je řízen autentizačním mechanismem, který po přihlášení
uživatele přesměruje na obrazovky odpovídající jeho roli [1].
Navigace v aplikaci je řešena prostřednictvím hierarchické struktury obrazovek
doplněné o spodní navigační lištu pro přístup k hlavním sekcím aplikace. Tento přístup
odpovídá standardním vzorcům navigace v mobilních aplikacích, na které jsou uživatelé
zvyklí, a minimalizuje kognitivní zátěž při orientaci v systému. Celková struktura
obrazovek zákaznické části aplikace je znázorněna na Obrázku 2 [3].
## 2.3 Backend
Aplikační vrstva systému je realizována jako monolitická backendová aplikace vyvinutá
ve frameworku Spring Boot. Backend zajišťuje veškerou obchodní logiku systému,
zpracování požadavků od klientské aplikace, správu autentizace a autorizace uživatelů a
přístup k databázi. Monolitická architektura byla zvolena s ohledem na rozsah projektu,
přičemž důsledné modulární uspořádání kódu zajišťuje přehlednost a udržovatelnost
aplikace i při jejím případném budoucím rozšiřování [1].
Backend je vnitřně strukturován do tří vrstev, které striktně oddělují jednotlivé
odpovědnosti. První vrstvou jsou kontrolery, které zajišťují příjem HTTP požadavků,
jejich validaci a předání servisní vrstvě. Kontrolery neobsahují žádnou obchodní logiku
— jejich jediným úkolem je mapování příchozích požadavků na volání příslušných
servisních metod a vrácení odpovědi klientovi ve formátu JSON [2].

## 39

Druhou vrstvou je servisní vrstva, která obsahuje veškerou obchodní logiku systému.
Servisní vrstva zpracovává požadavky předané kontrolery, aplikuje příslušná business
pravidla a orchestruje přístup k datům prostřednictvím repozitářové vrstvy. Příkladem
obchodní logiky na této úrovni je ověření dostupnosti stolu při vytváření rezervace,
kontrola překrývajících se časových intervalů nebo ověření oprávnění uživatele k
provedení požadované operace [2].
Třetí vrstvou je repozitářová vrstva, která zajišťuje veškerý přístup k databázi.
Repozitáře zapouzdřují databázové operace a poskytují servisní vrstvě rozhraní pro
práci s daty nezávislé na konkrétní implementaci databáze. Komunikace s databází
PostgreSQL probíhá prostřednictvím ORM frameworku, který zajišťuje mapování mezi
databázovými tabulkami a objekty aplikace a umožňuje pracovat s daty typově
bezpečným způsobem [3].
Zabezpečení backendové aplikace je zajištěno na úrovni každého API endpointu. Každý
příchozí požadavek je ověřen prostřednictvím autentizačního tokenu, na jehož základě
systém identifikuje uživatele a ověří jeho oprávnění k provedení požadované operace.
Endpointy určené pro personál restaurace jsou přístupné pouze uživatelům s příslušnou
rolí, čímž je zajištěno důsledné uplatňování principu minimálního oprávnění [2].
Backend je navržen jako bezstavová aplikace, která neuchovává žádný stav mezi
jednotlivými požadavky. Veškerý stav je persistován v databázi nebo předáván
prostřednictvím autentizačního tokenu. Tento přístup je klíčovým předpokladem pro
horizontální škálování aplikace, protože umožňuje provozovat více instancí backendu
souběžně bez nutnosti sdílení stavu mezi nimi. Celková struktura backendové aplikace a
její vrstvové uspořádání jsou znázorněny na Obrázku 3 [1].

Použité zdroje
[1] NEWMAN, Sam. Building Microservices: Designing Fine-Grained Systems. 2nd
ed. O'Reilly, 2021. ISBN 978-1-492-03402-5.
[2] KATAMREDDY, Siva Prasad Reddy a UPADHYAYULA, Sai Subramanyam.
Beginning Spring Boot 3: Build Dynamic Cloud-Native Java Applications and
Microservices. Apress, 2022. ISBN 978-1-4842-8791-0.
[3] POSTGRESQL GLOBAL DEVELOPMENT GROUP. PostgreSQL Documentation.
[online]. PostgreSQL Global Development Group, 2023 [cit. 2025-10-12]. Dostupné z:
https://www.postgresql.org/docs/
2.4 Komunikace mezi vrstvami
Komunikace mezi prezentační a aplikační vrstvou systému probíhá výhradně
prostřednictvím REST API. REST (Representational State Transfer) je architektonický
styl pro návrh síťových aplikací, který využívá standardní HTTP metody a je postaven

## 40

na principu bezstavové komunikace. Každý požadavek od klienta musí obsahovat
veškeré informace potřebné k jeho zpracování, přičemž server neuchovává žádný stav
mezi jednotlivými požadavky. Tento přístup je v současnosti považován za standard pro
komunikaci mezi mobilními aplikacemi a jejich backendovými službami [1].
Rozhraní REST API je navrženo podle principů RESTful architektury, kde jsou
jednotlivé zdroje systému reprezentovány pomocí URL adres a operace nad nimi jsou
vyjádřeny prostřednictvím standardních HTTP metod. Metoda GET slouží k získání dat,
metoda POST k vytvoření nového záznamu, metoda PUT nebo PATCH k aktualizaci
existujícího záznamu a metoda DELETE k jeho odstranění. Data jsou přenášena ve
formátu JSON, který je lehký, čitelný a nativně podporovaný jak ve Flutteru, tak ve
## Spring Bootu [2].
Veškerá komunikace mezi klientskou aplikací a backendem probíhá prostřednictvím
šifrovaného připojení HTTPS, které zajišťuje ochranu přenášených dat před
odposlechem a neoprávněnou manipulací. Autentizace uživatele je řešena
prostřednictvím tokenu, který klient přikládá ke každému požadavku v hlavičce HTTP.
Backend token ověří a na jeho základě identifikuje uživatele a jeho oprávnění ještě před
zpracováním samotného požadavku [3].
Aby bylo rozhraní API přehledné a dobře udržovatelné, je jeho struktura rozdělena do
logických skupin podle funkčních oblastí systému. Každá skupina endpointů pokrývá
jednu doménu systému — správu uživatelů a autentizaci, správu restaurací a jejich
profilů, správu stolů a jejich rozmístění, správu rezervací a zasílání notifikací. Toto
rozdělení usnadňuje orientaci v API a zjednodušuje jeho budoucí rozšiřování o nové
funkce [2].
Součástí návrhu API je také jednotné zpracování chybových stavů. Každá chybová
odpověď obsahuje standardizovanou strukturu s HTTP stavovým kódem, strojově
čitelným kódem chyby a lidsky čitelnou zprávou popisující příčinu chyby. Tím je
zajištěno, že klientská aplikace může chyby zpracovávat konzistentním způsobem a
zobrazovat uživateli srozumitelné informace o tom, co se stalo a jak situaci řešit.
Přehled hlavních skupin API endpointů je znázorněn na Obrázku 4 [1].

## 41


## 42




## 43

2.1.1. Vrstvová architektura: frontend, backend,
databáze.
2.2. Detailní popis komponent
2.2.1. Frontend: uživatelské rozhraní pro
zákazníky a administrátory.
2.2.2. Backend: logika systému, zpracování dat
a API.
2.2.3. Databáze: relační model pro správu dat.
- Návrh databáze
3.1. Struktura databázového modelu
## 3.1.1. Entity: Uživatelé, Restaurace, Rezervace,
## Objednávky, Menu.
3.1.2. Vztahy mezi entitami.
3.2. Optimalizace pro velké množství dat
3.2.1. Indexy, particionování tabulek, caching.
3.3. Implementace v PostgreSQL

## 44

Praktická část
- Realizace a implementace systému
Implementační část diplomové práce je věnována praktické realizaci navrženého
systému pro digitální správu rezervací a objednávek v gastronomických provozech.
Hlavním cílem této kapitoly je podrobný popis procesu vývoje komplexního
softwarového řešení, který zahrnuje vytvoření robustní serverové části, návrh datové
perzistence a jejich následnou integraci s mobilním uživatelským rozhraním. Na základě
analytické a návrhové fáze práce byl systém dekomponován do dvou hlavních
subsystémů, jimiž jsou serverová část zajišťující aplikační logiku i autorizovanou
správu dat a klientská část představující mobilní aplikaci ve frameworku Flutter pro
interakci koncového uživatele se systémem.
Při vlastní implementaci bylo postupováno s respektováním principů vícevrstvé
architektury. Tento strukturní přístup byl zvolen pro zajištění vysoké míry separace
odpovědností, což usnadňuje údržbu kódu, jeho testovatelnost a budoucí rozšiřitelnost
celého celku. Architektonický rámec byl rozdělen do tří základních rovin, které tvoří
datová vrstva zajišťující perzistenci dat a integritu relačního modelu, logická vrstva
zahrnující servisní komponenty pro zpracování byznys logiky a prezentační vrstva
definující rozhraní pro komunikaci s uživatelem.
V souladu s metodickými pokyny pro vypracování diplomových prací je v celém textu
důsledně využíváno pasivum. Při realizaci systému byl rovněž kladen důraz na
systematickou správu zdrojového kódu prostřednictvím distribuovaného systému Git.
Použití vzdáleného úložiště na platformě GitHub umožnilo transparentní sledování
postupu prací, bezpečné zálohování a integritu zdrojových souborů v průběhu celého
životního cyklu vývoje. Tento proces verzování byl aplikován jednotně na všechny
komponenty systému, čímž byla zajištěna konzistence vývojových etap popsaných v
následujících částech práce.
4.1. Správa verzí a proces vývoje
Při realizaci celého softwarového systému byl kladen důraz na systematickou správu
zdrojového  kódu  a  transparentní  sledování  postupu  prací  v  souladu  s  požadavky  na
samostatnou odbornou činnost. Pro tyto účely byl zvolen distribuovaný systém správy
verzí  Git,  který  v  kombinaci  se  vzdáleným  úložištěm  na  platformě  GitHub  tvořil
základní infrastrukturu pro ukládání a zálohování všech částí projektu. Použití tohoto
nástroje  umožnilo  efektivní  sledování  historie  změn,  větvení  kódu  při  implementaci
nových funkcionalit a zajistilo integritu zdrojových souborů v průběhu celého životního
cyklu vývoje. Tento  proces  verzování  byl  aplikován  jednotně  na  backendovou  i
frontendovou část systému, čímž byla zajištěna konzistence vývojových etap a splnění
formálních požadavků na dokumentaci vývoje.

## 45

Součástí metodiky vývoje bylo pravidelné provádění verzovacích záznamů (commitů) s
výstižným  popisem  provedených  změn,  což  umožnilo  detailní  rekonstrukci  postupu
implementace. Vzdálený repozitář na platformě  GitHub slouží zároveň  jako digitální
příloha  práce,  která  zpřístupňuje  zdrojové  kódy  pro  účely  obhajoby a  následné
verifikace dosažených výsledků.
4.2. Realizace serverové části (Backend)
Serverová část systému představuje klíčový integrační uzel, který zajišťuje komplexní
zpracování dat, implementaci aplikační logiky a zprostředkování komunikace s
databázovou vrstvou. Pro realizaci byl zvolen framework Spring Boot, postavený na
platformě Java Spring, který byl vybrán pro svou robustnost, vysokou míru bezpečnosti
a širokou podporu moderních architektonických standardů pro vývoj podnikových
aplikací. Hlavním úkolem této komponenty je obsluha požadavků přicházejících z
mobilní aplikace prostřednictvím rozhraní REST API, zajištění datové perzistence a
validace byznys procesů spojených se správou gastronomických objednávek a rezervací.
V rámci implementace backendu bylo postupováno v souladu s principy vrstvené
architektury, což umožnilo striktní oddělení odpovědností mezi datovou, servisní a
komunikační rovinou. Tento přístup výrazně přispívá k lepší testovatelnosti celého
systému a usnadňuje jeho budoucí rozšiřitelnost o nové funkcionality.
4.2.1 Konfigurace vývojového prostředí a inicializace projektu
Pro realizaci serverové komponenty bylo zvoleno integrované vývojové prostředí
IntelliJ IDEA ve verzi Ultimate, a to především pro jeho pokročilou podporu
ekosystému Spring Boot a nástroje pro správu databázových operací. V rámci vývoje
byla využita akademická licence aktivovaná prostřednictvím univerzitního účtu. Jako
základní runtime platforma byl stanoven Java Development Kit (JDK) verze 17, jehož
volba byla podmíněna statusem dlouhodobé podpory (LTS), zaručujícím stabilitu a
bezpečnost systému.
Proces sestavení aplikace a správa softwarových závislostí byly automatizovány
nástrojem Apache Maven. Veškeré externí knihovny jsou definovány v konfiguračním
souboru pom.xml, což zajišťuje konzistentní chování aplikace a snadnou
replikovatelnost vývojového prostředí. K celkové přehlednosti a ergonomii při práci se
zdrojovým kódem přispěla instalace doplňků Material Theme UI a Rainbow Brackets,
které usnadňují orientaci v komplexních vnořených strukturách kódu.
Základní rámec aplikace byl vytvořen prostřednictvím webového rozhraní Spring
Initializr, které definovalo výchozí technické parametry a zahrnulo nezbytné knihovny
pro implementaci rozhraní REST API (Spring Web), objektově-relační mapování
(Spring Data JPA) a konektivitu s databázovým systémem PostgreSQL. Po importu
projektu byla vytvořena adresářová struktura odpovídající standardům frameworku,
která striktně odděluje zdrojové kódy, konfigurační soubory a testovací skripty.

## 46

4.2.2 Struktura projektu a konfigurace souborů
Vygenerovaný projekt vykazuje standardizovanou adresářovou strukturu odpovídající
konvencím frameworku Spring Boot, přičemž každá komponenta plní specifickou roli v
rámci celkového ekosystému aplikace. Z hlediska interní konfigurace vývojového
prostředí obsahuje složka .idea metadata prostředí IntelliJ IDEA, která uchovávají
informace o nastavení projektu, cestách k JDK, verzích pluginů a struktuře modulu.
Tyto soubory nejsou určeny pro manuální úpravu vývojářem a standardně jsou
vyloučeny z verzovacího systému prostřednictvím souboru .gitignore, neboť jejich
obsah je specifický pro lokální vývojové prostředí. Podobně adresář .mvn zajišťuje
konfiguraci nástroje Apache Maven Wrapper, který umožňuje spouštění Mavenu bez
nutnosti jeho globální instalace v operačním systému. Součástí adresáře jsou metadata a
soubor maven-wrapper.properties, který explicitně definuje verzi Mavenu
používanou při kompilaci projektu.
Adresář src/main/java reprezentuje primární úložiště zdrojových souborů aplikace.
Zde se nachází hlavní balíček com.checkfood.checkfoodservice, který slouží jako
výchozí jmenný prostor pro strukturování aplikační logiky do specializovaných
podsložek. V počáteční fázi obsahuje pouze základní spouštěcí třídu
CheckfoodServiceApplication, jež představuje vstupní bod celé aplikace a
inicializuje Spring Boot kontext. Vlastní aplikační logika byla následně
dekomponována do funkčních balíčků v souladu s principy vícevrstvé architektury.
Balíček entity byl vyhrazen pro definici datových modelů, zatímco balíčky
repository a service byly určeny pro rozhraní zajišťující přístup k datům a
implementaci byznys logiky. Komunikační vrstva byla soustředěna do balíčku
controller, který zprostředkovává obsluhu HTTP požadavků. Tato systematická
organizace tvoří stabilní základ pro následnou integraci s cloudovou infrastrukturou.
Paralelně se zdrojovými kódy existuje adresář src/main/resources, který zahrnuje
veškeré statické a konfigurační soubory využívané aplikací. Po kompilaci se jeho obsah
umísťuje do classpath, odkud jej může aplikace přímo načítat za běhu. Podadresář
static/ je určen pro statické soubory včetně obrázků, CSS stylů a JavaScriptových
skriptů, které jsou servírovány přímo klientovi bez nutnosti serverového zpracování.
Podadresář templates/ je rezervován pro šablony uživatelského rozhraní, typicky při
použití templating engine Thymeleaf, avšak v tomto projektu zůstává složka nevyužita,
neboť prezentační vrstva je implementována samostatně prostřednictvím mobilní
aplikace vytvořené ve frameworku Flutter. Klíčovým prvkem tohoto adresáře je soubor
application.properties, který představuje centrální konfigurační bod aplikace a
slouží k definici základních parametrů běhu systému, mezi něž patří název projektu,
port serveru, parametry připojení k databázi, úroveň logování nebo profily prostředí.
Není-li komunikační port explicitně specifikován, framework Spring Boot standardně
spouští vestavěný server Tomcat na portu 8080. Celkové nastavení bylo finalizováno v
tomto konfiguračním souboru, kde byl mimo jiné definován komunikační port 8081 za
účelem eliminace konfliktů s jinými lokálními službami. Aplikace tak běží na portu
8081 a je jednoznačně identifikovatelná názvem checkfood-service. Tento soubor
centralizuje nastavení celého systému a umožňuje jeho flexibilní úpravu bez nutnosti
zásahu do zdrojového kódu.

## 47

Z hlediska testovací infrastruktury obsahuje adresář src/test/java jednotkové a
integrační testy aplikace. V rámci generovaného projektu je zde automaticky vytvořena
třída CheckfoodServiceApplicationTests.java, kterou Spring Boot generuje pro
ověření správného načtení aplikačního kontextu a základní životaschopnosti
konfigurace.
Projekt dále obsahuje řadu podpůrných souborů zajišťujících korektní fungování
verzovacího systému a buildovacího procesu. Soubor .gitattributes definuje
specifické chování verzovacího systému Git pro jednotlivé typy souborů, zejména
způsob zpracování konců řádků mezi odlišnými operačními systémy (Windows/Linux)
nebo pravidla pro slučování změn při konfliktech, čímž přispívá k udržení
konzistentního formátování zdrojových souborů napříč heterogenními vývojovými
prostředími. Soubor .gitignore specifikuje, které soubory a adresáře nemají být
sledovány verzovacím systémem Git, a tímto mechanismem se zabraňuje verzování
dočasných, generovaných nebo systémově specifických souborů, které nejsou relevantní
pro běh aplikace. Informační soubor HELP.md obsahuje stručné vysvětlení projektu
vygenerované nástrojem Spring Initializr a uvádí základní odkazy na oficiální
dokumentaci Spring Boot a komunitní zdroje, přičemž slouží výhradně jako doplňkový
informační dokument bez vlivu na funkčnost projektu.
Soubory mvnw a mvnw.cmd reprezentují Maven Wrapper, který umožňuje spouštění
Mavenu přímo z projektu bez nutnosti jeho systémové instalace. Soubor mvnw se
používá v prostředí Linux/MacOS, zatímco mvnw.cmd je určen pro platformu Windows.
Wrapper garantuje jednotnou verzi nástroje Maven napříč různými vývojovými
prostředími. Nejdůležitějším konfiguračním prvkem z hlediska správy závislostí je
soubor pom.xml, který představuje hlavní konfigurační soubor Maven projektu.
Definuje závislosti, verze knihoven, buildovací proces i metadata projektu. Díky tomuto
souboru lze projekt sestavit jediným příkazem mvn clean install, přičemž všechny
potřebné knihovny se automaticky stáhnou z Maven Central Repository. Tento soubor
tvoří základ pro správu závislostí a reproducibilitu buildovacího procesu.
4.2.1. Implementace  kontejnerizace  a  správa
konfiguračních profilů
Pro zajištění maximální přenositelnosti systému a sjednocení vývojového prostředí s
budoucím produkčním nasazením byla zvolena strategie kompletní kontejnerizace
pomocí platformy Docker. Tento přístup umožňuje izolovat aplikaci i její závislosti do
samostatných jednotek, čímž je eliminována závislost na specifické konfiguraci
hostitelského operačního systému a zaručena identická funkčnost napříč různými
platformami.
Architektura kontejnerizace je definována souborem Dockerfile, který specifikuje
postup sestavení obrazu aplikace. Výsledný kontejner vystavuje port 8081 a spouští
aplikaci s parametry pro aktivaci Spring profilu a kódování UTF-8. Pro sestavení je
využíván obraz maven:3.8.5-eclipse-temurin-17, který zajišťuje kompilaci

## 48

projektu a stažení závislostí. Runtime prostředí je postaveno na minimalistickém obrazu
eclipse-temurin:17-jre-focal, což optimalizuje výslednou velikost kontejneru.
Orchestrace celého systému je řízena souborem docker-compose.yml, který definuje
databázovou službu jako klíčovou komponentu lokálního vývojového prostředí.
Databázová služba (db) využívá obraz postgres:15-alpine a je identifikována jako
checkfood-db. Inicializační parametry databáze jsou spravovány prostřednictvím
direktivy env_file, která načítá proměnné ze souboru .env.local. Tento
mechanismus umožňuje centralizovanou správu citlivých údajů mimo verzovací systém
a oddělení konfigurace pro různá prostředí. V sekci environment jsou definovány klíče,
které PostgreSQL očekává (POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD),
přičemž hodnoty jsou automaticky substituovány z načteného souboru .env.local.
Port 5432 je mapován na hostitelský systém pro umožnění přímého připojení z
vývojového prostředí. Direktiva restart: always zajišťuje automatické obnovení
služby při selhání.
Kritickým prvkem konfigurace je sekce healthcheck, která definuje mechanismus
ověřování dostupnosti databáze před spuštěním závislých služeb. Kontrolní příkaz
pg_isready -U ${DB_USERNAME} -d checkfood ověřuje připravenost databázového
serveru v intervalech 10 sekund s timeoutem 5 sekund a maximálně 5 opakováními.
Tento mechanismus zajišťuje, že aplikační služby se nespustí dříve, než je databáze plně
funkční, čímž je eliminováno riziko chyb spojení při startu systému.
Pro zajištění trvalého uchování dat je definován perzistentní svazek postgres_data,
který mapuje vnitřní databázové úložiště /var/lib/postgresql/data na hostitelský
systém. Tímto mechanismem jsou data zachována i po odstranění kontejneru.
Komunikace mezi službami probíhá prostřednictvím izolované síťové infrastruktury
checkfood-network s bridge driverem, ve které spolu komponenty komunikují pomocí
interních DNS názvů služeb namísto statických IP adres.
Spuštění kontejnerizovaného prostředí je realizováno příkazem docker-compose up -
d, který na základě konfiguračního souboru stáhne požadované obrazy, vytvoří
kontejnery, inicializuje síťovou infrastrukturu a spustí služby v režimu na pozadí. Stav
běžících kontejnerů lze ověřit příkazem docker-compose ps, který zobrazuje seznam
aktivních služeb a jejich aktuální stav včetně výsledků healthcheck testů. Pro zastavení
služeb slouží příkaz docker-compose stop, zatímco kompletní odstranění kontejnerů
včetně síťových struktur zajišťuje příkaz docker-compose down. Pro inspekci logů je k
dispozici příkaz docker-compose logs db, který zobrazuje výstup databázové služby
a je nezbytný pro diagnostiku problémů při inicializaci.
Na implementaci kontejnerizované infrastruktury navazuje systém správy konfigurací
pomocí aplikačních profilů frameworku Spring Boot (Spring Profiles). Tento
mechanismus byl zvolen pro efektivní separaci parametrů, jako jsou adresy
databázových serverů, přístupové údaje či úrovně logování, bez nutnosti zásahu do
zkompilovaného kódu. V rámci systému CheckFood byly definovány tři primární
profily, které reflektují jednotlivé fáze životního cyklu aplikace.

## 49

Prvním z nich je lokální profil (local), který je optimalizován pro vývoj v kontejneru
Docker a využívá podrobné logování na úrovni DEBUG pro účely ladění aplikace.
Testovací profil (test) je určen pro automatizovanou verifikaci funkcionality v
izolovaném prostředí. Posledním je produkční profil (prod), jenž je konfigurován pro
běh v cloudu s důrazem na bezpečnost a optimalizaci výkonu. Technicky je tato
separace zajištěna soubory ve formátu application-{profile}.properties, které
jsou umístěny v adresáři src/main/resources. Aktivace konkrétního profilu probíhá
dynamicky při spuštění kontejneru prostřednictvím proměnné
SPRING_PROFILES_ACTIVE, která je definována v příslušném .env souboru a předávána
do kontejneru. V cloudovém prostředí Google Cloud Run je proměnná nastavena v
konfiguraci služby, což umožňuje změnu profilu bez nutnosti opětovného sestavení
Docker obrazu.
4.2.2. Implementace REST API pro funkce
(registrace, rezervace, objednávky).

## User:
V rámci návrhu a implementace backendové části systému CheckFood byla vytvořena
entita User, která představuje perzistentní model uživatelského účtu. Tato entita byla
realizována s využitím specifikace JPA a frameworku Spring Boot, který poskytuje
prostředí pro práci s relační databází prostřednictvím objektově relačního mapování. Při
implementaci byly rovněž využity anotace z knihovny Lombok, které slouží ke
generování kódu a významně usnadňují práci s datovými třídami.
Entita je označena anotací Entity, která určuje, že se jedná o objekt, jenž bude ukládán
do databáze. Anotace Table s parametrem name definuje název fyzické tabulky. Každý
záznam je jednoznačně určen atributem id. Tento atribut je opatřen anotací Id a dále
anotací GeneratedValue se strategií GenerationType.IDENTITY, která deklaruje, že
identifikátor je generován databází při vložení nového záznamu. Tato kombinace
odpovídá běžně používanému způsobu práce s primárními klíči v relačních databázích.
Atributy email a username jsou opatřeny anotací Column s nastavením nullable a
unique. Nullable zajišťuje, že uvedené hodnoty musí být vždy vyplněny, a parametr
unique vynucuje jejich jedinečnost v rámci tabulky. Tento přístup podporuje
konzistentní ukládání dat a zabraňuje duplicitním registracím uživatelů. Atribut
password obsahuje heslo uživatele ve formě hashované hodnoty. Přestože samotné
hashování probíhá mimo entitu, anotace Column zajišťuje základní omezení nad délkou
a nepřípustnost prázdné hodnoty.
Role uživatele je uložena v atributu role, který je typu výčtového typu Role. Uložení
výčtu je řízeno anotací Enumerated se strategií EnumType.STRING. Tato volba
umožňuje ukládání čitelné textové hodnoty, nikoliv číselného indexu. Uložené hodnoty

## 50

tak odpovídají názvům definovaným ve výčtu Role, který zahrnuje uživatele,
zaměstnance, manažera a vlastníka. Tento způsob reprezentace přispívá k větší
přehlednosti databázových záznamů a zjednodušuje jejich pozdější rozšiřování.

Entita dále obsahuje auditní metadata createdAt a updatedAt. Tato metadata jsou
spravována pomocí anotací CreationTimestamp a UpdateTimestamp. První uvedená
anotace zajistí automatické nastavení časové hodnoty při vytvoření záznamu, zatímco
druhá aktualizuje čas při každé změně záznamu. Díky těmto anotacím není nutné
manipulovat s časovými údaji v aplikační logice. Správa těchto hodnot je zajištěna plně
automatizovaně na úrovni perzistentní vrstvy, což odpovídá osvědčenému návrhovému
principu oddělení odpovědností.
Atribut active umožňuje reprezentovat stav uživatelského účtu. Pomocí anotace Column
nastavené na nullable = false je zajištěno, že položka stavu je vždy vyplněna. Hodnota
atributu je inicializována prostřednictvím generovaného builderu, který poskytuje
anotace Builder. Tento builder dovoluje jednoduše vytvářet instance třídy a zároveň
nastavit výchozí stav účtu jako aktivní.
Pro zajištění čitelnosti a minimalizaci duplicitního kódu byla entita doplněna o anotace
z knihovny Lombok. Anotace Getter a Setter generují přístupové metody ke všem
atributům. Anotace NoArgsConstructor a AllArgsConstructor vytvářejí potřebné
konstruktory a anotace Builder umožňuje využívat návrhový vzor builder při vytváření
nových instancí. Anotace ToString s vyloučením atributu password zamezuje
neúmyslnému zobrazení hesla při ladění nebo logování.
Výsledkem je entita User, která splňuje požadavky na správu uživatelských dat,
zajišťuje bezpečnou práci s autentizačními údaji, podporuje auditní funkce a zároveň
využívá moderní postupy při implementaci datových modelů v jazyce Java. Konstrukce
entity respektuje zásady oddělení zodpovědností, což umožňuje její snadnou integraci
do vyšších vrstev aplikace a její případné budoucí rozšíření.

## 51



## 52

4.2.3. Zabezpečení API pomocí JWT a role-
based access control.
4.3. Frontend (Flutter)
4.3.1. Vytvoření uživatelského rozhraní pro
zákazníky a administrátory.
4.3.2. Klíčové obrazovky (rezervace,
objednávky, historie, statistiky).
4.3.3. Komunikace s backendem přes REST
## API.
4.4. Nasazení  v  cloudovém  prostředí  Google
## Cloud Platform
Po úspěšném dokončení lokálního vývoje a testování aplikace v kontejnerizovaném
prostředí následuje fáze nasazení do produkčního cloudového prostředí. Pro tento účel
byla zvolena platforma Google Cloud Platform (GCP), která poskytuje škálovatelnou
infrastrukturu, spravované databázové služby a nástroje pro automatizované nasazování
kontejnerových aplikací.
4.4.1. Inicializace   cloudového   projektu   a
konfigurace služeb
Pro nasazení systému CheckFood je nezbytné založit nový projekt v prostředí Google
Cloud Platform. Projekt v GCP představuje základní organizační jednotku, která
sdružuje veškeré cloudové služby, oprávnění, nastavení fakturace a přidělené zdroje. Po
přihlášení do konzole Google Cloud se v rámci rozhraní zvolí vytvoření nového
projektu a zadá se jeho název, například checkfood-system. Systém následně
automaticky vygeneruje jedinečné identifikátory, jako jsou Project ID a Project number.
Po potvrzení vytvoření je dostupný výchozí přehled projektu (Dashboard), který slouží
ke správě služeb typu Compute Engine, Cloud Storage, Cloud SQL či APIs & Services.

## 53

Využívání služeb GCP je podmíněno přiřazením aktivního fakturačního účtu (Billing
account) k danému projektu. Bez této konfigurace není možné spouštět většinu služeb,
včetně databázového systému Cloud SQL a výpočetní platformy Cloud Run. Novým
uživatelům je po registraci poskytnut zkušební kredit ve výši 300 USD s platností 90
dní, který lze využít pro čerpání napříč službami GCP. Pro zřízení fakturace se v
konzoli GCP využívá sekce Billing, kde se provede propojení s platební metodou a
následně s aktuálním projektem. Zkušební kredit je dostupný okamžitě po aktivaci a
pokrývá provoz vývojového prostředí, včetně instancí databáze Cloud SQL a backendu
v rámci Cloud Run.
Jednotlivé služby v rámci Google Cloud Platform jsou řízeny dedikovanými rozhraními
API, která vyžadují explicitní aktivaci před jejich prvním použitím. Bez inicializace
těchto rozhraní není možné dané prostředky využívat ani spravovat prostřednictvím
grafického rozhraní Google Cloud Console nebo nástrojů příkazové řádky. V rámci
projektu checkfood-system byla aktivována řada klíčových rozhraní zajišťujících
funkčnost celého ekosystému. Konkrétně se jednalo o Cloud SQL Admin API, které je
určeno pro komplexní správu databázových instancí PostgreSQL včetně jejich
konfigurace a zálohování, a Compute Engine API zajišťující základní výpočetní
infrastrukturu. Dále bylo nezbytné aktivovat Service Networking API pro zřízení
privátního síťového propojení mezi databází Cloud SQL a backendovou částí aplikace.
Pro samotné nasazení a orchestraci kontejnerových aplikací bylo využito Cloud Run
API, přičemž správa a ukládání Docker obrazů byla zajištěna prostřednictvím Artifact
Registry API. Proces aktivace těchto služeb byl realizován v sekci APIs & Services, kde
byla jednotlivá rozhraní v rámci knihovny vyhledána a následně autorizována pro
provoz v daném projektu.
4.4.2. Nasazení  databázové  vrstvy  pomocí  Cloud
## SQL
Pro produkční nasazení systému byla zvolena služba Cloud SQL, která představuje plně
spravované prostředí pro instanci PostgreSQL. Tato platforma zajišťuje klíčové aspekty
provozu,  jako  jsou  automatizované zálohy,  vysoká  dostupnost  a  integrovaný
monitoring. Na rozdíl od vývojové fáze, kdy byla databáze provozována lokálně v rámci
kontejnerizace  Docker,  Cloud  SQL  eliminuje  administrativní  zátěž  spojenou  s  ruční
správou databázového serveru a garantuje vysokou úroveň spolehlivosti a bezpečnosti
odpovídající podnikovým standardům.
Samotná  inicializace  instance  v prostředí Google Cloud Console  vyžadovala definici
specifických  parametrů,  především  volbu  verze  PostgreSQL  15  a  výběr  regionu  s
ohledem  na  minimalizaci latence a zajištění dostupnosti dat. V rámci konfigurace byl
zvolen  typ  výpočetního  zdroje  odpovídající  předpokládanému  zatížení  aplikace.  Pro
zajištění  kontinuity  provozu  byla  využita  konfigurace  s  vysokou  dostupností  (High
Availability),  která  automaticky  generuje  záložní  repliku  v  odlišné  zóně  dostupnosti.
Součástí nastavení je rovněž definice retenčního období pro automatické zálohy a určení
časového okna pro jejich realizaci.

## 54

Z hlediska zabezpečení infrastruktury je prioritou korektní nastavení síťového přístupu.
Systém  využívá privátní IP připojení prostřednictvím  VPC peeringu, případně Cloud
SQL  Auth  Proxy,  což  zajišťuje  plně  šifrovanou  komunikaci  a  zamezuje  expozici
databáze do veřejné sítě. Správa autentizačních údajů je řešena integrací služby Google
Secret Manager. Tento přístup umožňuje bezpečné ukládání a případnou rotaci citlivých
údajů,  čímž  odpadá  nutnost  jejich  statického  zápisu  v  konfiguračních  souborech
aplikace a zvyšuje se celková odolnost systému proti neoprávněnému přístupu.
Nasazení aplikační vrstvy pomocí Cloud Run
Aplikační vrstva systému CheckFood je nasazena prostřednictvím služby Google Cloud
Run, která poskytuje plně spravovanou platformu pro běh kontejnerových aplikací s
automatickým škálováním podle aktuální zátěže. Cloud Run umožňuje nasazení Docker
obrazů sestavených v lokálním vývojovém prostředí bez nutnosti správy serverové
infrastruktury.
Proces nasazení začína přenesením Docker obrazu do Google Artifact Registry, který
slouží jako centralizované úložiště kontejnerových artefaktů. Obraz je označen tagem
odpovídajícím verzi aplikace a region registru je zvolen tak, aby minimalizoval latenci
při nasazování. Následně je v Cloud Run vytvořena nová služba s odkazem na uložený
obraz. Konfigurace služby zahrnuje nastavení environmentálních proměnných, které
aktivují produkční profil Spring Boot (SPRING_PROFILES_ACTIVE=prod) a definují
parametry připojení k databázi Cloud SQL.
Cloud Run automaticky zajišťuje HTTPS připojení prostřednictvím spravovaných SSL
certifikátů, implementuje load balancing a poskytuje možnost nastavení autoscaling
pravidel, která definují minimální a maximální počet instancí běžících současně. Služba
také poskytuje integrovaný monitoring a logování prostřednictvím Google Cloud
Operations, což umožňuje sledování výkonu aplikace, detekci chyb a analýzu využití
zdrojů v reálném čase.

## 55

- Testování systému
5.1. Testování backendu
5.1.1. Unit testy API endpointů.
5.1.2. Zátěžové testy pomocí nástrojů jako
JMeter nebo k6.
5.2. Testování frontendu
5.2.1. Funkční testy (přihlášení, rezervace,
platby).
5.2.2. Responsivita na různých zařízeních.
5.3. Testování integrace
5.3.1. Ověření komunikace mezi frontendem,
backendem a databází.
- Nasazení systému
6.1. Zaregistrování domény
6.1.1. Výběr vhodného názvu a registrace přes
poskytovatele (např. Google Domains, Wedos).

## 56

6.2. Publikace aplikace na Google Play Store a
## Apple App Store
- Vyhodnocení výsledků
7.1. Splnění požadavků
7.2. Výkonnost systému na základě testů


## 57

## Literatura
- MCADAMS,  David. Game-changer:  game  theory  and  the  art  of  transforming
strategic situations. místo neznámé : W.W. Norton & Company, 2014.
- MAŇAS,  Miroslav. Teorie  her  a  optimální  rozhodování. Praha :   SNTL -
Nakladatelství technické literatury, 1974.
- NASH,  John. Equilibrium  points  in  n-person  gameProceedings  of  the  National
Academy  of  Sciences  of  the  United  States  of America. místo neznámé :  Proceedings  of
the  National  Academy  of  Sciences of the United States of America, 1950. stránky 48-
## 49. ISSN: 0027-8424.
- FIALA, Petr a DLOUHÝ, Martin. Teorie ekonomických a politických her. [Online]
- vydání v elektronické podobě, Praha : Nakladatelství Oeconomica, 2020. ISBN 978-
## 80-245-2366-8.
- ŠUBRT, Tomáš. Ekonomicko-matematické metody. 3. upravené a rozšířené vydání.
Plzeň : Vydavatelství a nakladatelství Aleš Čeněk, 2019. ISBN 978-80-7380-762-7.
- OSBORNE,  Martin  J. An  introduction  to  game  theory. New  York :  Oxford
University Press, 2004. ISBN 978-0-19-512895-6.
- ČEJKA,  Jiří. Teorie  rozhodování - řešené  příklady  a  příklady  na  procvičování.
České  Budějovice :  Vysoká  škola  technická  a  ekonomická  v  Českých  Budějovicích,
## 2020. ISBN 978-80-7468-172-1.
- PEREGRIN,  Jaroslav. Člověk v zrcadle teorie her: jak nám matematika a filozofie
pomáhají zjišťovat, co jsme zač. Praha : Dokořán, 2021. ISBN 978-80-7675-012-8.
- KROPÁČ, Jiří a DOUBRAVSKÝ, Karel. Statistika C: statistická regulace, indexy
způsobilosti, řízení zásob, statistické přejímky, maticové hry. Třetí,  rozšířené  vydání.
Brno : Akademické nakladatelství CERM, 2020. ISBN 978-80-7623-035-4.

## 58

- ZÍSKAL,  Jan  a  HAVLÍČEK,  Jaroslav. Ekonomicko  matematické  metody  I:
studijní texty pro distanční studium. Praha : Česká zemědělská univerzita, 1998.  ISBN
## 80-213-0462-6.
- DANIŠ, Stanislav. Základy programování v prostředí Octave a Matlab. Vydání
druhé,  upravené  a  rozšířené.  Odborná  edice  Matfyzpress.  Praha :   MatfyzPress,
nakladatelství Matematicko-fyzikální fakulty Univerzity Karlovy, 2022. ISBN 978-80-
## 7378-474-4.
- ZAPLATÍLEK, Karel a DOŇAR, Bohuslav. MATLAB pro začátečníky. 2.  vyd.
Praha : BEN - technická literatura, 2005. ISBN 80-7300-175-6.



## 59


Seznam obrázků

Nenalezena položka seznamu obrázků.
Seznam tabulek
Nenalezena položka seznamu obrázků.

## 60


Zadání bakalářské práce
## Autor:
## Bc. Rostislav Jirák
## Studium: I2000827
Studijní program: B1802 Aplikovaná informatika
Studijní obor: Aplikovaná informatika
Název bakalářské práce:
Teorie her v ekonomii

Název bakalářské práce AJ: Game theory in Economics
Cíl, metody, literatura, předpoklady:
Cílem práce je sestavit přehled základních typů her a způsobů jejich řešení v oblasti
ekonomie.
## Osnova:
## 1. Úvod
- Cíl práce
- Teoretická část
- Matematické modely her
- Hra s konstantním součtem
- Hra s nekonstantním součtem
- Hra v rozvinutém tvaru
- Kooperativní hry s více hráči
- Koaliční hry
- Rozhodování při riziku a neurčitosti
- Rozhodování při riziku
- Rozhodování při neurčitosti
- Praktická část
- Aplikace teorie her
- Lineární programování
- Algoritmy a zpracování dat v prostředí MATLAB
## 5. Závěr
- Seznam zdrojů
## 7. Přílohy
- Seznam obrázků
- Seznam algoritmů
MAŇAS, Miroslav. 1974. Teorie her a optimální rozhodování. Praha: SNTL –
Nakladatelství technické literatury. ISBN 04‑012‑74.

## 61

FIALA, Petr, DLOUHÝ, Martin. Teorie ekonomických a politických her. Praha:
Nakladatelství Oeconomica, 2020. ISBN 978‑80‑245‑2366‑8.
JURÁNKOVÁ,  Klára. Maticové  hry  s  využitím lineární  algebry [online]. Brno, 2018 [cit.
2023‑10‑12]. Dostupné z: https://theses.cz/id/ef0pqm/. Bakalářská práce. Masarykova
univerzita, Přírodovědecká fakulta. Vedoucí práce doc. Mgr. Josef Šilhan, Ph.D.

Zadávající pracoviště:
Katedra informatiky a kvantitativních metod,
Fakulta informatiky a managementu

Vedoucí práce: doc. RNDr. Pavel Pražák, Ph.D.
Oponent: prof. RNDr. PhDr. Antonín Slabý, CSc.
Datum zadání závěrečné práce: 26.1.2021
