import SwiftUI

// Fake JSON API: https://jsonplaceholder.typicode.com/todos

struct RemoteTodo: Identifiable, Codable {
    let id: Int
    var title: String
    var completed: Bool
}

@Observable
final class RemoteTodoStore {
    var todos: [RemoteTodo] = []

    func load() async throws {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos?_limit=10")!
        let (data, _) = try await URLSession.shared.data(from: url)
        todos = try JSONDecoder().decode([RemoteTodo].self, from: data)
    }
}

struct RemoteTodoListView: View {
    @State private var store = RemoteTodoStore()

    var body: some View {
        List(store.todos) { todo in
            Text(todo.title)
        }
        .task {
            do { try await store.load() }
            catch { print(error) }
        }
    }
}

#Preview { RemoteTodoListView() }
