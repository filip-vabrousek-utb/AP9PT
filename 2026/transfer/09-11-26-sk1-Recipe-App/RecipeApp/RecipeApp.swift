import SwiftUI
import SwiftData

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Recipes", systemImage: "book") {
                    ContentView()
                }
                Tab("Favorites", systemImage: "heart") {
                    ContentView(favoritesOnly: true)
                }
            }
        }
        .modelContainer(for: Recipe.self)
    }
}
