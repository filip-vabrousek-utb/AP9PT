#  # Recipe app review
## How does persistence work?
Data passed through modelContainer
URL: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W09-SwiftData/monday-sk-2/RecipeApp/RecipeApp.swift (line 17)

```
 @Environment(\.modelContext) private var context
  @Query(sort: \Recipe.name) private var recipes: [Recipe] 
```
(line 7, 8)


## How does deletion work?
delete method on context removes data from persistent storage.
```

  .contextMenu {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                context.delete(recipe)
                            }
                        }
