//
//  OurIntent.swift
//  16-11-26-sk1
//
//  Created by Filip Vabroušek on 16.11.2026.
//

import AppIntents

struct MarkDoneIntent: AppIntent {
    static let title: LocalizedStringResource = "Mark habit as done"
    
    static let description = IntentDescription("Marks your saved important item as done.")

    func perform() async throws -> some IntentResult & ProvidesDialog {
        guard ImportantItem.hasItem else {
            return .result(dialog: "You don't have an important item saved yet.")
        }
        let title = ImportantItem.title
        if ImportantItem.isDone {
            return .result(dialog: "\(title) is already done.")
        }
        ImportantItem.markDone()
        return .result(dialog: "Done. \(title) completed.")
    }
}

struct HabitShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: MarkDoneIntent(),
                    phrases: ["Mark habit done in \(.applicationName)"], shortTitle: "Mark done", systemImageName: "checkmark.circle")
    }
}
