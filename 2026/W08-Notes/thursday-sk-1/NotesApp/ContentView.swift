import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    let created = Date()
    var text = ""
}

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var path: [Note.ID] = []

    // Oldest first.
    private var chronological: [Note] {
        notes.sorted { $0.created < $1.created }
    }

    var body: some View {
        NavigationStack(path: $path) {
            List(chronological) { note in
                NavigationLink(value: note.id) {
                    VStack(alignment: .leading) {
                        Text(note.text.isEmpty ? "New Note" : note.text)
                            .lineLimit(1)
                        Text(note.created, format: .dateTime.day().month().hour().minute())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                Button("Add Note", systemImage: "plus", action: addNote)
            }
            .navigationDestination(for: Note.ID.self) { id in
                if let index = notes.firstIndex(where: { $0.id == id }) {
                    TextEditor(text: $notes[index].text)
                        .padding(.horizontal)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }

    private func addNote() {
        let note = Note()
        notes.append(note)
        path.append(note.id)
    }
}

#Preview {
    ContentView()
}
