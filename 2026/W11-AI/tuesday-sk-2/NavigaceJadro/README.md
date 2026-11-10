# Jádro navigace (týden 8 · Notes)

Cvičení 3. 11. odpadlo, tady je jádro, které jsme tehdy měli psát ručně. Projdeme ho na začátku cvičení 24. 11.

1. **`NavigationStack`** obaluje celou obrazovku – bez něj `NavigationLink` nikam nevede a `navigationTitle` se neukáže.
2. **`NavigationLink(note.title, value: note)`** – odkaz nese *hodnotu*, ne cílovou obrazovku.
3. **`.navigationDestination(for: Note.self)`** – jedno místo, které z hodnoty udělá detail.
4. **`Hashable`** na `Note` – jinak hodnotu nejde poslat do `value:`.

Otázka na rozmyšlenou: co se stane, když `NavigationStack` smažete?
