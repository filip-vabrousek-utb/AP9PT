import SwiftUI
import SwiftData

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Recipe.self)
    }
}
