import SwiftUI
import SwiftData

struct ContentView: View {
    var favoritesOnly = false

    @Environment(\.modelContext) private var context
    @Query(sort: \Recipe.name) private var recipes: [Recipe]
    @State private var filter: Category?
    @State private var showingAdd = false

    private var filtered: [Recipe] {
        recipes.filter {
            (!favoritesOnly || $0.isFavorite) && (filter == nil || $0.category == filter?.rawValue)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(filtered) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                        } label: {
                            VStack(alignment: .leading) {
                                RecipePhoto(data: recipe.photo)
                                    .frame(height: 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                Text(recipe.name).font(.headline).lineLimit(1)
                                Text(recipe.category).font(.caption).foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                context.delete(recipe)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(favoritesOnly ? "Favorites" : "Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Category", selection: $filter) {
                        Text("All").tag(Category?.none)
                        ForEach(Category.allCases) { Text($0.rawValue).tag(Category?.some($0)) }
                    }
                }
                if !favoritesOnly {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add", systemImage: "plus") { showingAdd = true }
                    }
                }
            }
            .sheet(isPresented: $showingAdd) { AddRecipeView() }
        }
    }
}

struct RecipeDetailView: View {
    @Bindable var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                RecipePhoto(data: recipe.photo)
                    .frame(height: 260)
                    .clipped()

                Group {
                    Text(recipe.name).font(.largeTitle.bold())

                    Text("Ingredients").font(.title2.bold())
                    ForEach(recipe.ingredients, id: \.self) { Text("• \($0)") }

                    Text("Cooking Instructions").font(.title2.bold())
                    Text(recipe.instructions)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Favorite", systemImage: recipe.isFavorite ? "heart.fill" : "heart") {
                recipe.isFavorite.toggle()
            }
        }
    }
}

struct RecipePhoto: View {
    let data: Data?

    var body: some View {
        if let data, let image = UIImage(data: data) {
            Image(uiImage: image).resizable().scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
