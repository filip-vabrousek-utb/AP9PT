#  # Answers
Date 12/11/26
## State: What did the agent decide about state – @State, @Observable, local or global state?
2. ContenView.swift
```swift
@State private var notes: [Note] = []
```
Local array of [Note] 
private variables

Array of nodes ID for navigation
```swift
@State private var path: [Note.ID] = []
```
```swift
NavigationStack(path: $path) { for navigation
ContentView.swift
```

## Editor: How does the editor get the correct note to work with?
ContentView.swift
1. NavigationDestination shows child view 
2. We find correct note accoridng to the ID
3. We give text editor the Binding to notes array $notes[index].text, so text editor can edit array contents
```swift
 .navigationDestination(for: Note.ID.self) { id in
                if let index = notes.firstIndex(where: { $0.id == id }) {
                    TextEditor(text: $notes[index].text)
                        .padding(.horizontal)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
```




