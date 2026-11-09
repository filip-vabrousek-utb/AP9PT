import SwiftUI
import SwiftData



@Model
class Itema {
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
        }.modelContainer(for: Itema.self)
    }
}


struct ItemsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Itema.createdAt) private var items: [Itema]
    
    var body: some View {
        NavigationStack {
            List(items){ item in
                Text(item.name)
            }.toolbar {
                Button("Add"){
                    let item = Itema(name: "Item \(items.count + 1)")
                    context.insert(item)
                }
            }
        }
    }
}
