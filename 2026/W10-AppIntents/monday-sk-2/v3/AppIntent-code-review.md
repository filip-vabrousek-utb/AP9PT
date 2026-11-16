# How do intents work? – code review of v2

## 1) `ImportantItem.swift`

- The App Intent and the app communicate via **`UserDefaults`** (persistent data storage).
- Simpler than SwiftData.
- `isDone` is controlled by a getter and a setter.

## 2) `OurIntent.swift` – `perform()`

- If the title is empty, show a dialog.
- If there is no item, return early.

## 3) `ContentView.swift`

```swift
@AppStorage(ImportantItem.titleKey) private var title = ""
```
