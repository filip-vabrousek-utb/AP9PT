//
//  MyIntent.swift
//  24-11-26-sk1
//
//  Created by Filip Vabroušek on 24.11.2026.
//

import AppIntents

struct MarkDoneItent: AppIntent {
    static let title: LocalizedStringResource = "Mark MY habit as done"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        // Do something with app data here
        // Communicate with the rest of the app via UserDefaults and AppStorage
        .result(dialog: "Done. Habit completed.")
    }
}

struct HabitShortcut: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: MarkDoneItent(),
                    phrases: ["Mark habit as done in \(.applicationName)"],
                    shortTitle: "Mark done",
                    systemImageName: "sun.min.fill")
    }
}
