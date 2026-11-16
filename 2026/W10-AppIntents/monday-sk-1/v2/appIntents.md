# App Intents v2 – step by step

## 1) `ImportantItem.swift` – shared data

- The app and the intent communicate through **`UserDefaults`**.
- `UserDefaults` = persistent storage for simple data (strings, numbers, true/false).
- Properties: `title`, `isDone`, `hasItem`
- Methods: `save`, `markDone`, `clear`

## 2) `OurIntent.swift` – `MarkDoneIntent`

- The intent appears as an action (a block) in the **Shortcuts** app.
- We press ▶︎ and the code in `perform()` runs.
- If the item isn't done yet, it is marked done:

  ```swift
  ImportantItem.markDone()
  ```

- A dialog is shown:

  ```swift
  .result(dialog: "Done. \(title) completed.")
  ```

- `HabitShortcuts` (`AppShortcutsProvider`) decides how the action looks in Shortcuts:
  its phrase, short title and icon. It is offered right after the app is installed.

## 3) One target: why it matters

The intent works only because **all files belong to one target – the app**
(`16-11-26-sk1`). In this project the whole source folder is a member of that target
(*File inspector → Target Membership*).

- **The app and the intent run in the same process** and share `UserDefaults.standard`.
  What the intent writes, the app's `@AppStorage` sees immediately.
- **The system finds the intent at build time.** Xcode reads `AppIntent` and
  `AppShortcutsProvider` from the target it is compiled into. A file outside the app
  target → the action never appears in Shortcuts, even though everything compiles.
- **Two targets = two separate worlds.** If the intent were moved into another target
  (e.g. a widget or an intent extension), it would run in a different process with its own
  `UserDefaults.standard` – the app would never see the change. Sharing data then needs
  an **App Group** and `UserDefaults(suiteName:)`.
- **Don't add the same file to several targets.** Each target would get its own copy
  of the intent; Shortcuts can then show the action twice, and only one
  `AppShortcutsProvider` is allowed per app.

**Check when the action is missing:** select `OurIntent.swift` → File inspector →
Target Membership → only the app target is ticked.
