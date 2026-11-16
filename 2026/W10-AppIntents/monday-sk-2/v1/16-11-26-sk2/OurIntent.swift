//
//  OurIntent.swift
//  16-11-26-sk2
//
//  Created by Filip Vabroušek on 16.11.2026.
//

import Foundation
import AppIntents

struct MarkDoneIntent: AppIntent {
    static var title: LocalizedStringResource = "Mark habit as done"
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        return .result(dialog: "Done. Habit completed.")
    }
}


struct HabitShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: MarkDoneIntent(),
                    phrases: ["Mark habit done in \(.applicationName)"],
                    shortTitle: "Mark done",
                    systemImageName: "checkmark.circle")
    }
}

