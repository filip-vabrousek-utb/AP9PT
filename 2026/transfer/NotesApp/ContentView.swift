import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var path: [Note.ID] = []
    @State private var searchText = ""
    @State private var selectedBadges: Set<String> = []

    private var allBadges: [String] {
        Set(notes.flatMap(\.badges)).sorted()
    }

    // A note matches when it contains every search term and has every selected badge.
    private var filteredNotes: [Note] {
        let terms = searchText.split(separator: " ")
        return notes.filter { note in
            let haystack = ([note.text] + note.badges).joined(separator: " ")
            return terms.allSatisfy { haystack.localizedCaseInsensitiveContains($0) }
                && selectedBadges.isSubset(of: note.badges)
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            List {
                if !allBadges.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(allBadges, id: \.self) { badge in
                                Button {
                                    toggle(badge)
                                } label: {
                                    BadgeView(name: badge, isSelected: selectedBadges.contains(badge))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }

                ForEach(filteredNotes) { note in
                    NavigationLink(value: note.id) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(note.title)
                                .lineLimit(1)
                            if !note.badges.isEmpty {
                                HStack {
                                    ForEach(note.badges, id: \.self) { BadgeView(name: $0) }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText)
            .toolbar {
                Button("Add Note", systemImage: "square.and.pencil", action: addNote)
            }
            .navigationDestination(for: Note.ID.self) { id in
                if let index = notes.firstIndex(where: { $0.id == id }) {
                    NoteDetailView(note: $notes[index])
                }
            }
        }
        // Drop selected badges that no longer exist on any note.
        .onChange(of: allBadges) {
            selectedBadges.formIntersection(allBadges)
        }
    }

    private func toggle(_ badge: String) {
        if selectedBadges.contains(badge) {
            selectedBadges.remove(badge)
        } else {
            selectedBadges.insert(badge)
        }
    }

    private func addNote() {
        let note = Note()
        notes.insert(note, at: 0)
        path.append(note.id)
    }
}

#Preview {
    ContentView()
}
