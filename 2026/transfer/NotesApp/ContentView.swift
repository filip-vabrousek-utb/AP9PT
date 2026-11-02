import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = Note.samples
    @State private var path: [Note.ID] = []

    private let columns = [GridItem(.adaptive(minimum: 150), spacing: 12)]

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(notes) { note in
                        NavigationLink(value: note.id) {
                            NoteCard(note: note)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .overlay {
                if notes.isEmpty {
                    ContentUnavailableView("No Notes", systemImage: "note.text", description: Text("Tap + to add one."))
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                Button("Add Note", systemImage: "plus", action: addNote)
            }
            .navigationDestination(for: Note.ID.self) { id in
                if let index = notes.firstIndex(where: { $0.id == id }) {
                    NoteDetailView(note: $notes[index]) {
                        path.removeAll()
                        notes.removeAll { $0.id == id }
                    }
                }
            }
            .onChange(of: path) {
                // Drop notes that were left blank once we're back on the grid.
                if path.isEmpty {
                    notes.removeAll(where: \.isEmpty)
                }
            }
        }
    }

    private func addNote() {
        let note = Note(text: "")
        notes.insert(note, at: 0)
        path.append(note.id)
    }
}

struct NoteCard: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(note.title)
                .font(.headline)
                .lineLimit(2)
            Text(note.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer(minLength: 0)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .aspectRatio(1, contentMode: .fit)
        .background(.yellow.opacity(0.25), in: .rect(cornerRadius: 16))
        .contentShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    ContentView()
}
