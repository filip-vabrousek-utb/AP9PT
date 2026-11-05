import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    let created = Date()
    var text = ""
}

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var selection: Note.ID?

    // Oldest first.
    private var chronological: [Note] {
        notes.sorted { $0.created < $1.created }
    }

    var body: some View {
        NavigationSplitView {
            List(chronological, selection: $selection) { note in
                VStack(alignment: .leading) {
                    Text(note.text.isEmpty ? "New Note" : note.text)
                        .lineLimit(1)
                    Text(note.created, format: .dateTime.day().month().hour().minute())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                Button("Add Note", systemImage: "plus", action: addNote)
            }
        } detail: {
            if let index = notes.firstIndex(where: { $0.id == selection }) {
                TextEditor(text: $notes[index].text)
                    .padding(.horizontal)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Select a note")
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func addNote() {
        let note = Note()
        notes.append(note)
        selection = note.id
    }
}

#Preview {
    ContentView()
}
