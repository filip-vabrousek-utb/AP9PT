import Foundation

struct Note: Identifiable {
    let id = UUID()
    var text = ""
    var badges: [String] = []

    var title: String {
        let firstLine = text.split(separator: "\n").first.map(String.init) ?? ""
        return firstLine.isEmpty ? "New Note" : firstLine
    }
}
