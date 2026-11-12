import Foundation
import SwiftData

enum RecipeCategory: String, Codable, CaseIterable, Identifiable {
    case breakfast = "Breakfast"
    case starter = "Starter"
    case main = "Main"
    case side = "Side"
    case dessert = "Dessert"
    case drink = "Drink"
    case snack = "Snack"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .breakfast: "sun.horizon"
        case .starter: "leaf"
        case .main: "fork.knife"
        case .side: "carrot"
        case .dessert: "birthday.cake"
        case .drink: "cup.and.saucer"
        case .snack: "popcorn"
        }
    }
}

@Model
final class Recipe {
    var name: String
    var categoryRaw: String
    var ingredients: String
    var instructions: String
    var minutes: Int
    var rating: Int
    var isFavorite: Bool
    var createdAt: Date

    var category: RecipeCategory {
        get { RecipeCategory(rawValue: categoryRaw) ?? .main }
        set { categoryRaw = newValue.rawValue }
    }

    init(
        name: String,
        category: RecipeCategory,
        ingredients: String = "",
        instructions: String = "",
        minutes: Int = 30,
        rating: Int = 0,
        isFavorite: Bool = false
    ) {
        self.name = name
        self.categoryRaw = category.rawValue
        self.ingredients = ingredients
        self.instructions = instructions
        self.minutes = minutes
        self.rating = rating
        self.isFavorite = isFavorite
        self.createdAt = .now
    }
}

extension Recipe {
    @MainActor
    static func insertSamples(into context: ModelContext) {
        let samples: [Recipe] = [
            Recipe(name: "Pancakes", category: .breakfast,
                   ingredients: "Flour\nMilk\nEggs\nSugar\nButter",
                   instructions: "Whisk everything together, rest 10 min, fry in a buttered pan.",
                   minutes: 20, rating: 4, isFavorite: true),
            Recipe(name: "Spaghetti Bolognese", category: .main,
                   ingredients: "Spaghetti\nMinced beef\nTomatoes\nOnion\nGarlic",
                   instructions: "Brown the meat, add onion and garlic, simmer with tomatoes for 40 min. Serve over pasta.",
                   minutes: 60, rating: 5),
            Recipe(name: "Chocolate Brownies", category: .dessert,
                   ingredients: "Dark chocolate\nButter\nSugar\nEggs\nFlour",
                   instructions: "Melt chocolate with butter, mix in the rest, bake 25 min at 180 °C.",
                   minutes: 45, rating: 5, isFavorite: true),
            Recipe(name: "Caesar Salad", category: .starter,
                   ingredients: "Romaine\nParmesan\nCroutons\nCaesar dressing",
                   instructions: "Toss lettuce with dressing, top with parmesan and croutons.",
                   minutes: 15, rating: 3),
            Recipe(name: "Lemonade", category: .drink,
                   ingredients: "Lemons\nSugar\nWater\nMint",
                   instructions: "Squeeze lemons, dissolve sugar, top up with cold water and mint.",
                   minutes: 10, rating: 4),
        ]
        samples.forEach(context.insert)
        try? context.save()
    }
}

extension Recipe {
    /// Persist immediately instead of waiting for SwiftData's periodic autosave,
    /// so changes survive the app being killed right after an edit.
    func save() {
        try? modelContext?.save()
    }

    func toggleFavorite() {
        isFavorite.toggle()
        save()
    }
}
