#  # Notes app review

1) State: What did the agent decide about state – @State, @Observable, local or global state?
No @Observable, local @State only
https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W08-Notes/monday-sk-2/NotesApp/ContentView.swift (line 4, 5)

 


2) Deleting: Where does a note get deleted – and where do blank notes disappear?

```swift

NoteDetailView(note: $notes[index]) {                  path.removeAll()
              onDelete() inside the body       
                        
                           struct NoteDetailView: View {
    @Binding var note: Note
    let onDelete: () -> Void   


onChange(of: path)
removes dead notes on note delete


