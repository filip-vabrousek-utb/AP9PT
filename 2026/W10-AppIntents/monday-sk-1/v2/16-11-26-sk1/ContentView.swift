import SwiftUI
import Playgrounds

struct ContentView: View {
    @AppStorage(ImportantItem.titleKey) private var title = ""
    @AppStorage(ImportantItem.isDoneKey) private var isDone = false
    @State private var draft = ""

    private var hasItem: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                if hasItem {
                    Section("Today's important item") {
                        HStack(spacing: 12) {
                            Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                                .foregroundStyle(isDone ? .green : .secondary)
                            Text(title)
                                .font(.headline)
                                .strikethrough(isDone)
                                .foregroundStyle(isDone ? .secondary : .primary)
                        }
                        .padding(.vertical, 4)

                        Toggle("Done", isOn: $isDone)
                    }

                    Section {
                        Label("Use the “Mark done” shortcut or ask Siri to mark the habit done.",
                              systemImage: "mic")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }

                    Section {
                        Button("Clear item", role: .destructive) {
                            ImportantItem.clear()
                        }
                    }
                } else {
                    Section("What's the one important thing?") {
                        TextField("e.g. Call the dentist", text: $draft)
                            .onSubmit(save)
                        Button("Save", action: save)
                            .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
            }
            .navigationTitle("Important")
        }
    }

    private func save() {
        guard !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        ImportantItem.save(draft)
        draft = ""
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
