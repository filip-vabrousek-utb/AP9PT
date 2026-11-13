import SwiftUI
import SwiftData

struct TodoEditorView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let item: TodoItem?
    let existingTags: [String]

    @State private var title: String
    @State private var hasDeadline: Bool
    @State private var deadline: Date
    @State private var tags: [String]
    @State private var newTag = ""

    init(item: TodoItem?, existingTags: [String]) {
        self.item = item
        self.existingTags = existingTags
        _title = State(initialValue: item?.title ?? "")
        _hasDeadline = State(initialValue: item?.deadline != nil)
        _deadline = State(initialValue: item?.deadline ?? Self.defaultDeadline())
        _tags = State(initialValue: item?.tags ?? [])
    }

    private static func defaultDeadline() -> Date {
        let cal = Calendar.current
        return cal.date(bySettingHour: 17, minute: 0, second: 0, of: .now) ?? .now
    }

    private var trimmedTitle: String { title.trimmingCharacters(in: .whitespacesAndNewlines) }

    private var suggestedTags: [String] {
        existingTags.filter { !tags.contains($0) }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("What needs to be done?", text: $title, axis: .vertical)
                }

                Section("Deadline") {
                    Toggle("Set deadline", isOn: $hasDeadline.animation())
                    if hasDeadline {
                        DatePicker("Due", selection: $deadline)
                        HStack {
                            quickDate("Today", days: 0)
                            quickDate("Tomorrow", days: 1)
                            quickDate("Next week", days: 7)
                        }
                    }
                }

                Section("Tags") {
                    if !tags.isEmpty {
                        ForEach(tags, id: \.self) { tag in
                            Text("#\(tag)").foregroundStyle(TagColor.color(for: tag))
                        }
                        .onDelete { tags.remove(atOffsets: $0) }
                    }
                    HStack {
                        TextField("Add tag (e.g. work, home)", text: $newTag)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .onSubmit(addNewTags)
                        Button("Add", action: addNewTags)
                            .disabled(TodoItem.normalizeTags(newTag).isEmpty)
                    }
                    if !suggestedTags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(suggestedTags, id: \.self) { tag in
                                    Button("+ #\(tag)") { tags.append(tag) }
                                        .buttonStyle(.bordered)
                                        .tint(TagColor.color(for: tag))
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }

                if let item {
                    Section {
                        Toggle("Completed", isOn: Binding(get: { item.isDone }, set: { item.isDone = $0 }))
                        Button("Delete Todo", role: .destructive) {
                            context.delete(item)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle(item == nil ? "New Todo" : "Edit Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save).disabled(trimmedTitle.isEmpty)
                }
            }
        }
    }

    private func quickDate(_ label: String, days: Int) -> some View {
        Button(label) {
            let cal = Calendar.current
            let base = cal.date(byAdding: .day, value: days, to: .now) ?? .now
            deadline = cal.date(bySettingHour: 17, minute: 0, second: 0, of: base) ?? base
        }
        .buttonStyle(.bordered)
        .font(.caption)
    }

    private func addNewTags() {
        for tag in TodoItem.normalizeTags(newTag) where !tags.contains(tag) {
            tags.append(tag)
        }
        newTag = ""
    }

    private func save() {
        addNewTags()
        let finalDeadline = hasDeadline ? deadline : nil
        if let item {
            item.title = trimmedTitle
            item.deadline = finalDeadline
            item.tags = tags
        } else {
            context.insert(TodoItem(title: trimmedTitle, deadline: finalDeadline, tags: tags))
        }
        dismiss()
    }
}
