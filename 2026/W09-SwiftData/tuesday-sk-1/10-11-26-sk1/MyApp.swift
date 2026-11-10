import SwiftUI
import SwiftData

@Model
final class Item {
    var name: String
    
    init(name: String){
        self.name = name
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
    @Query private var items: [Item]
    
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



