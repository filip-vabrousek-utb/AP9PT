import SwiftUI
import AppIntents

// Vzor pro projekt: App Intent, který opravdu mění data aplikace.
// Aplikace i intent čtou a zapisují stejné klíče v UserDefaults ("task.title", "task.isDone").
// Aplikace je čte přes @AppStorage, takže se po spuštění intentu ve Zkratkách sama obnoví.
// Oba soubory musí být v cíli aplikace (Target Membership).
//
// Vyzkoušení: do WindowGroup dát OneTaskView(), spustit, napsat úkol →
// Zkratky → + → Přidat akci → název aplikace → „Mark task as done“ → ▶︎ → zpět v aplikaci je hotovo.

// Aplikace: jeden úkol, uložený v UserDefaults
struct OneTaskView: View {
    @AppStorage("task.title") private var title = ""
    @AppStorage("task.isDone") private var isDone = false

    var body: some View {
        Form {
            TextField("Dnešní úkol", text: $title)
            Toggle("Hotovo", isOn: $isDone)
            Label(isDone ? "Splněno" : "Čeká",
                  systemImage: isDone ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isDone ? .green : .secondary)
        }
    }
}

// Intent: označí ten úkol jako hotový
struct MarkTaskDoneIntent: AppIntent {
    static let title: LocalizedStringResource = "Mark task as done"

    func perform() async throws -> some IntentResult & ProvidesDialog {
        let defaults = UserDefaults.standard
        let title = defaults.string(forKey: "task.title") ?? ""

        guard !title.isEmpty else {
            return .result(dialog: "Nemáš žádný úkol.")
        }
        if defaults.bool(forKey: "task.isDone") {
            return .result(dialog: "\(title) už je hotový.")
        }
        defaults.set(true, forKey: "task.isDone")
        return .result(dialog: "Hotovo: \(title).")
    }
}

// Akce se sama objeví ve Zkratkách a v Siri s touto frází
struct TaskShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: MarkTaskDoneIntent(),
                    phrases: ["Mark my task as done in \(.applicationName)"],
                    shortTitle: "Mark done",
                    systemImageName: "checkmark.circle")
    }
}

#Preview { OneTaskView() }
