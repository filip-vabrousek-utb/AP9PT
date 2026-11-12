import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Recipes", systemImage: "book") {
                RecipeListView(favoritesOnly: false)
            }
            Tab("Favourites", systemImage: "heart.fill") {
                RecipeListView(favoritesOnly: true)
            }
        }
    }
}

// MARK: - List

struct RecipeListView: View {
    let favoritesOnly: Bool

    @Environment(\.modelContext) private var context
    @Query(sort: \Recipe.name) private var recipes: [Recipe]

    @State private var selectedCategory: RecipeCategory?
    @State private var searchText = ""
    @State private var showingAdd = false

    private var filtered: [Recipe] {
        recipes.filter { recipe in
            (!favoritesOnly || recipe.isFavorite)
            && (selectedCategory == nil || recipe.category == selectedCategory)
            && (searchText.isEmpty || recipe.name.localizedCaseInsensitiveContains(searchText))
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    CategoryFilterBar(selection: $selectedCategory)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                ForEach(filtered) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeRow(recipe: recipe)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            recipe.toggleFavorite()
                        } label: {
                            Label(recipe.isFavorite ? "Unfavourite" : "Favourite",
                                  systemImage: recipe.isFavorite ? "heart.slash" : "heart")
                        }
                        .tint(.pink)
                    }
                }
                .onDelete { offsets in
                    for index in offsets { context.delete(filtered[index]) }
                    try? context.save()
                }
            }
            .overlay {
                if filtered.isEmpty {
                    emptyState
                }
            }
            .navigationTitle(favoritesOnly ? "Favourites" : "Recipes")
            .navigationDestination(for: Recipe.self) { RecipeDetailView(recipe: $0) }
            .searchable(text: $searchText, prompt: "Search recipes")
            .toolbar {
                if !favoritesOnly {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add", systemImage: "plus") { showingAdd = true }
                    }
                    if recipes.isEmpty {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Samples") { Recipe.insertSamples(into: context) }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                RecipeFormView(recipe: nil)
            }
        }
    }

    @ViewBuilder
    private var emptyState: some View {
        if favoritesOnly && selectedCategory == nil && searchText.isEmpty {
            ContentUnavailableView("No Favourites",
                                   systemImage: "heart",
                                   description: Text("Tap the heart on a recipe to add it here."))
        } else if recipes.isEmpty {
            ContentUnavailableView("No Recipes",
                                   systemImage: "book",
                                   description: Text("Tap + to add your first recipe."))
        } else {
            ContentUnavailableView("No Matches",
                                   systemImage: "line.3.horizontal.decrease.circle",
                                   description: Text("Try another category or search."))
        }
    }
}

// MARK: - Category filter

struct CategoryFilterBar: View {
    @Binding var selection: RecipeCategory?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                chip("All", symbol: "square.grid.2x2", isSelected: selection == nil) {
                    selection = nil
                }
                ForEach(RecipeCategory.allCases) { category in
                    chip(category.rawValue, symbol: category.symbol, isSelected: selection == category) {
                        selection = selection == category ? nil : category
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }

    private func chip(_ title: String, symbol: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: symbol)
                Text(title)
            }
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(isSelected ? Color.accentColor : Color(.secondarySystemFill), in: Capsule())
                .foregroundStyle(isSelected ? .white : .primary)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Row

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: recipe.category.symbol)
                .font(.title3)
                .foregroundStyle(.tint)
                .frame(width: 40, height: 40)
                .background(Color.accentColor.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name).font(.headline)
                HStack(spacing: 6) {
                    Text(recipe.category.rawValue)
                    Text("·")
                    Label("\(recipe.minutes) min", systemImage: "clock")
                        .labelStyle(.titleAndIcon)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                RatingView(rating: .constant(recipe.rating), size: 11)
            }

            Spacer()

            Button {
                recipe.toggleFavorite()
            } label: {
                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(recipe.isFavorite ? .pink : .secondary)
                    .font(.title3)
            }
            .buttonStyle(.borderless)
            .accessibilityLabel(recipe.isFavorite ? "Remove from favourites" : "Add to favourites")
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Rating

struct RatingView: View {
    @Binding var rating: Int
    var size: CGFloat = 22
    var editable = false

    var body: some View {
        HStack(spacing: size * 0.25) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .font(.system(size: size))
                    .foregroundStyle(star <= rating ? .yellow : .gray.opacity(0.5))
                    .onTapGesture {
                        guard editable else { return }
                        // Tap the current rating again to clear it.
                        rating = (rating == star) ? 0 : star
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating) of 5 stars")
        .accessibilityAdjustableAction { direction in
            guard editable else { return }
            switch direction {
            case .increment: rating = min(5, rating + 1)
            case .decrement: rating = max(0, rating - 1)
            @unknown default: break
            }
        }
    }
}

// MARK: - Detail

struct RecipeDetailView: View {
    @Bindable var recipe: Recipe
    @State private var showingEdit = false

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Label(recipe.category.rawValue, systemImage: recipe.category.symbol)
                        .font(.subheadline)
                        .foregroundStyle(.tint)
                    Label("\(recipe.minutes) minutes", systemImage: "clock")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your rating").font(.caption).foregroundStyle(.secondary)
                        RatingView(rating: $recipe.rating, size: 28, editable: true)
                    }
                }
                .padding(.vertical, 4)
            }

            if !recipe.ingredients.isEmpty {
                Section("Ingredients") {
                    ForEach(ingredientLines, id: \.self) { line in
                        Label(line, systemImage: "circle.fill")
                            .labelStyle(BulletLabelStyle())
                    }
                }
            }

            if !recipe.instructions.isEmpty {
                Section("Instructions") {
                    Text(recipe.instructions)
                }
            }
        }
        .navigationTitle(recipe.name)
        .onChange(of: recipe.rating) { recipe.save() }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    recipe.toggleFavorite()
                } label: {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(.pink)
                }
                .accessibilityLabel(recipe.isFavorite ? "Remove from favourites" : "Add to favourites")
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") { showingEdit = true }
            }
        }
        .sheet(isPresented: $showingEdit) {
            RecipeFormView(recipe: recipe)
        }
    }

    private var ingredientLines: [String] {
        recipe.ingredients
            .split(whereSeparator: \.isNewline)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
    }
}

struct BulletLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 10) {
            configuration.icon.font(.system(size: 6)).foregroundStyle(.tint)
            configuration.title
        }
    }
}

// MARK: - Add / Edit form

struct RecipeFormView: View {
    let recipe: Recipe?

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var category: RecipeCategory = .main
    @State private var minutes = 30
    @State private var rating = 0
    @State private var isFavorite = false
    @State private var ingredients = ""
    @State private var instructions = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Recipe name", text: $name)
                    Picker("Category", selection: $category) {
                        ForEach(RecipeCategory.allCases) { cat in
                            Label(cat.rawValue, systemImage: cat.symbol).tag(cat)
                        }
                    }
                    Stepper("Time: \(minutes) min", value: $minutes, in: 5...600, step: 5)
                }

                Section("Rating") {
                    RatingView(rating: $rating, size: 28, editable: true)
                    Toggle("Favourite", isOn: $isFavorite)
                }

                Section("Ingredients (one per line)") {
                    TextEditor(text: $ingredients).frame(minHeight: 100)
                }

                Section("Instructions") {
                    TextEditor(text: $instructions).frame(minHeight: 120)
                }
            }
            .navigationTitle(recipe == nil ? "New Recipe" : "Edit Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear(perform: load)
        }
    }

    private func load() {
        guard let recipe else { return }
        name = recipe.name
        category = recipe.category
        minutes = recipe.minutes
        rating = recipe.rating
        isFavorite = recipe.isFavorite
        ingredients = recipe.ingredients
        instructions = recipe.instructions
    }

    private func save() {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        if let recipe {
            recipe.name = trimmed
            recipe.category = category
            recipe.minutes = minutes
            recipe.rating = rating
            recipe.isFavorite = isFavorite
            recipe.ingredients = ingredients
            recipe.instructions = instructions
        } else {
            context.insert(Recipe(name: trimmed, category: category,
                                  ingredients: ingredients, instructions: instructions,
                                  minutes: minutes, rating: rating, isFavorite: isFavorite))
        }
        try? context.save()
        dismiss()
    }
}

#Preview {
    let container = try! ModelContainer(for: Recipe.self,
                                        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    Recipe.insertSamples(into: container.mainContext)
    return ContentView().modelContainer(container)
}
