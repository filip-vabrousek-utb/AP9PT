# Na co si dát pozor, když kód píše agent

Agent (Claude Code) napíše za minutu aplikaci, která se přeloží a vypadá hotově. **Přeložitelnost neznamená správnost.**
Tenhle dokument sbírá chyby, které agent v tomhle semestru opravdu udělal, a co ověřit, než jeho kód schválíte.
Obsahuje jen to, co už jsme probrali (týdny 1–6); s každým dalším tématem se doplní.

*Aktualizováno 22. 10. 2026 (po týdnu 6).*

---

## 0. Pravidlo číslo jedna: porovnejte výsledek se zadáním

Všechny skupiny, které v týdnu 6 dostaly **stejný** prompt na TODO aplikaci, dostaly kód, který zadání porušil – a skoro pokaždé jinak:

| skupina | co agent ze zadání vynechal nebo porušil |
|---|---|
| `monday-sk-1` | žádné `isDone` ani odškrtnutí, žádný sheet, model se nepředává přes `.environment` |
| `monday-sk-2` | použil `ObservableObject`, i když prompt výslovně říkal *„No ObservableObject“*; žádný sheet |
| `tuesday-sk-1` | `@Observable` ano, ale model vlastní `ContentView` a nepředává ho dál; žádný sheet |
| `tuesday-sk-2` | totéž jako `tuesday-sk-1`: `@Observable` a odškrtnutí ano, ale model vlastní `ContentView` bez `.environment`; žádný sheet |
| `thursday-sk-1` | stejně jako `monday-sk-2` použil starší `ObservableObject` s `@Published` (vlastněný přes `@StateObject` v `ContentView`), i když prompt výslovně říkal *„No ObservableObject“*; model nepředává přes `.environment`; žádný sheet |

Agent to nikde nepřizná – shrnutí na konci zní, jako by bylo hotovo všechno.

**Co ověřit**
- [ ] Projděte zadání **bod po bodu** a u každého najděte řádek kódu, který ho splňuje.
- [ ] Hledejte i opak: co je v kódu **navíc**, co jste nechtěli (`@FocusState`, `ContentUnavailableView`, animace…). Navíc není chyba, ale musíte vědět, co to v aplikaci dělá a proč to tam je – rozumět celku, ne každému řádku.
- [ ] Když něco chybí, napište agentovi **přesnou** opravu („Přesuň `TodoStore` do `App` jako `@State`, předej ho přes `.environment`…“), ne „oprav to“.

---

## 1. Přeloží se ≠ funguje: vyzkoušejte okrajové vstupy

Agent testuje „šťastnou cestu“. Vy zkuste to, co uživatel udělá omylem.

**Co ověřit**
- [ ] **Prázdný vstup**: přidat úkol bez názvu, jen s mezerami. Má jít přidat? (`.disabled(...)` nebo alert – obojí jsme viděli.)
- [ ] **Nula a krajní hodnoty**: BMI s výškou `0` dělí nulou → `inf` nebo `NaN` na obrazovce, aplikace nespadne, jen ukáže nesmysl. Začíná `Slider` na `0`?
- [ ] **Dvakrát totéž**: dva úkoly se stejným názvem (viz bod 4).
- [ ] Spusťte aplikaci a **klikejte** – náhled v Xcode nestačí.

---

## 2. `@State` a `@Binding`: kdo stav vlastní

**Co ověřit**
- [ ] Hodnota, kterou views sdílí, má **jednoho vlastníka** se `@State`; ostatní ji dostávají jako `@Binding` (`$hodnota`).
- [ ] Dítě s `@Binding` může stav rodiče **měnit** – je to záměr? (Viz `WrapperView` → `ReadView` z týdne 5.)
- [ ] `@State` je `private`, pokud ho nikdo zvenku nenastavuje.

---

## 3. Sdílený model: `@Observable` a `.environment`

To je téma, ve kterém agent chyboval nejčastěji.

**Co ověřit**
- [ ] Je to `@Observable class` (iOS 17+), **ne** `ObservableObject` + `@Published` – pokud zadání nežádá starší způsob. Agent ho použije sám od sebe, protože je ho na internetu víc.
- [ ] Model se vytváří **jednou** a drží ho `@State`:

  ```swift
  @State private var store = TodoStore()   // ✅
  var store = TodoStore()                  // ⚠️ funguje jen náhodou – při překreslení se může vytvořit znovu
  ```

- [ ] Nahoře je `.environment(store)` a dole `@Environment(TodoStore.self)`.
- [ ] **Chybějící `.environment` kompilátor neodhalí** – aplikace spadne až za běhu:
  `Fatal error: No Observable object of type … found.` Totéž platí pro `#Preview`: dostává náhled model přes `.environment(...)`?
- [ ] Netahá se model parametrem přes pět views, když stačí environment?

---

## 4. `List`, `ForEach` a mazání

**Co ověřit**
- [ ] `ForEach` nad vlastním typem má `Identifiable` (`id = UUID()`). `ForEach(items, id: \.self)` nad `[String]` **se rozbije, když jsou dva řádky stejné** – SwiftUI je nerozliší.
- [ ] `.onDelete` je na **`ForEach`**, ne na `List`.
- [ ] Maže se ze **správného** pole: mazání z filtrovaného seznamu podle indexu smaže jinou položku (přednáška 13. 10.) – bez chyby, bez varování.
- [ ] Změna položky (odškrtnutí) mění **model**, ne kopii v řádku. *„Data tečou dolů, události nahoru.“*

---

## 5. Sheet a `dismiss`

**Co ověřit**
- [ ] Když je stav sheetu v modelu, je v body `@Bindable var store = store` – jinak `$store.showAdd` nejde přeložit.
- [ ] `@Environment(\.dismiss)` je ve view **uvnitř** sheetu, ne ve view, které ho otevírá.
- [ ] `dismiss()` – **se závorkami**. Bez nich se nic nestane a Xcode jen žlutě varuje.
- [ ] Neotvírá se sheet hned znovu (`showAdd = true` v `onAppear` nebo podmínka, která pořád platí)?

---

## 6. Rozložení a modifikátory

**Co ověřit**
- [ ] **Pořadí modifikátorů** mění výsledek: `.padding().background(...)` není totéž co `.background(...).padding()` (týden 2).
- [ ] Pevné rozměry (`.frame(width: 300, height: 700)`) – jak to vypadá na menším iPhonu a na šířku?
- [ ] Texty, které vidí uživatel, jsou v jazyce, který jste chtěli.

---

## Jak review dělat

1. **Predikce**: než kód otevřete, napište si, co v něm čekáte.
2. **Zadání bod po bodu** (sekce 0).
3. **Spustit a zkusit okrajové vstupy** (sekce 1).
4. **Projít kód podle témat** (sekce 2–6) – stačí ta, která se aplikace týkají.
5. **Jedna přesná oprava** pro agenta, ověřit, zapsat do NOTES.
