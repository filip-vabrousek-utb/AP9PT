import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let emoji: String
    let color: Color
}

let fruits = [
    Fruit(name: "Jablko", emoji: "🍎", color: .red),
    Fruit(name: "Banán", emoji: "🍌", color: .yellow),
    Fruit(name: "Hrozno", emoji: "🍇", color: .purple),
    Fruit(name: "Pomeranč", emoji: "🍊", color: .orange),
]

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(fruits) { fruit in
                NavigationLink(value: fruit) {
                    Label(fruit.name, systemImage: "leaf")
                }
            }
            .navigationTitle("Ovoce")
            .navigationDestination(for: Fruit.self) { fruit in
                DetailView(fruit: fruit)
            }
        }
    }
}

struct DetailView: View {
    let fruit: Fruit

    var body: some View {
        VStack(spacing: 24) {
            Text(fruit.emoji)
                .font(.system(size: 100))
            Text(fruit.name)
                .font(.largeTitle.bold())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(fruit.color.opacity(0.15))
        .navigationTitle(fruit.name)
    }
}

#Preview {
    ContentView()
}
