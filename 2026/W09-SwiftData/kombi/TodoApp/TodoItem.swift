import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String
    var isDone: Bool
    var deadline: Date?
    var tags: [String]
    var createdAt: Date

    init(title: String, isDone: Bool = false, deadline: Date? = nil, tags: [String] = [], createdAt: Date = .now) {
        self.title = title
        self.isDone = isDone
        self.deadline = deadline
        self.tags = tags
        self.createdAt = createdAt
    }

    func isOverdue(now: Date = .now) -> Bool {
        guard let deadline, !isDone else { return false }
        return deadline < Calendar.current.startOfDay(for: now)
    }
}

enum DeadlineFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case overdue = "Overdue"
    case today = "Today"
    case thisWeek = "Next 7 Days"
    case later = "Later"
    case none = "No Deadline"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .all: "tray.full"
        case .overdue: "exclamationmark.circle"
        case .today: "sun.max"
        case .thisWeek: "calendar"
        case .later: "calendar.badge.clock"
        case .none: "calendar.badge.minus"
        }
    }

    func matches(_ item: TodoItem, now: Date = .now) -> Bool {
        let cal = Calendar.current
        let startOfToday = cal.startOfDay(for: now)
        let startOfTomorrow = cal.date(byAdding: .day, value: 1, to: startOfToday)!
        let startOfWeekEnd = cal.date(byAdding: .day, value: 7, to: startOfToday)!

        switch self {
        case .all:
            return true
        case .none:
            return item.deadline == nil
        case .overdue:
            return item.isOverdue(now: now)
        case .today:
            guard let d = item.deadline else { return false }
            return d >= startOfToday && d < startOfTomorrow
        case .thisWeek:
            guard let d = item.deadline else { return false }
            return d >= startOfToday && d < startOfWeekEnd
        case .later:
            guard let d = item.deadline else { return false }
            return d >= startOfWeekEnd
        }
    }
}

extension TodoItem {
    static func normalizeTags(_ raw: String) -> [String] {
        var seen = Set<String>()
        return raw
            .split(whereSeparator: { $0 == "," || $0 == " " || $0 == "#" })
            .map { $0.trimmingCharacters(in: .whitespaces).lowercased() }
            .filter { !$0.isEmpty && seen.insert($0).inserted }
    }

    static func sampleItems() -> [TodoItem] {
        let cal = Calendar.current
        let today = cal.startOfDay(for: .now)
        func day(_ offset: Int, hour: Int = 17) -> Date {
            cal.date(byAdding: .hour, value: hour, to: cal.date(byAdding: .day, value: offset, to: today)!)!
        }
        return [
            TodoItem(title: "Submit expense report", deadline: day(-1), tags: ["work"]),
            TodoItem(title: "Buy groceries", deadline: day(0), tags: ["home", "errands"]),
            TodoItem(title: "Call the dentist", deadline: day(0, hour: 10), tags: ["health"]),
            TodoItem(title: "Prepare slides for Monday", deadline: day(3), tags: ["work"]),
            TodoItem(title: "Go for a run", isDone: true, deadline: day(0, hour: 7), tags: ["health"]),
            TodoItem(title: "Renew passport", deadline: day(20), tags: ["errands"]),
            TodoItem(title: "Read a book", tags: ["personal"]),
        ]
    }
}
