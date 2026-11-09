import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Recipe.name) private var recipes: [Recipe]
    @State private var filter: Category?
    @State private var showingAdd = false

    private var filtered: [Recipe] {
        guard let filter else { return recipes }
        return recipes.filter { $0.category == filter.rawValue }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filtered) { recipe in
                    NavigationLink {
                        RecipeDetailView(recipe: recipe)
                    } label: {
                        HStack {
                            RecipePhoto(data: recipe.photo)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack(alignment: .leading) {
                                Text(recipe.name).font(.headline)
                                Text(recipe.category).font(.caption).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete { offsets in
                    for i in offsets { context.delete(filtered[i]) }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Category", selection: $filter) {
                        Text("All").tag(Category?.none)
                        ForEach(Category.allCases) { Text($0.rawValue).tag(Category?.some($0)) }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { showingAdd = true }
                }
            }
            .sheet(isPresented: $showingAdd) { AddRecipeView() }
        }
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        List {
            if recipe.photo != nil {
                RecipePhoto(data: recipe.photo)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .listRowInsets(EdgeInsets())
            }
            Section("Category") { Text(recipe.category) }
            Section("Ingredients") {
                ForEach(recipe.ingredients, id: \.self) { Text($0) }
            }
        }
        .navigationTitle(recipe.name)
    }
}

struct RecipePhoto: View {
    let data: Data?

    var body: some View {
        if let data, let image = UIImage(data: data) {
            Image(uiImage: image).resizable().scaledToFill()
        } else {
            Image(systemName: "fork.knife")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.quaternary)
        }
    }
}

#Preview {
    ContentView().modelContainer(for: Recipe.self, inMemory: true)
}
