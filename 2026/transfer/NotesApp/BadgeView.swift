import SwiftUI

struct BadgeView: View {
    let name: String
    var isSelected = false

    var body: some View {
        Text(name)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .foregroundStyle(isSelected ? .white : .primary)
            .background(isSelected ? Color.accentColor : Color.secondary.opacity(0.2), in: Capsule())
    }
}
