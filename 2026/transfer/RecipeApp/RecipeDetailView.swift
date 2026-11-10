import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        List {
            RecipePhoto(data: recipe.photo)
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .clipped()
                .listRowInsets(EdgeInsets())

            Section("Category") {
                Text(recipe.category)
            }

            Section("Ingredients") {
                ForEach(recipe.ingredients, id: \.self) { Text($0) }
            }
        }
        .navigationTitle(recipe.name)
    }
}
