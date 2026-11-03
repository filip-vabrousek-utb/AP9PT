# W08 — Notes

Slovo agenta 🟠 = tuhle část kódu napsal agent (Claude Code); ostatní jste psali ručně.

**Týden 8 · 2.–6. 11. 2026** · fáze 3 — *naučit se architektovat* (zadání pro agenta je krátké, kritéria a ověření jsou vaše)

Co se učíme: navigace – `NavigationStack`, `NavigationLink(value:)`, `.navigationDestination`, seznam → detail,
kopie vs. `@Binding` v detailu. Cvičení: review Weather aplikace z minulého týdne (co rozhodl agent), Notes aplikace
od agenta z krátkého zadání, akceptační test klikáním.

| Skupina | Datum | Kód |
|---|---|---|
| `monday-sk-1/` — pondělí 10:00 | 2. 11. | [`CODE-REVIEW-WEATHER-02-11-26.md`](../reviews-and-tasks/monday-sk-1/CODE-REVIEW-WEATHER-02-11-26.md) (review Weather aplikace z týdne 7: kde je stav – `@State` s `WeatherViewModel`, žádný lokální stav – a kde se ukazuje chyba – `ContentUnavailableView`) · `NotesApp` (Notes aplikace od agenta 🟠 – `NavigationStack` s cestou, detail upravuje poznámku přes `@Binding`, nová poznámka se přidá nahoru a rovnou otevře, titulek z prvního řádku, štítky u poznámek a filtr podle štítků, hledání přes `.searchable`; agent rozhodl sám: přidávání bez sheetu, poznámky nejdou smazat, data se neukládají) · `02-11-26-sk1` (`MyApp.swift`: `NavigationStack` nad třemi položkami, `.navigationDestination` otevře vlastní `NoteView` s titulkem – psané ručně) · [`TASK-for-09-11-26.md`](../reviews-and-tasks/monday-sk-1/TASK-for-09-11-26.md) (úkol k Notes aplikaci na 9. 11.) |
| `monday-sk-2/` — pondělí 14:00 | 2. 11. | [`CODE-REVIEW-WEATHER.md`](../reviews-and-tasks/monday-sk-2/CODE-REVIEW-WEATHER.md) (review Weather aplikace z týdne 7: lokální stav – `@State` pro hledaný text, globální – `@Observable` třída `WeatherStore`; chyba a prázdný stav – `ContentUnavailableView`) · `NotesApp` (Notes aplikace od agenta 🟠 – `NavigationStack` s cestou, poznámky jako mřížka kartiček (`LazyVGrid`), detail s `TextEditor` upravuje poznámku přes `@Binding`, nová poznámka se přidá nahoru a rovnou otevře, mazání tlačítkem v detailu, prázdný stav `ContentUnavailableView`; agent rozhodl sám: ukázková data, prázdné poznámky po návratu zmizí, přidávání bez sheetu, data se neukládají) · `02-11-26-sk2` (`MyApp.swift`: `NavigationStack` nad třemi položkami, `.navigationDestination` otevře vlastní `OurDetail` se jménem položky – psané ručně) · [`TASK-for-09-11-26.md`](../reviews-and-tasks/monday-sk-2/TASK-for-09-11-26.md) (úkol k Notes aplikaci na 9. 11.) |
| `tuesday-sk-1/` — úterý 10:00 | 3. 11. | [`CODE-REVIEW-WEATHER-03-11-26.md`](../reviews-and-tasks/tuesday-sk-1/CODE-REVIEW-WEATHER-03-11-26.md) (review Weather aplikace z týdne 7: žádný globální stav, lokální stav – `@State` v `ContentView` (`query` a další); chyba – jen `Text(errorMessage)` v `ContentView`) |

Code review a úkoly všech skupin jsou ve složce [`reviews-and-tasks`](../reviews-and-tasks).
