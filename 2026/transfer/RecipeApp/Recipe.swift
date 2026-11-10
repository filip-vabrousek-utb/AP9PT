import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var ingredients: String
    @Attribute(.externalStorage) var photo: Data?

    init(title: String, ingredients: String, photo: Data?) {
        self.title = title
        self.ingredients = ingredients
        self.photo = photo
    }
}
