import SwiftUI
import SwiftData
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var category = Category.dinner
    @State private var ingredients: [String] = []
    @State private var newIngredient = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photo: Data?

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(Category.allCases) { Text($0.rawValue).tag($0) }
                }

                Section("Photo") {
                    PhotosPicker(photo == nil ? "Choose Photo" : "Change Photo", selection: $photoItem, matching: .images)
                    if photo != nil {
                        RecipePhoto(data: photo)
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }

                Section("Ingredients") {
                    ForEach(ingredients, id: \.self) { Text($0) }
                        .onDelete { ingredients.remove(atOffsets: $0) }
                    HStack {
                        TextField("Add ingredient", text: $newIngredient)
                            .onSubmit(addIngredient)
                        Button("Add", action: addIngredient)
                            .disabled(newIngredient.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }
            }
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onChange(of: photoItem) {
                Task { photo = try? await photoItem?.loadTransferable(type: Data.self) }
            }
        }
    }

    private func addIngredient() {
        let item = newIngredient.trimmingCharacters(in: .whitespaces)
        guard !item.isEmpty else { return }
        ingredients.append(item)
        newIngredient = ""
    }

    private func save() {
        addIngredient()
        context.insert(Recipe(name: name, category: category, ingredients: ingredients, photo: photo))
        dismiss()
    }
}
