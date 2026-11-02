import Foundation

struct Note: Identifiable, Hashable {
    let id = UUID()
    var text: String

    var title: String {
        let firstLine = text.split(separator: "\n", maxSplits: 1).first.map(String.init) ?? ""
        return firstLine.isEmpty ? "New Note" : firstLine
    }

    var body: String {
        let parts = text.split(separator: "\n", maxSplits: 1)
        return parts.count > 1 ? String(parts[1]) : ""
    }

    var isEmpty: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Note {
    static let samples: [Note] = [
        Note(text: "Groceries\nMilk, eggs, bread, coffee"),
        Note(text: "Ideas\nA tiny app that only takes notes."),
        Note(text: "Call mom"),
        Note(text: "Books to read\nDune\nThe Pragmatic Programmer"),
    ]
}
