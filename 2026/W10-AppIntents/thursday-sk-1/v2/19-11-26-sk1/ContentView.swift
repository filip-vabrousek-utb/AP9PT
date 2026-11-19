import SwiftUI
import Playgrounds

struct ContentView: View {
    // Observes the same UserDefaults keys the shortcut writes, so the UI
    // updates live when the task is completed from Shortcuts or Siri.
    @AppStorage(TaskStore.titleKey) private var taskTitle = ""
    @AppStorage(TaskStore.isDoneKey) private var isDone = false
    @AppStorage(TaskStore.completedAtKey) private var completedAt = 0.0

    @State private var draft = ""
    @FocusState private var fieldFocused: Bool

    private var hasTask: Bool {
        !taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var trimmedDraft: String {
        draft.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Your task") {
                    TextField("e.g. Drink a glass of water", text: $draft)
                        .focused($fieldFocused)
                        .submitLabel(.done)
                        .onSubmit(save)

                    Button(hasTask ? "Replace task" : "Set task", action: save)
                        .disabled(trimmedDraft.isEmpty || trimmedDraft == taskTitle)
                }

                if hasTask {
                    Section("Status") {
                        HStack(spacing: 12) {
                            Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                                .foregroundStyle(isDone ? .green : .secondary)
                                .contentTransition(.symbolEffect(.replace))
                            VStack(alignment: .leading, spacing: 2) {
                                Text(taskTitle)
                                    .strikethrough(isDone)
                                if isDone, completedAt > 0 {
                                    Text("Completed \(Date(timeIntervalSince1970: completedAt).formatted(date: .abbreviated, time: .shortened))")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .animation(.default, value: isDone)

                        if isDone {
                            Button("Mark as not done") { TaskStore.markNotDone() }
                        } else {
                            Button("Mark as done") { TaskStore.markDone() }
                        }
                    }
                }

                Section("Complete it with a shortcut") {
                    Label("Say \u{201C}Complete my task in \(appName)\u{201D}", systemImage: "mic")
                    Label("Or run \u{201C}Complete task\u{201D} in the Shortcuts app", systemImage: "square.stack.3d.up")
                }
            }
            .navigationTitle("My Task")
        }
        .onAppear { draft = taskTitle }
    }

    private var appName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? "the app"
    }

    private func save() {
        guard !trimmedDraft.isEmpty else { return }
        TaskStore.setTask(trimmedDraft)
        draft = TaskStore.title
        fieldFocused = false
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
