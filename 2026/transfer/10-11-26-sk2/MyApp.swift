import SwiftUI
import SwiftData

@Model
class Item {
    var name: String
    var createdAt: Date
    
    init(name: String){
        self.name = name
        self.createdAt = .now
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ItemsView()
        }.modelContainer(for: Item.self)
    }
}


struct ItemsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Item.createdAt) private var items: [Item]
    
    var body: some View {
        NavigationStack {
            List(items){ item in
                Text(item.name)
            }.toolbar {
                Button("+"){
                    let it = Item(name: "Item \(items.count + 1)")
                    context.insert(it)
                }
            }
        }
    }
}


