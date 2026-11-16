# W10 — Habit Tracker (App Intents)

Slovo agenta 🟠 = tuhle část kódu napsal agent (Claude Code); ostatní jste psali ručně.

**Týden 10 · 16.–20. 11. 2026** · fáze 3 — *naučit se architektovat* (zadání pro agenta je krátké, kritéria a ověření jsou vaše)

Co se učíme: App Intents – akce aplikace, kterou vidí systém (Zkratky, Spotlight, Siri): `AppIntent`, `perform()`,
odpověď s větou přes `ProvidesDialog`, `AppShortcutsProvider` s frází. Cvičení: Habit Tracker od agenta, akceptační test klikáním.

| Skupina | Datum | Kód |
|---|---|---|
| `monday-sk-1/` — pondělí 10:00 | 16. 11. | `v1/16-11-26-sk1` (`OurIntent.swift`: nejmenší `AppIntent` `MarkDoneIntent` s názvem ve Zkratkách a odpovědí „Done. Habit completed.“ přes `ProvidesDialog` a `AppShortcutsProvider` s frází „Mark habit done in …“ – psané ručně; intent zatím nic neukládá, `ContentView.swift` je šablona „Hello, world!“) · `v2/16-11-26-sk1` (stejný intent už s chováním: aplikace „Important“ s jednou důležitou věcí na den uloženou v `UserDefaults` (`ImportantItem.swift`); `ContentView` ji čte přes `@AppStorage` – zadání názvu, přepínač Done, přeškrtnutí hotové, smazání; `MarkDoneIntent` ji označí jako hotovou a odpoví větou, opakované spuštění nic nemění, bez uložené věci odpoví, že žádná není) · `v2/appIntents.md` (vysvětlení kódu v2 krok za krokem: aplikace a intent si předávají data přes `UserDefaults`, `perform()` se spustí po stisku ▶︎ ve Zkratkách, `.result(dialog:)` zobrazí větu, `HabitShortcuts` určuje, jak akce vypadá; proč musí být všechny soubory v jednom targetu – aplikaci) |
