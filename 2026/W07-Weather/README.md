# W07 — Weather

Slovo agenta 🟠 = tuhle část kódu napsal agent (Claude Code); ostatní jste psali ručně.

**Týden 7 · 26.–30. 10. 2026** · fáze 3 — *naučit se architektovat* (zadání pro agenta je krátké, kritéria a ověření jsou vaše)

Co se učíme: síť a concurrency – `async`/`await`, `Task`, `URLSession`, `Codable`, `.task`, stav načítání
a chyby. Cvičení: Weather aplikace od agenta z krátkého zadání, akceptační test proti `curl`; ručně seznam
z fake JSON API (JSONPlaceholder).

| Skupina | Datum | Kód |
|---|---|---|
| `monday-sk-1/` — pondělí 10:00 | 26. 10. | `26-10-26-sk1` (`MyApp.swift`: seznam příspěvků z fake JSON API (JSONPlaceholder) – `Codable`, `URLSession`, `.task`, stav chyby s tlačítkem „Try again“, filtr titulků delších než 25 znaků přes `filter` – psané ručně) · `WeatherApp` (Weather aplikace od agenta 🟠 – zadání chtělo OpenWeather, agent použil Open-Meteo bez klíče; hledání místa, zvýrazněná „feels like“ teplota, `@Observable` model, stavy načítání a chyby, °C/°F, mock služba pro běh bez sítě) |
| `monday-sk-2/` — pondělí 14:00 | 26. 10. | `OpenMeteoWeather` (Weather aplikace od agenta 🟠 – Open-Meteo, `@Observable` úložiště předané přes `.environment`, uložená města s přesouváním a mazáním, aktuální poloha, hledání přes `.searchable`, °C/°F, hodinová a 7denní předpověď, paralelní načítání přes `TaskGroup`, stav chyby s „Try Again“) · `26-10-26-sk2` (`MyApp.swift`: seznam příspěvků z fake JSON API (JSONPlaceholder) se stavem chyby a tlačítkem „Try again“, chyba vyvolaná schválně špatnou adresou – psané ručně) |
| `tuesday-sk-1/` — úterý 10:00 | 27. 10. | `RealFeelWeather` (Weather aplikace od agenta 🟠 z jednovětého zadání „highlight real feel temperature“ – Open-Meteo bez klíče, hledání města v `TextField`u, velká karta „Real feel“ s pocitovou a skutečnou teplotou a vysvětlením rozdílu, pozadí podle pocitové teploty, vítr a vlhkost, 7denní předpověď, obnovení tahem dolů; agent rozhodl sám: celý stav drží `ContentView` v `@State` bez `@Observable` modelu, jen °C, při chybě jen text bez tlačítka) · `27-10-26-sk1` (`MyApp.swift`: seznam příspěvků z fake JSON API (JSONPlaceholder) – `Codable`, `URLSession`, `.task`, stav chyby s tlačítkem „Try again“ – psané ručně) |
