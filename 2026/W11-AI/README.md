# W11 — Opakování ručně k testu: TODO, sheet, SwiftData

Slovo agenta 🟠 = tuhle část kódu napsal agent (Claude Code); ostatní jste psali ručně.

**Týden 11 · 23.–27. 11. 2026** · poslední cvičení před semestrálním projektem (týdny 12–14)

Co se učíme: opakování k testu rukama – `@State` a `$`, seznam, mazání, vypočítaná vlastnost, formulář v sheetu a `dismiss`,
ukládání přes SwiftData, obrázky z Assets a z internetu (`AsyncImage`). Na plátně ukázka AI v aplikaci (Foundation Models) a evalu.

| Skupina | Datum | Kód |
|---|---|---|
| `monday-sk-1/` — pondělí 10:00 | 23. 11. | `v1/23-11-26-sk1` (stav v 11:03, psané ručně: feed příspěvků ve stylu Instagramu – model `Fetcher` s `@Observable`, falešné „API“ `fetchPosts()` přidá příspěvek s adresou fotky; `ListView` čte model přes `@Environment` a volá ho v `.onAppear`; `InstaCell`: profilový obrázek `artemis-pad` z Assets oříznutý do kruhu, jméno a `Spacer`, fotka z internetu přes `AsyncImage`; `MyApp.swift`: model vytvořený v aplikaci a předaný přes `.environment`, navíc `VStack`, `HStack` a `ZStack` s rámečkem) · `v2/23-11-26-sk1` (konec hodiny, psané ručně: `Post` je `Identifiable` s `id`; seznam v `NavigationStack`, tlačítko „Show sheet“ v toolbaru otevře sheet `SheetView` s `TextField` a tlačítkem „Add post“, který přidá příspěvek do stejného modelu přes `@Environment`; `EffectsView.swift`: kruh s `RadialGradient` a barevným stínem, čtverec s `LinearGradient`, který se po klepnutí otočí a zmenší s pružinovou animací `withAnimation(.spring)`; `SwiftDataTest.swift`: zatím jen model `@Model Item`) · `ContentView.swift` je v obou nepoužitá šablona) |
| `tuesday-sk-2/` — úterý 15:00 | 24. 11. | `NavigaceJadro` (připravené jádro navigace z týdne 8 – cvičení 3. 11. odpadlo: `NavigationStack`, `NavigationLink(value:)`, `.navigationDestination(for:)`, `Hashable` model; projdeme na začátku cvičení) |
