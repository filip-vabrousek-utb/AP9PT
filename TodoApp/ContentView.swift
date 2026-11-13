import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: [SortDescriptor(\TodoItem.createdAt)]) private var items: [TodoItem]
    @AppStorage("didSeedSamples") private var didSeedSamples = false

    @State private var deadlineFilter: DeadlineFilter = .all
    @State private var selectedTags: Set<String> = []
    @State private var showCompleted = true
    @State private var editorTarget: EditorTarget?

    private var allTags: [String] {
        Array(Set(items.flatMap(\.tags))).sorted()
    }

    private var filteredItems: [TodoItem] {
        items
            .filter { deadlineFilter.matches($0) }
            .filter { selectedTags.isEmpty || !selectedTags.isDisjoint(with: $0.tags) }
            .filter { showCompleted || !$0.isDone }
            .sorted(by: Self.order)
    }

    /// Open items first, then by deadline (soonest first, no deadline last), then creation date.
    private static func order(_ a: TodoItem, _ b: TodoItem) -> Bool {
        if a.isDone != b.isDone { return !a.isDone }
        switch (a.deadline, b.deadline) {
        case let (x?, y?) where x != y: return x < y
        case (_?, nil): return true
        case (nil, _?): return false
        default: return a.createdAt < b.createdAt
        }
    }

    private var activeFilterCount: Int {
        (deadlineFilter == .all ? 0 : 1) + selectedTags.count + (showCompleted ? 0 : 1)
    }

    var body: some View {
        NavigationStack {
            List {
                if !allTags.isEmpty {
                    Section {
                        TagFilterBar(tags: allTags, selected: $selectedTags)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                    }
                }

                Section {
                    ForEach(filteredItems) { item in
                        TodoRow(item: item) { tag in toggleTag(tag) }
                            .contentShape(Rectangle())
                            .onTapGesture { editorTarget = .edit(item) }
                            .swipeActions {
                                Button(role: .destructive) { context.delete(item) } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                } header: {
                    if activeFilterCount > 0 {
                        HStack {
                            Text("\(filteredItems.count) of \(items.count) shown")
                            Spacer()
                            Button("Clear filters", action: clearFilters)
                                .font(.caption)
                                .textCase(nil)
                        }
                    }
                }
            }
            .overlay {
                if filteredItems.isEmpty {
                    if items.isEmpty {
                        ContentUnavailableView("No Todos", systemImage: "checklist",
                                               description: Text("Tap + to add your first task."))
                    } else {
                        ContentUnavailableView("Nothing Matches", systemImage: "line.3.horizontal.decrease.circle",
                                               description: Text("Try a different deadline or tag filter."))
                    }
                }
            }
            .navigationTitle(deadlineFilter == .all ? "Todos" : deadlineFilter.rawValue)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { filterMenu }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { editorTarget = .new } label: { Image(systemName: "plus") }
                        .accessibilityLabel("Add Todo")
                }
            }
            .sheet(item: $editorTarget) { target in
                TodoEditorView(item: target.item, existingTags: allTags)
            }
            .onAppear(perform: seedIfNeeded)
        }
    }

    private var filterMenu: some View {
        Menu {
            Picker("Deadline", selection: $deadlineFilter) {
                ForEach(DeadlineFilter.allCases) { f in
                    Label("\(f.rawValue) (\(count(for: f)))", systemImage: f.systemImage).tag(f)
                }
            }
            Toggle("Show Completed", isOn: $showCompleted)
            if activeFilterCount > 0 {
                Divider()
                Button("Clear Filters", role: .destructive, action: clearFilters)
            }
        } label: {
            Image(systemName: activeFilterCount > 0
                  ? "line.3.horizontal.decrease.circle.fill"
                  : "line.3.horizontal.decrease.circle")
        }
        .accessibilityLabel("Filter")
    }

    private func count(for filter: DeadlineFilter) -> Int {
        items.filter { filter.matches($0) && (showCompleted || !$0.isDone) }.count
    }

    private func toggleTag(_ tag: String) {
        if selectedTags.contains(tag) { selectedTags.remove(tag) } else { selectedTags.insert(tag) }
    }

    private func clearFilters() {
        deadlineFilter = .all
        selectedTags = []
        showCompleted = true
    }

    private func seedIfNeeded() {
        guard !didSeedSamples else { return }
        didSeedSamples = true
        if items.isEmpty {
            TodoItem.sampleItems().forEach { context.insert($0) }
        }
    }
}

enum EditorTarget: Identifiable {
    case new
    case edit(TodoItem)

    var id: String {
        switch self {
        case .new: "new"
        case .edit(let item): "\(item.persistentModelID.hashValue)"
        }
    }

    var item: TodoItem? {
        if case .edit(let item) = self { return item }
        return nil
    }
}

// MARK: - Row

struct TodoRow: View {
    @Bindable var item: TodoItem
    var onTagTap: (String) -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button {
                withAnimation { item.isDone.toggle() }
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(item.isDone ? Color.green : Color.secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(item.isDone ? "Mark as not done" : "Mark as done")

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .strikethrough(item.isDone)
                    .foregroundStyle(item.isDone ? .secondary : .primary)

                if let deadline = item.deadline {
                    Label(deadlineText(deadline), systemImage: item.isOverdue() ? "exclamationmark.circle" : "calendar")
                        .font(.caption)
                        .foregroundStyle(item.isOverdue() ? .red : .secondary)
                }

                if !item.tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(item.tags, id: \.self) { tag in
                            Button("#\(tag)") { onTagTap(tag) }
                                .buttonStyle(.plain)
                                .font(.caption2.weight(.medium))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(TagColor.color(for: tag).opacity(0.18), in: Capsule())
                                .foregroundStyle(TagColor.color(for: tag))
                        }
                    }
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 2)
    }

    private func deadlineText(_ date: Date) -> String {
        let cal = Calendar.current
        let time = date.formatted(date: .omitted, time: .shortened)
        if cal.isDateInToday(date) { return "Today, \(time)" }
        if cal.isDateInTomorrow(date) { return "Tomorrow, \(time)" }
        if cal.isDateInYesterday(date) { return "Yesterday, \(time)" }
        return date.formatted(date: .abbreviated, time: .shortened)
    }
}

// MARK: - Tag filter bar

struct TagFilterBar: View {
    let tags: [String]
    @Binding var selected: Set<String>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    let isOn = selected.contains(tag)
                    Button {
                        if isOn { selected.remove(tag) } else { selected.insert(tag) }
                    } label: {
                        Text("#\(tag)")
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(isOn ? TagColor.color(for: tag) : Color(.secondarySystemGroupedBackground),
                                        in: Capsule())
                            .foregroundStyle(isOn ? Color.white : TagColor.color(for: tag))
                    }
                    .buttonStyle(.plain)
                    .accessibilityAddTraits(isOn ? .isSelected : [])
                }
            }
            .padding(.vertical, 4)
        }
    }
}

enum TagColor {
    private static let palette: [Color] = [.blue, .orange, .purple, .pink, .teal, .indigo, .mint, .brown]

    /// Stable color per tag (String.hashValue is randomized per launch, so sum scalars instead).
    static func color(for tag: String) -> Color {
        let sum = tag.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return palette[sum % palette.count]
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
