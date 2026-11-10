import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Recipe.name) private var recipes: [Recipe]
    @State private var selectedCategory: Category?
    @State private var showingAdd = false

    private var filtered: [Recipe] {
        guard let selectedCategory else { return recipes }
        return recipes.filter { $0.category == selectedCategory.rawValue }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(filtered) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCard(recipe: recipe)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Recipes")
            .navigationDestination(for: Recipe.self) { RecipeDetailView(recipe: $0) }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Category", selection: $selectedCategory) {
                        Text("All").tag(Category?.none)
                        ForEach(Category.allCases) { Text($0.rawValue).tag(Category?.some($0)) }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { showingAdd = true }
                }
            }
            .sheet(isPresented: $showingAdd) { AddRecipeView() }
            .overlay {
                if filtered.isEmpty {
                    ContentUnavailableView("No Recipes", systemImage: "fork.knife")
                }
            }
        }
    }
}

struct RecipePhoto: View {
    let data: Data?

    var body: some View {
        if let data, let image = UIImage(data: data) {
            Image(uiImage: image).resizable().scaledToFill()
        } else {
            Rectangle().fill(.quaternary)
                .overlay(Image(systemName: "photo").foregroundStyle(.secondary))
        }
    }
}

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            RecipePhoto(data: recipe.photo)
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .clipShape(.rect(cornerRadius: 12))
            Text(recipe.name).font(.headline).lineLimit(1)
            Text(recipe.category).font(.caption).foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView().modelContainer(for: Recipe.self, inMemory: true)
}
