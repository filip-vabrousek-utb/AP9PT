//
//  MyIntent.swift
//  MyApp
//
//  Created by Filip Vabroušek on 24.11.2026.
//

import AppIntents

struct MarkDoneIntent: AppIntent {
    static var title: LocalizedStringResource = "Mark habit as done"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        // DO some work
        // eg. Task.isDone = true
        
        .result(dialog: "Done. Habit completed.")
    }
}


struct HabitShortcut: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
            AppShortcut(intent: MarkDoneIntent(),
                        phrases: ["Mark habit as done in \(.applicationName)"],
                        shortTitle: "Mark THE TASK done",
                        systemImageName: "checkmark.circle")
    }
}
