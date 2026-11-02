# W08 — Notes

Slovo agenta 🟠 = tuhle část kódu napsal agent (Claude Code); ostatní jste psali ručně.

**Týden 8 · 2.–6. 11. 2026** · fáze 3 — *naučit se architektovat* (zadání pro agenta je krátké, kritéria a ověření jsou vaše)

Co se učíme: navigace – `NavigationStack`, `NavigationLink(value:)`, `.navigationDestination`, seznam → detail,
kopie vs. `@Binding` v detailu. Cvičení: review Weather aplikace z minulého týdne (co rozhodl agent), Notes aplikace
od agenta z krátkého zadání, akceptační test klikáním.

| Skupina | Datum | Kód |
|---|---|---|
| `monday-sk-1/` — pondělí 10:00 | 2. 11. | `CODE-REVIEW-WEATHER-02-11-26.md` (review Weather aplikace z týdne 7: kde je stav – `@State` s `WeatherViewModel`, žádný lokální stav – a kde se ukazuje chyba – `ContentUnavailableView`) · `NotesApp` (Notes aplikace od agenta 🟠 – `NavigationStack` s cestou, detail upravuje poznámku přes `@Binding`, nová poznámka se přidá nahoru a rovnou otevře, titulek z prvního řádku, štítky u poznámek a filtr podle štítků, hledání přes `.searchable`; agent rozhodl sám: přidávání bez sheetu, poznámky nejdou smazat, data se neukládají) · `02-11-26-sk1` (`MyApp.swift`: `NavigationStack` nad třemi položkami, `.navigationDestination` otevře vlastní `NoteView` s titulkem – psané ručně) |
| `monday-sk-2/` — pondělí 14:00 | 2. 11. | `CODE-REVIEW-WEATHER.md` (review Weather aplikace z týdne 7: lokální stav – `@State` pro hledaný text, globální – `@Observable` třída `WeatherStore`; chyba a prázdný stav – `ContentUnavailableView`) · `NotesApp` (Notes aplikace od agenta 🟠 – `NavigationStack` s cestou, poznámky jako mřížka kartiček (`LazyVGrid`), detail s `TextEditor` upravuje poznámku přes `@Binding`, nová poznámka se přidá nahoru a rovnou otevře, mazání tlačítkem v detailu, prázdný stav `ContentUnavailableView`; agent rozhodl sám: ukázková data, prázdné poznámky po návratu zmizí, přidávání bez sheetu, data se neukládají) |
