# Průběh kurzu po týdnech

Co která skupina v kterém týdnu probrala. Týdny jsou kalendářní týdny semestru; kód najdete
v týdenní složce, ve složce své skupiny (např. `W04-State/monday-sk-2/`); číslo složky odpovídá týdnu semestru.

🟩 hotovo · ⬜ plánováno · – bez výuky

*Aktualizováno 27. 10. 2026.*

## Kde je která skupina – celý semestr

Řádek = skupina, sloupec = týden semestru (datum je pondělí toho týdne). Slovo agent 🟠 = tuhle část kódu píše agent (Claude Code), vy ho čtete, testujete a upravujete. Podrobnosti ke každému týdnu jsou níž.

Než schválíte kód od agenta: **[Na co si dát pozor, když kód píše agent](agent-gotchas.md)** – chyby, které agent v tomhle semestru opravdu udělal, a co ověřit.

| Skupina | **1**<br>14.&nbsp;9.<br>Swift základy | **2**<br>21.&nbsp;9.<br>SwiftUI rozložení | **3**<br>28.&nbsp;9.<br>SwiftUI rozložení | **4**<br>5.&nbsp;10.<br>`@State`, první app od agenta | **5**<br>12.&nbsp;10.<br>`@Binding`, `Form`: BMI | **6**<br>19.&nbsp;10.<br>`@Observable`: TODO | **7**<br>26.&nbsp;10.<br>Síť a concurrency: Weather | **8**<br>2.&nbsp;11.<br>Notes, `NavigationStack` | **9**<br>9.&nbsp;11.<br>SwiftData: Recipe Book | **10**<br>16.&nbsp;11.<br>App Intents: Habit Tracker | **11**<br>23.&nbsp;11.<br>AI v appce: Journal Summariser | **12**<br>30.&nbsp;11.<br>Semestrální projekt | **13**<br>7.&nbsp;12.<br>Semestrální projekt | **14**<br>14.&nbsp;12.<br>Semestrální projekt, termíny testu |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| `monday-sk-1` · Po 10:00 | 🟩 Swift, první app | 🟩 modifikátory, stacky, views | svátek | 🟩 `@State` ručně, agent 🟠 příště | 🟩 BMI od agenta 🟠; ručně `ForEach`, `TextField`, `Slider`, `@Binding`, BMI | 🟩 ručně sdílení dat (`@Observable` + `.environment`, sheet přes `@Bindable`, `dismiss`); TODO od agenta 🟠 | 🟩 Weather od agenta 🟠 z prvního PRD (vyměnil API); ručně příspěvky z fake JSON API | ⬜ Notes: PRD → agent 🟠 → test → oprava; ručně `NavigationStack` | ⬜ Recipe Book od agenta 🟠, test restartu; ručně `@Model`, `@Query` | ⬜ Habit Tracker od agenta 🟠; ručně `AppIntent` | ⬜ Journal Summariser od agenta 🟠, eval; ručně `LanguageModelSession` | ⬜ semestrální projekt s agentem 🟠 (1/3) | ⬜ semestrální projekt s agentem 🟠 (2/3) | ⬜ semestrální projekt s agentem 🟠 (3/3), odevzdání |
| `monday-sk-2` · Po 14:00 | 🟩 Swift základy, první app | 🟩 modifikátory, stacky, views | svátek | 🟩 `@State` ručně, hra od agenta 🟠 | 🟩 BMI od agenta 🟠; ručně `ForEach`, `@Binding`, `TextField`, `Slider`, BMI (dohnáno 19. 10.) | 🟩 ručně BMI, sdílení dat (`@Observable`, sheet přes `@Bindable`); TODO od agenta 🟠, úprava ručně | 🟩 Weather od agenta 🟠 (první PRD); ručně příspěvky z fake JSON API | ⬜ Notes: PRD → agent 🟠 → test → oprava; ručně `NavigationStack` | ⬜ Recipe Book od agenta 🟠, test restartu; ručně `@Model`, `@Query` | ⬜ Habit Tracker od agenta 🟠; ručně `AppIntent` | ⬜ Journal Summariser od agenta 🟠, eval; ručně `LanguageModelSession` | ⬜ semestrální projekt s agentem 🟠 (1/3) | ⬜ semestrální projekt s agentem 🟠 (2/3) | ⬜ semestrální projekt s agentem 🟠 (3/3), odevzdání |
| `tuesday-sk-1` · Út 10:00 | 🟩 Swift základy, první app | odpadlo | odpadlo | 🟩 `@State` ručně, agent 🟠 příště | 🟩 hra a BMI od agenta 🟠; ručně `ForEach`, `TextField`, `Slider`, BMI, alert, `@Binding` | 🟩 ručně sdílení dat (`@Observable`, sheet přes `@Bindable`, `dismiss`); TODO od agenta 🟠 | 🟩 Weather od agenta 🟠 („real feel“ teplota); ručně příspěvky z fake JSON API | ⬜ Notes: PRD → agent 🟠 → test → oprava; ručně `NavigationStack` | ⬜ Recipe Book od agenta 🟠, test restartu; ručně `@Model`, `@Query` | svátek 17.&nbsp;11. | ⬜ Journal Summariser od agenta 🟠, eval; ručně `LanguageModelSession`, `AppIntent` | ⬜ semestrální projekt s agentem 🟠 (1/3) | ⬜ semestrální projekt s agentem 🟠 (2/3) | ⬜ semestrální projekt s agentem 🟠 (3/3), odevzdání |
| `tuesday-sk-2` · Út 15:00 | 🟩 Swift základy | odpadlo | odpadlo | 🟩 `@State` ručně, agent 🟠 příště | 🟩 hra a BMI od agenta 🟠; ručně `@Binding`, `ForEach`, `TextField`, BMI se `Slider`y, alert | 🟩 ručně sdílení dat (`@EnvironmentObject`, `@Observable`); TODO od agenta 🟠, ručně počítadla a alert | ⬜ Weather od agenta 🟠 (první PRD); ručně todo list z fake JSON API | ⬜ Notes: PRD → agent 🟠 → test → oprava; ručně `NavigationStack` | ⬜ Recipe Book od agenta 🟠, test restartu; ručně `@Model`, `@Query` | svátek 17.&nbsp;11. | ⬜ Journal Summariser od agenta 🟠, eval; ručně `LanguageModelSession`, `AppIntent` | ⬜ semestrální projekt s agentem 🟠 (1/3) | ⬜ semestrální projekt s agentem 🟠 (2/3) | ⬜ semestrální projekt s agentem 🟠 (3/3), odevzdání |
| `thursday-sk-1` · Čt 16:00 | 🟩 první SwiftUI app | odpadlo | 🟩 `@State`, hra od agenta 🟠 | děkanské volno | 🟩 BMI od agenta 🟠; ručně `@Binding`, `TextField`, BMI se `Slider`y, alert, `ForEach` | 🟩 ručně sdílení dat (`@Observable`, `.environment`, sheet); TODO od agenta 🟠, ručně alert a vlastní TODO | ⬜ Weather od agenta 🟠 (první PRD); ručně todo list z fake JSON API | ⬜ Notes: PRD → agent 🟠 → test → oprava; ručně `NavigationStack` | ⬜ Recipe Book od agenta 🟠, test restartu; ručně `@Model`, `@Query` | ⬜ Habit Tracker od agenta 🟠; ručně `AppIntent` | ⬜ Journal Summariser od agenta 🟠, eval; ručně `LanguageModelSession` | ⬜ semestrální projekt s agentem 🟠 (1/3) | ⬜ semestrální projekt s agentem 🟠 (2/3) | ⬜ semestrální projekt s agentem 🟠 (3/3), odevzdání |
| `kombi` | – | – | 🟩 views, `@State`, hra od agenta 🟠 (2.&nbsp;10.) | – | – | – | ⬜ sobotní blok 2 (týdny 4–7), termín upřesníme | – | – | – | – | ⬜ sobotní blok 3 (týdny 8–12), termín upřesníme | – | ⬜ termín upřesníme |
| Přednáška · Út 12:00 | 🟩 úvod, Swift základy | odpadla | odpadla | 🟩 `@State`, review hry od agenta 🟠 | 🟩 `@Observable`, `List`, sheet | ⬜ síť: `async`/`await`, `Codable` | ⬜ `NavigationStack`, jak psát PRD | ⬜ SwiftData: `@Model`, `@Query` | ⬜ App Intents | svátek 17.&nbsp;11. | ⬜ Foundation Models, evaly | ⬜ práce na projektu s agentem 🟠 | ⬜ práce na projektu s agentem 🟠 | ⬜ práce na projektu s agentem 🟠 |

## Podrobně po týdnech


## Týden 1 · 14.–18. 9. · Swift základy

| Skupina | Datum | Co jsme probrali | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 14. 9. | První Swift v Playgroundu; první SwiftUI aplikace „Hello, world“ | 🟩 |
| `monday-sk-2` · Po 14:00 | 14. 9. | Swift základy: cykly, funkce, class vs. struct, protokoly, `some`; první SwiftUI aplikace | 🟩 |
| `tuesday-sk-1` · Út 10:00 | 15. 9. | Swift základy; první SwiftUI aplikace | 🟩 |
| `tuesday-sk-2` · Út 15:00 | 15. 9. | Swift základy | 🟩 |
| `thursday-sk-1` · Čt 16:00 | 17. 9. | První SwiftUI aplikace: `Text`, stacky | 🟩 |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 15. 9. | Úvod do kurzu, Apple platformy; Swift základy | 🟩 |

## Týden 2 · 21.–25. 9. · SwiftUI rozložení

| Skupina | Datum | Co jsme probrali | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 21. 9. | SwiftUI: modifikátory, stacky, vlastní views | 🟩 |
| `monday-sk-2` · Po 14:00 | 21. 9. | SwiftUI: modifikátory, stacky, vlastní views | 🟩 |
| `tuesday-sk-1` · Út 10:00 | 22. 9. | Cvičení odpadlo |  |
| `tuesday-sk-2` · Út 15:00 | 22. 9. | Cvičení odpadlo |  |
| `thursday-sk-1` · Čt 16:00 | 24. 9. | Cvičení odpadlo |  |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 22. 9. | Přednáška odpadla | |

## Týden 3 · 28. 9.–2. 10. · SwiftUI rozložení

| Skupina | Datum | Co jsme probrali | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 28. 9. | Státní svátek |  |
| `monday-sk-2` · Po 14:00 | 28. 9. | Státní svátek |  |
| `tuesday-sk-1` · Út 10:00 | 29. 9. | Cvičení odpadlo |  |
| `tuesday-sk-2` · Út 15:00 | 29. 9. | Cvičení odpadlo |  |
| `thursday-sk-1` · Čt 16:00 | 1. 10. | Modifikátory, stacky, `enum`, views s parametry; `@State`; hra na hádání kruhu od agenta | 🟩 |
| `kombi` | 2. 10. | Markdown v `Text`, views s parametry, karta příspěvku; hra na hádání kruhu se skóre a koly od agenta (`@State`, `guard`) | 🟩 |
| Přednáška · Út 12:00 | 29. 9. | Přednáška odpadla | |

## Týden 4 · 5.–9. 10. · `@State` a první aplikace od agenta

| Skupina | Datum | Co jsme probrali | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 5. 10. | Views s parametry, karta ve stylu Instagramu, počítadlo s `@State` ručně. Práce s agentem příště (12. 10.) | 🟩 |
| `monday-sk-2` · Po 14:00 | 5. 10. | Opakování rozložení, příspěvek ve stylu X, počítadlo s `@State` ručně; hra na hádání kruhu od agenta | 🟩 |
| `tuesday-sk-1` · Út 10:00 | 6. 10. | Views s parametry, pořadí modifikátorů, karta ve stylu Instagramu, počítadlo s `@State` ručně. Práce s agentem příště (13. 10.) | 🟩 |
| `tuesday-sk-2` · Út 15:00 | 6. 10. | Views s parametry, pořadí modifikátorů, karta ve stylu Instagramu, počítadlo s `@State` ručně. Práce s agentem příště (13. 10.) | 🟩 |
| `thursday-sk-1` · Čt 16:00 | 8. 10. | Cvičení odpadlo (děkanské volno) |  |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 6. 10. | Deklarativní model, stacky, pořadí modifikátorů, `@State`, `if` vs. `.opacity`; stejné zadání pro agenta; review hry na hádání kruhu | 🟩 |

## Týden 5 · 12.–16. 10. · `@Binding` a formuláře: BMI kalkulačka

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 12. 10. | Ručně: cyklus `ForEach` (hádání správného indexu), `TextField`, `Slider`. Od agenta (Claude Code): hra na hádání kruhu a BMI kalkulačka (posuvníky, barevné kategorie, `@Binding`), obojí jsme spolu prošli v code review. Ručně také `@Binding` (předání `$counter` do jiného view) a BMI kalkulačka | 🟩 |
| `monday-sk-2` · Po 14:00 | 12. 10. | Ručně: cyklus `ForEach`, `@Binding` (předání `$counter` do jiného view), `TextField`, `Slider`, `SecureField`, alert. Od agenta (Claude Code): BMI kalkulačka (`Form`, jednotky, posuvníky, barevná škála), prošli jsme ji v code review. BMI ručně dohnáno 19. 10. | 🟩 |
| `tuesday-sk-1` · Út 10:00 | 13. 10. | Ručně: cyklus `ForEach`, `TextField`, `Slider`, BMI kalkulačka se `Slider`em, alert. Od agenta (Claude Code): hra na hádání kruhu a BMI kalkulačka (`Form`, posuvníky, barevné kategorie), prošli jsme je v code review. Ručně také `@Binding` (předání `$count` do jiného view) | 🟩 |
| `tuesday-sk-2` · Út 15:00 | 13. 10. | Ručně: `@Binding`, cyklus `ForEach`, `TextField`, BMI kalkulačka se `Slider`y, alert. Od agenta (Claude Code): hra na hádání kruhu a BMI kalkulačka (jednotky, posuvníky, barevná škála), prošli jsme je v code review | 🟩 |
| `thursday-sk-1` · Čt 16:00 | 15. 10. | Ručně: `@Binding` (vyčleněné view s `TextField`y), `TextField`, BMI kalkulačka se `Slider`y, alert. Od agenta (Claude Code): BMI kalkulačka (jednotky, posuvníky, barevná škála), prošli jsme ji v code review. Ručně také cyklus `ForEach` (hádání správného boxu) | 🟩 |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 13. 10. | `@Observable`, kdo vlastní stav (`@State` → `@Bindable` → `@Environment`), `List` a mazání tahem, sheet pro přidání; tichá chyba při mazání ve filtrovaném seznamu | 🟩 |

## Týden 6 · 19.–23. 10. · `@Observable`: TODO aplikace

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 19. 10. | Ručně: sdílený model s `@Observable` předaný přes `.environment` dvěma views, sheet otevřený z modelu přes `@Bindable` a zavřený `dismiss()`, vypočítaná vlastnost. Od agenta (Claude Code): TODO aplikace (`@Observable` úložiště, `List`, mazání tahem, přidávání nahoře v seznamu) – zadání nedodržel: chybí odškrtnutí a sheet, úložiště se nepředává přes `.environment` | 🟩 |
| `monday-sk-2` · Po 14:00 | 19. 10. | Ručně: BMI kalkulačka se `Slider`y (dohnáno z týdne 5), sdílený model s `@Observable` předaný přes `.environment` dvěma views a sheet otevřený z modelu přes `@Bindable`; do aplikace od agenta ručně alert při prázdném názvu. Od agenta (Claude Code): TODO aplikace (odškrtnutí, přeškrtnutí hotových, počet zbývajících, „Clear Done“, přesouvání řádků, mazání tahem, přidávání nahoře v seznamu) – zadání nedodržel: použil starší `ObservableObject` s `@EnvironmentObject` místo `@Observable` a chybí sheet | 🟩 |
| `tuesday-sk-1` · Út 10:00 | 20. 10. | Ručně: sdílený model s `@Observable` (vlastněný přes `@State`) předaný přes `.environment` dvěma views, sheet otevřený z modelu přes `@Bindable` a zavřený `dismiss()`; vlastní minimální TODO seznam a alert při prázdném názvu v aplikaci od agenta. Od agenta (Claude Code): TODO aplikace s `@Observable` úložištěm (odškrtnutí, přeškrtnutí hotových, počet zbývajících, „Clear Done“, přesouvání a mazání tahem, přidávání nahoře v seznamu) – zadání dodržel jen napůl: chybí sheet a úložiště se nepředává přes `.environment` | 🟩 |
| `tuesday-sk-2` · Út 15:00 | 20. 10. | Ručně: sdílení dat mezi views – `@EnvironmentObject` a `@Observable`. Od agenta (Claude Code): TODO aplikace s `@Observable` úložištěm (odškrtnutí, přeškrtnutí hotových, počet zbývajících, „Clear Done“, přesouvání a mazání tahem, přidávání nahoře v seznamu) – zadání dodržel jen napůl: chybí sheet a úložiště se nepředává přes `.environment`. Ručně do ní: počet úkolů, počet hotových z celkového počtu, alert při přidání prázdného úkolu | 🟩 |
| `thursday-sk-1` · Čt 16:00 | 22. 10. | Ručně: sdílení dat mezi views – `@Observable` a `.environment`, sheet otevřený z modelu přes `@Bindable` a zavřený `dismiss()`. Od agenta (Claude Code): TODO aplikace (odškrtnutí, přeškrtnutí hotových, počet zbývajících, „Clear Done“, přesouvání a mazání tahem) – zadání dodržel jen napůl: použil starší `ObservableObject`, úložiště nepředává přes `.environment` a chybí sheet. Ručně do ní: alert při přidání prázdného úkolu a vlastní minimální TODO (`TextField`, `List`, `ForEach`) | 🟩 |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 20. 10. | Síť a concurrency: `async`/`await`, `Task`, `Codable`, `.task`, `async let` a `TaskGroup`; actors a `Sendable` jen jako pojem | ⬜ |

## Týden 7 · 26.–30. 10. · Síť a concurrency: Weather – Fáze 3 začíná

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 26. 10. | Ručně: seznam příspěvků z fake JSON API (JSONPlaceholder) – `URLSession` → `JSONDecoder` → `.task`, stav chyby s tlačítkem „Try again“, `filter` na pole. Od agenta (Claude Code): Weather aplikace z prvního PRD (hledání místa v `TextField`u, zvýrazněná „feels like“ teplota) – **agent vyměnil API**: PRD říkal OpenWeather, agent použil Open-Meteo (bez klíče), aniž by se zeptal. Navíc oproti zadání: `@Observable` model, explicitní stavy načítání a chyby, °C/°F, mock služba pro běh bez sítě | 🟩 |
| `monday-sk-2` · Po 14:00 | 26. 10. | Ručně: seznam příspěvků z fake JSON API (JSONPlaceholder) – `URLSession` → `JSONDecoder` → `.task`, stav chyby s tlačítkem „Try again“, vyzkoušený schválně špatnou adresou. Od agenta (Claude Code): Weather aplikace z prvního PRD (Open-Meteo) – `@Observable` úložiště předané přes `.environment`, uložená města s přesouváním a mazáním, aktuální poloha, hledání přes `.searchable`, °C/°F, hodinová a 7denní předpověď, paralelní načítání přes `TaskGroup`, stav chyby s tlačítkem „Try Again“ | 🟩 |
| `tuesday-sk-1` · Út 10:00 | 27. 10. | Ručně: seznam příspěvků z fake JSON API (JSONPlaceholder) – `URLSession` → `JSONDecoder` → `.task`, stav chyby s tlačítkem „Try again“. Od agenta (Claude Code): Weather aplikace z jednovětého zadání („highlight real feel temperature“) – Open-Meteo bez klíče, hledání města v `TextField`u, velká karta „Real feel“ (pocitová teplota vedle skutečné a vysvětlení rozdílu větrem nebo vlhkostí), pozadí podle pocitové teploty, vítr a vlhkost, 7denní předpověď, obnovení tahem dolů. Agent rozhodl sám: celý stav drží `ContentView` v `@State` (žádný `@Observable` model), jen °C, při chybě jen text bez tlačítka „Try again“ | 🟩 |
| `tuesday-sk-2` · Út 15:00 | 27. 10. | Weather Dashboard (poprvé celý postup: specifikace (PRD) → agent → akceptační test → oprava → review): `async`/`await`, `Task`, `URLSession`, `Codable`, stav načítání a chyby, paralelní načítání. Ručně: todo list z týdne 6 načtený z fake JSON API (JSONPlaceholder) | ⬜ |
| `thursday-sk-1` · Čt 16:00 | 29. 10. | Weather Dashboard (poprvé celý postup: specifikace (PRD) → agent → akceptační test → oprava → review): `async`/`await`, `Task`, `URLSession`, `Codable`, stav načítání a chyby, paralelní načítání. Ručně: todo list z týdne 6 načtený z fake JSON API (JSONPlaceholder) | ⬜ |
| `kombi` | upřesníme | Sobotní blok 2 (týdny 4–7) | ⬜ |
| Přednáška · Út 12:00 | 27. 10. | `NavigationStack`, `navigationDestination`, `NavigationPath`; jak napsat specifikaci s testovatelnými kritérii | ⬜ |

## Týden 8 · 2.–6. 11. · Notes: `NavigationStack`

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 2. 11. | Notes: `NavigationStack`, seznam → detail; specifikace (PRD) → agent → akceptační test → oprava → review. Ručně: `NavigationStack` | ⬜ |
| `monday-sk-2` · Po 14:00 | 2. 11. | Notes: `NavigationStack`, seznam → detail; specifikace (PRD) → agent → akceptační test → oprava → review. Ručně: `NavigationStack` | ⬜ |
| `tuesday-sk-1` · Út 10:00 | 3. 11. | Notes: `NavigationStack`, seznam → detail; specifikace (PRD) → agent → akceptační test → oprava → review. Ručně: `NavigationStack` | ⬜ |
| `tuesday-sk-2` · Út 15:00 | 3. 11. | Notes: `NavigationStack`, seznam → detail; specifikace (PRD) → agent → akceptační test → oprava → review. Ručně: `NavigationStack` | ⬜ |
| `thursday-sk-1` · Čt 16:00 | 5. 11. | Notes: `NavigationStack`, seznam → detail; specifikace (PRD) → agent → akceptační test → oprava → review. Ručně: `NavigationStack` | ⬜ |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 3. 11. | SwiftData: `@Model`, `@Query`, `ModelContainer`, vazby; proč zastavení v Xcode není restart | ⬜ |

## Týden 9 · 9.–13. 11. · SwiftData: Recipe Book

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 9. 11. | Recipe Book: `@Model`, `@Query`, vazby; test restartu – data musí přežít zavření aplikace. Ručně: `@Model` a `@Query` | ⬜ |
| `monday-sk-2` · Po 14:00 | 9. 11. | Recipe Book: `@Model`, `@Query`, vazby; test restartu – data musí přežít zavření aplikace. Ručně: `@Model` a `@Query` | ⬜ |
| `tuesday-sk-1` · Út 10:00 | 10. 11. | Recipe Book: `@Model`, `@Query`, vazby; test restartu – data musí přežít zavření aplikace. Ručně: `@Model` a `@Query` | ⬜ |
| `tuesday-sk-2` · Út 15:00 | 10. 11. | Recipe Book: `@Model`, `@Query`, vazby; test restartu – data musí přežít zavření aplikace. Ručně: `@Model` a `@Query` | ⬜ |
| `thursday-sk-1` · Čt 16:00 | 12. 11. | Recipe Book: `@Model`, `@Query`, vazby; test restartu – data musí přežít zavření aplikace. Ručně: `@Model` a `@Query` | ⬜ |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 10. 11. | App Intents: akce pro Siri a Zkratky, `AppShortcutsProvider` | ⬜ |

## Týden 10 · 16.–20. 11. · App Intents: Habit Tracker

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 16. 11. | Habit Tracker: App Intents – akce „hotovo“ ze Siri a aplikace Zkratky. Ručně: minimální `AppIntent` | ⬜ |
| `monday-sk-2` · Po 14:00 | 16. 11. | Habit Tracker: App Intents – akce „hotovo“ ze Siri a aplikace Zkratky. Ručně: minimální `AppIntent` | ⬜ |
| `tuesday-sk-1` · Út 10:00 | 17. 11. | Státní svátek – cvičení odpadá; jak ho doženeme, upřesníme |  |
| `tuesday-sk-2` · Út 15:00 | 17. 11. | Státní svátek – cvičení odpadá; jak ho doženeme, upřesníme |  |
| `thursday-sk-1` · Čt 16:00 | 19. 11. | Habit Tracker: App Intents – akce „hotovo“ ze Siri a aplikace Zkratky. Ručně: minimální `AppIntent` | ⬜ |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 17. 11. | Státní svátek – přednáška odpadá | |

## Týden 11 · 23.–27. 11. · AI v aplikaci: Journal Summariser

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 23. 11. | Journal Summariser: AI přímo v aplikaci (Foundation Models na macOS 27) a eval s 5 testovacími případy (golden cases). Ručně: `LanguageModelSession` | ⬜ |
| `monday-sk-2` · Po 14:00 | 23. 11. | Journal Summariser: AI přímo v aplikaci (Foundation Models na macOS 27) a eval s 5 testovacími případy (golden cases). Ručně: `LanguageModelSession` | ⬜ |
| `tuesday-sk-1` · Út 10:00 | 24. 11. | Journal Summariser: AI přímo v aplikaci (Foundation Models na macOS 27) a eval s 5 testovacími případy (golden cases). Ručně: `LanguageModelSession`. Na začátku App Intent ručně (za svátek 17.&nbsp;11.) | ⬜ |
| `tuesday-sk-2` · Út 15:00 | 24. 11. | Journal Summariser: AI přímo v aplikaci (Foundation Models na macOS 27) a eval s 5 testovacími případy (golden cases). Ručně: `LanguageModelSession`. Na začátku App Intent ručně (za svátek 17.&nbsp;11.) | ⬜ |
| `thursday-sk-1` · Čt 16:00 | 26. 11. | Journal Summariser: AI přímo v aplikaci (Foundation Models na macOS 27) a eval s 5 testovacími případy (golden cases). Ručně: `LanguageModelSession` | ⬜ |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 24. 11. | AI v aplikaci: Foundation Models, evaly, soukromí | ⬜ |

## Týden 12 · 30. 11.–4. 12. · Semestrální projekt (1/3)

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 30. 11. | Semestrální projekt ve škole: téma a specifikace (PRD), práce s agentem | ⬜ |
| `monday-sk-2` · Po 14:00 | 30. 11. | Semestrální projekt ve škole: téma a specifikace (PRD), práce s agentem | ⬜ |
| `tuesday-sk-1` · Út 10:00 | 1. 12. | Semestrální projekt ve škole: téma a specifikace (PRD), práce s agentem | ⬜ |
| `tuesday-sk-2` · Út 15:00 | 1. 12. | Semestrální projekt ve škole: téma a specifikace (PRD), práce s agentem | ⬜ |
| `thursday-sk-1` · Čt 16:00 | 3. 12. | Semestrální projekt ve škole: téma a specifikace (PRD), práce s agentem | ⬜ |
| `kombi` | upřesníme | Sobotní blok 3 (týdny 8–12) | ⬜ |
| Přednáška · Út 12:00 | 1. 12. | Místo přednášky práce na semestrálním projektu (konzultace) | ⬜ |

## Týden 13 · 7.–11. 12. · Semestrální projekt (2/3)

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 7. 12. | Semestrální projekt ve škole: práce s agentem, průběžná kontrola | ⬜ |
| `monday-sk-2` · Po 14:00 | 7. 12. | Semestrální projekt ve škole: práce s agentem, průběžná kontrola | ⬜ |
| `tuesday-sk-1` · Út 10:00 | 8. 12. | Semestrální projekt ve škole: práce s agentem, průběžná kontrola | ⬜ |
| `tuesday-sk-2` · Út 15:00 | 8. 12. | Semestrální projekt ve škole: práce s agentem, průběžná kontrola | ⬜ |
| `thursday-sk-1` · Čt 16:00 | 10. 12. | Semestrální projekt ve škole: práce s agentem, průběžná kontrola | ⬜ |
| `kombi` | – | – | – |
| Přednáška · Út 12:00 | 8. 12. | Místo přednášky práce na semestrálním projektu (konzultace) | ⬜ |

## Týden 14 · 14.–18. 12. · Semestrální projekt (3/3), termíny testu

V tomto týdnu je **každý den jeden termín testu** (20 min). Časy upřesníme.

| Skupina | Datum | Co probereme | Stav |
|---|---|---|:---:|
| `monday-sk-1` · Po 10:00 | 14. 12. | Semestrální projekt ve škole: dokončení, vlastní review a **odevzdání** | ⬜ |
| `monday-sk-2` · Po 14:00 | 14. 12. | Semestrální projekt ve škole: dokončení, vlastní review a **odevzdání** | ⬜ |
| `tuesday-sk-1` · Út 10:00 | 15. 12. | Semestrální projekt ve škole: dokončení, vlastní review a **odevzdání** | ⬜ |
| `tuesday-sk-2` · Út 15:00 | 15. 12. | Semestrální projekt ve škole: dokončení, vlastní review a **odevzdání** | ⬜ |
| `thursday-sk-1` · Čt 16:00 | 17. 12. | Semestrální projekt ve škole: dokončení, vlastní review a **odevzdání** | ⬜ |
| `kombi` | upřesníme | Termín upřesníme | ⬜ |
| Přednáška · Út 12:00 | 15. 12. | Otázky ke státní závěrečné zkoušce (iOS jako platforma; návrh UI – Storyboard, UIKit, SwiftUI), pak práce na semestrálním projektu | ⬜ |

---

- Hry na hádání kruhu napsal agent Claude (Claude Code); vaší prací je je přečíst, ověřit a vysvětlit.
- Swift concurrency (`async`/`await`, `Task`) a `Codable` (původně plánované na 2. týden) jsme přesunuli do 9. týdne (Weather).
- **Ručně** = krátký příklad, který píšeme spolu bez agenta. Sada ručních příkladů je v každém týdnu stejná pro všechny skupiny.
- Všechno, včetně semestrálního projektu, děláme **ve škole** – doma na Macu pracovat nemusíte.
- **Předmět ukončíte buď testem, nebo projektem** (obhajoba). Termíny testu: v posledním týdnu (14.–17. 12.) každý den jeden, časy upřesníme. Termíny obhajob upřesníme.
