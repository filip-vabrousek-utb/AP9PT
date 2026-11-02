import SwiftUI

struct NoteDetailView: View {
    @Binding var note: Note
    let onDelete: () -> Void

    @FocusState private var isFocused: Bool

    var body: some View {
        TextEditor(text: $note.text)
            .focused($isFocused)
            .padding(.horizontal)
            .navigationTitle(note.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Delete", systemImage: "trash", role: .destructive, action: onDelete)
            }
            .onAppear {
                if note.isEmpty { isFocused = true }
            }
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(note: .constant(Note.samples[0]), onDelete: {})
    }
}
