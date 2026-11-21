//
//  OurIntent.swift
//  kombi-21-11-26-final
//
//  Created by Filip Vabroušek on 21.11.2026.
//

import AppIntents

struct HelloIntent: AppIntent {
    static let title: LocalizedStringResource = "Say hello"
    
    func perform() async throws -> some IntentResult & ProvidesDialog  {
        // Logic here
        // Mark the task in the store as done via UserDefaults
        let count = UserDefaults.standard.integer(forKey: "count") + 1
        UserDefaults.standard.set(count, forKey: "count")
        return .result(dialog: "The counter was increased")
    }
}

struct HelloShortcut: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: HelloIntent(),
                    phrases: ["Mark my task as done in \(.applicationName)"], shortTitle: "Hello",
                    systemImageName: "hand.wave")
    }
}
