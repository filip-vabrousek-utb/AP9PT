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
    
    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let title = ImportantItem.title
        
        guard !title.isEmpty else {
            return .result(dialog: "You haven't saved an important item yet.")
        }
        
        guard !ImportantItem.isDone else {
            // early return
            return .result(dialog: "\(title) is already done.")
        }
        
        ImportantItem.isDone = true
        return .result(dialog: "Done. \(title) completed.")
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

