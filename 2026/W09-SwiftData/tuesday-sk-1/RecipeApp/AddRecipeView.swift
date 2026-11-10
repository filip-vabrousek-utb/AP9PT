import SwiftUI
import SwiftData
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var category: Category = .dinner
    @State private var ingredients: [String] = []
    @State private var newIngredient = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photo: Data?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases) { Text($0.rawValue).tag($0) }
                    }
                }

                Section("Photo") {
                    PhotosPicker(selection: $photoItem, matching: .images) { [photo] in
                        if photo == nil {
                            Label("Choose Photo", systemImage: "photo")
                        } else {
                            RecipePhoto(data: photo)
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        }
                    }
                }

                Section("Ingredients") {
                    ForEach(ingredients, id: \.self) { Text($0) }
                        .onDelete { ingredients.remove(atOffsets: $0) }
                    HStack {
                        TextField("Add ingredient", text: $newIngredient)
                            .onSubmit(addIngredient)
                        Button("Add", systemImage: "plus.circle.fill", action: addIngredient)
                            .labelStyle(.iconOnly)
                            .disabled(newIngredient.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }
            }
            .navigationTitle("New Recipe")
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
            .task(id: photoItem) {
                if let photoItem {
                    photo = try? await photoItem.loadTransferable(type: Data.self)
                }
            }
        }
    }

    private func addIngredient() {
        let trimmed = newIngredient.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty, !ingredients.contains(trimmed) else { return }
        ingredients.append(trimmed)
        newIngredient = ""
    }

    private func save() {
        let recipe = Recipe(
            name: name.trimmingCharacters(in: .whitespaces),
            category: category,
            ingredients: ingredients,
            photo: photo
        )
        context.insert(recipe)
        dismiss()
    }
}
