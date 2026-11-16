import SwiftUI
import Playgrounds

struct ContentView: View {
    @AppStorage(ImportantItem.titleKey) private var title = ""
    @AppStorage(ImportantItem.isDoneKey) private var isDone = false
    @State private var draft = ""

    var body: some View {
        NavigationStack {
            Form {
                if title.isEmpty {
                    Section("Your one important thing") {
                        TextField("What matters most today?", text: $draft)
                            .onSubmit(save)
                        Button("Save", action: save)
                            .disabled(draft.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                } else {
                    Section("Important item") {
                        Button {
                            isDone.toggle()
                        } label: {
                            Label {
                                Text(title)
                                    .strikethrough(isDone)
                                    .foregroundStyle(isDone ? .secondary : .primary)
                            } icon: {
                                Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(isDone ? .green : .secondary)
                            }
                        }
                        .tint(.primary)
                    }
                    Section {
                        Button("Replace item", role: .destructive) {
                            title = ""
                            isDone = false
                        }
                    } footer: {
                        Text("Run the \"Mark done\" shortcut (or ask Siri) to complete it.")
                    }
                }
            }
            .navigationTitle("Habit")
        }
    }

    private func save() {
        let trimmed = draft.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        title = trimmed
        isDone = false
        draft = ""
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
