import Foundation

/// Storage for the single task, shared by the app UI and the App Intent.
/// Uses `UserDefaults.standard`, which the intent can read because it runs in the app's process.
nonisolated enum TaskStore {
    static let titleKey = "task.title"
    static let isDoneKey = "task.isDone"
    static let completedAtKey = "task.completedAt"

    private static var defaults: UserDefaults { .standard }

    static var title: String {
        (defaults.string(forKey: titleKey) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    static var isDone: Bool { defaults.bool(forKey: isDoneKey) }

    static func setTask(_ newTitle: String) {
        defaults.set(newTitle.trimmingCharacters(in: .whitespacesAndNewlines), forKey: titleKey)
        markNotDone()
    }

    static func markDone() {
        defaults.set(true, forKey: isDoneKey)
        defaults.set(Date().timeIntervalSince1970, forKey: completedAtKey)
    }

    static func markNotDone() {
        defaults.set(false, forKey: isDoneKey)
        defaults.set(0.0, forKey: completedAtKey)
    }
}
