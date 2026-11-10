#  # Notes app – task for 10 Nov

- **App:** `NotesApp` (the agent's code)
- **From:** 03/11/26
- **Date:** 10/11/26

For every answer, give the **file and line**.

## In class (3 Nov)

1. **How does filtering work?**
   - Filtering: `private var filteredNotes: [Note] {`
   - Where: [ContentView.swift, line 8](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W08-Notes/tuesday-sk-1/NotesApp/ContentView.swift#L8)

## Beginning of the next lab (10 Nov)

2. **Why is the Save button disabled before I type anything?**
```swift
Saving: Button("Save") {
onSave(Note(text: text, category: category))
dismiss()
}
.disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
```

   - Where: Line 80 ContentView.swift

3. **How does the note switcher work?**
   - Where:  ContentView.swift Line 17
```swift
Picker("Filter", selection: $filter) {
Text("All").tag(Category?.none)
ForEach(Category.allCases) { category in
Text(category.rawValue).tag(Category?.some(category))
}
```
                }
                .pickerStyle(.segmented)

**Due:** start of the lab on 10 Nov – you get 5–10 minutes there, then we go through the answers together.
## State 
Local
```swift
@State private var notes: [Note] = []
```
NavigationStack onyl for toolbar buttons
