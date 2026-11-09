# W09 — Recipe Book (SwiftData)

Slovo agenta 🟠 = tuhle část kódu napsal agent (Claude Code); ostatní jste psali ručně.

**Týden 9 · 9.–13. 11. 2026** · fáze 3 — *naučit se architektovat* (zadání pro agenta je krátké, kritéria a ověření jsou vaše)

Co se učíme: ukládání dat se SwiftData – `@Model`, `.modelContainer`, `@Query`, `modelContext.insert` a `delete`;
test restartu (data musí přežít zavření aplikace). Cvičení: Recipe Book od agenta z krátkého zadání, akceptační test klikáním.

| Skupina | Datum | Kód |
|---|---|---|
| `monday-sk-1/` — pondělí 10:00 | 9. 11. | `RecipeApp` (Recipe Book od agenta 🟠 – `@Model Recipe` s ingrediencemi a fotkou uloženou mimo databázi `@Attribute(.externalStorage)`, `@Query` řazený podle názvu, filtr kategorie v toolbaru, seznam s náhledem fotky → detail, přidání v sheetu s `PhotosPicker`em, mazání tahem) · `09-11-26-sk1` (`MyApp.swift`: `@Model` s datem vytvoření, `.modelContainer`, `@Query` řazený podle data, přidání tlačítkem přes `insert` – psané ručně; `recipe-app-prompt.md`: zadání pro agenta a co od něj čekáme) · `Response-09-11-26.md` (odpovědi na otázky ke kódu Notes z týdne 8: stav, filtrování podle štítků, navigace – s odkazy na řádky) |
| `monday-sk-2/` — pondělí 14:00 | 9. 11. | `Answers.md` (odpovědi na otázky ke kódu Notes z týdne 8: stav jen lokální `@State`, bez `@Observable`; mazání poznámky přes `onDelete` předané do detailu a odstranění prázdných poznámek v `onChange(of: path)` – s odkazy na řádky) · aplikace z týdne 9 doplníme po nahrání |
