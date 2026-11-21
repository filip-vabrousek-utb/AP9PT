import SwiftUI
import SwiftData

// Nejmenší SwiftData: data přežijí zavření aplikace.
// 1) @Model z obyčejné třídy udělá ukládaný model – final class, ne struct, a potřebuje init.
// 2) V souboru s @main přidat na WindowGroup:  .modelContainer(for: Item.self)
//    a do WindowGroup dát ItemsView().  Bez kontejneru se nic neuloží.
// 3) @Query si bere data z databáze a překreslí view, když se změní.
// 4) Přidat: context.insert(...), smazat: context.delete(...) – vždy přes kontext.
// Test: přidat 3 položky → zabít aplikaci v přepínači aplikací → znovu otevřít → jsou tam?

@Model
final class Item {
    var name: String
    var createdAt: Date

    init(name: String) {
        self.name = name
        self.createdAt = Date()
    }
}

struct ItemsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Item.createdAt) private var items: [Item]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.name)
                }
                .onDelete { offsets in
                    for index in offsets {
                        context.delete(items[index])   // z kontextu, ne z pole
                    }
                }
            }
            .navigationTitle("Položky: \(items.count)")
            .toolbar {
                Button("Přidat") {
                    context.insert(Item(name: "Položka \(items.count + 1)"))
                }
            }
        }
    }
}

#Preview {
    ItemsView()
        .modelContainer(for: Item.self, inMemory: true)   // náhled si nic neukládá
}
