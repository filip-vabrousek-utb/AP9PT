import Foundation

enum Category: String, CaseIterable, Identifiable {
    case personal = "Personal"
    case work = "Work"
    case ideas = "Ideas"

    var id: Self { self }
}

struct Note: Identifiable {
    let id = UUID()
    var text: String
    var category: Category
}
