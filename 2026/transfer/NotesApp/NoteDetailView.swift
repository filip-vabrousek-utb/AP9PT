import SwiftUI

struct NoteDetailView: View {
    @Binding var note: Note
    @State private var newBadge = ""

    var body: some View {
        Form {
            Section {
                TextField("Note", text: $note.text, axis: .vertical)
                    .lineLimit(8...)
            }

            Section("Badges") {
                ForEach(note.badges, id: \.self) { badge in
                    BadgeView(name: badge)
                }
                .onDelete { note.badges.remove(atOffsets: $0) }

                TextField("Add badge", text: $newBadge)
                    .textInputAutocapitalization(.never)
                    .onSubmit(addBadge)
            }
        }
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addBadge() {
        let badge = newBadge.trimmingCharacters(in: .whitespaces)
        if !badge.isEmpty && !note.badges.contains(badge) {
            note.badges.append(badge)
        }
        newBadge = ""
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(note: .constant(Note(text: "Groceries\nMilk, eggs", badges: ["home"])))
    }
}
