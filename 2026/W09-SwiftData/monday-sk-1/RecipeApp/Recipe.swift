import Foundation
import SwiftData

enum Category: String, CaseIterable, Identifiable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case dessert = "Dessert"

    var id: String { rawValue }
}

@Model
final class Recipe {
    var name: String
    var category: String
    var ingredients: [String]
    @Attribute(.externalStorage) var photo: Data?

    init(name: String, category: Category, ingredients: [String], photo: Data?) {
        self.name = name
        self.category = category.rawValue
        self.ingredients = ingredients
        self.photo = photo
    }
}
