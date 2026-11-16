import Foundation

/// The single important item, stored in UserDefaults so both the app UI
/// (via @AppStorage) and the App Intent read and write the same values.
enum ImportantItem {
    static let titleKey = "importantItem.title"
    static let isDoneKey = "importantItem.isDone"

    private static var defaults: UserDefaults { .standard }

    static var title: String {
        defaults.string(forKey: titleKey) ?? ""
    }

    static var isDone: Bool {
        defaults.bool(forKey: isDoneKey)
    }

    static var hasItem: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    static func save(_ newTitle: String) {
        defaults.set(newTitle.trimmingCharacters(in: .whitespacesAndNewlines), forKey: titleKey)
        defaults.set(false, forKey: isDoneKey)
    }

    static func markDone() {
        defaults.set(true, forKey: isDoneKey)
    }

    static func clear() {
        defaults.removeObject(forKey: titleKey)
        defaults.removeObject(forKey: isDoneKey)
    }
}
