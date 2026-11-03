import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var filter: Category? = nil
    @State private var isAdding = false

    private var filteredNotes: [Note] {
        guard let filter else { return notes }
        return notes.filter { $0.category == filter }
    }

    var body: some View {
        NavigationStack {
            List {
                Picker("Filter", selection: $filter) {
                    Text("All").tag(Category?.none)
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue).tag(Category?.some(category))
                    }
                }
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)

                ForEach(filteredNotes) { note in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(note.text)
                            .lineLimit(2)
                        Text(note.category.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                Button("Add", systemImage: "plus") { isAdding = true }
            }
            .sheet(isPresented: $isAdding) {
                NewNoteView { notes.append($0) }
            }
        }
    }
}

struct NewNoteView: View {
    var onSave: (Note) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State private var category: Category = .personal

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Category", selection: $category) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)

                TextEditor(text: $text)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.quaternary))
            }
            .padding()
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(Note(text: text, category: category))
                        dismiss()
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
