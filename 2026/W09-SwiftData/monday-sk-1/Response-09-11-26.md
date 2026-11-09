#  # Notes app – task for 9 Nov
Date: 09/11

Look at our `NotesApp` (the agent's code) and answer in your notes. For every answer, give the **file and line**.

1. **State:** What did the agent decide about state – `@State`, `@Observable`, local or global state?

```

  @State private var notes: [Note] = []
    @State private var path: [Note.ID] = []
    @State private var searchText = ""
    @State private var selectedBadges: Set<String> = []
    
    Path: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W08-Notes/monday-sk-1/NotesApp/ContentView.swift
    
```
1. **Filtering:** Where does filtering by tags (badges) happen?

```eturn notes.filter { note in
            let haystack = ([note.text] + note.badges).joined(separator: " ")
            
                
    Path: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W08-Notes/monday-sk-1/NotesApp/ContentView.swift
            ```

**

## Navigation


```
 NavigationStack(path: $path) {
            List {
            
 NavigationLink(value: note.id) {
 
 
  .navigationDestination(for: Note.ID.self) { id in
                if let index = notes.firstIndex(where: { $0.id == id }) {
                    NoteDetailView(note: $notes[index])
                }
            }
                
    Path: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W08-Notes/monday-sk-1/NotesApp/ContentView.swift
            ```
