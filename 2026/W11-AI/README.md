# W11 — Opakování ručně k testu: TODO, sheet, SwiftData

Slovo agenta 🟠 = tuhle část kódu napsal agent (Claude Code); ostatní jste psali ručně.

**Týden 11 · 23.–27. 11. 2026** · poslední cvičení před semestrálním projektem (týdny 12–14)

Co se učíme: opakování k testu rukama – `@State` a `$`, seznam, mazání, vypočítaná vlastnost, formulář v sheetu a `dismiss`,
ukládání přes SwiftData, obrázky z Assets a z internetu (`AsyncImage`). Na plátně ukázka AI v aplikaci (Foundation Models) a evalu.

| Skupina | Datum | Kód |
|---|---|---|
| `monday-sk-1/` — pondělí 10:00 | 23. 11. | `23-11-26-sk1` (`InstaFeed.swift`: feed příspěvků ve stylu Instagramu – model `Fetcher` s `@Observable`, falešné „API“ `fetchPosts()` přidá příspěvek s adresou fotky; `ListView` čte model přes `@Environment` a volá ho v `.onAppear`; `InstaCell`: profilový obrázek `artemis-pad` z Assets oříznutý do kruhu, jméno a `Spacer`, fotka z internetu přes `AsyncImage` – psané ručně · `MyApp.swift`: model vytvořený v aplikaci a předaný přes `.environment`; navíc ukázka `VStack`, `HStack` a `ZStack` s rámečkem · `ContentView.swift` je nepoužitá šablona) |
| `tuesday-sk-2/` — úterý 15:00 | 24. 11. | `NavigaceJadro` (připravené jádro navigace z týdne 8 – cvičení 3. 11. odpadlo: `NavigationStack`, `NavigationLink(value:)`, `.navigationDestination(for:)`, `Hashable` model; projdeme na začátku cvičení) |
