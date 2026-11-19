//
//  MyIntent.swift
//  19-11-26-sk1
//
//  Created by Filip Vabroušek on 19.11.2026.
//

import AppIntents

struct MarkDoneIntent: AppIntent {
    static let title: LocalizedStringResource = "Complete my task"
    static let description = IntentDescription("Marks the task you set in the app as done.")

    func perform() async throws -> some IntentResult & ProvidesDialog {
        let task = TaskStore.title

        guard !task.isEmpty else {
            return .result(dialog: "You haven't set a task yet. Open the app to set one.")
        }

        guard !TaskStore.isDone else {
            return .result(dialog: "\(task) is already done.")
        }

        TaskStore.markDone()
        return .result(dialog: "Done. \(task) completed.")
    }
}


struct HabitShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: MarkDoneIntent(),
                    phrases: [
                        "Complete my task in \(.applicationName)",
                        "Mark my task as done in \(.applicationName)"
                    ],
                    shortTitle: "Complete task",
                    systemImageName: "checkmark.circle")
    }
}
