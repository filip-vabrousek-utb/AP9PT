import SwiftUI
import SwiftData

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView()
        }
        .modelContainer(for: TodoItem.self)
    }
}
