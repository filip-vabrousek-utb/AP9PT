import SwiftUI
import SwiftData

// K5–K6: přidání v sheetu + SwiftData (přežije zavření aplikace)
@Model
final class TodoItem {
    var title: String
    var isDone: Bool
    var createdAt: Date

    init(title: String) {
        self.title = title
        self.isDone = false
        self.createdAt = Date()
    }
}

// do souboru s @main:  WindowGroup { TodoListView() }.modelContainer(for: TodoItem.self)

struct TodoListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TodoItem.createdAt) private var todos: [TodoItem]
    @State private var showAdd = false

    var left: Int { todos.filter { !$0.isDone }.count }

    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    Button { todo.isDone.toggle() } label: {        // třída: měním přímo, bez indexu
                        Text(todo.title)
                            .strikethrough(todo.isDone)
                            .foregroundStyle(todo.isDone ? .secondary : .primary)
                    }
                }
                .onDelete { offsets in
                    for i in offsets { context.delete(todos[i]) }
                }
            }
            .overlay {
                if todos.isEmpty { Text("Nothing to do") }
            }
            .navigationTitle("\(left) left")
            .toolbar {
                Button("Přidat") { showAdd = true }
            }
            .sheet(isPresented: $showAdd) {
                AddTodoView()
            }
        }
    }
}

struct AddTodoView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Úkol", text: $title)
            }
            .navigationTitle("Nový úkol")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Zrušit") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Uložit") {
                        context.insert(TodoItem(title: title))
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    TodoListView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
