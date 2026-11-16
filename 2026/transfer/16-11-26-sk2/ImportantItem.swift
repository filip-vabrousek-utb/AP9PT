import Foundation

/// The single important item, persisted in UserDefaults so both the app UI
/// (via @AppStorage) and the App Intent read and write the same values.
enum ImportantItem {
    static let titleKey = "importantItem.title"
    static let isDoneKey = "importantItem.isDone"

    static var title: String {
        UserDefaults.standard.string(forKey: titleKey) ?? ""
    }

    static var isDone: Bool {
        get { UserDefaults.standard.bool(forKey: isDoneKey) }
        set { UserDefaults.standard.set(newValue, forKey: isDoneKey) }
    }
}
