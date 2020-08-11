## Total width of texts


```swift
import SwiftUI

struct RowFrame: PreferenceKey {
    static var defaultValue: [Anchor<CGRect>] { return [] }
    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> [Anchor<CGRect>]) {
        value.append(contentsOf: nextValue())
    }
}

struct Third: View {
    var w: CGFloat
    var body: some View {
        Text("\(Int(w))")
            .frame(width: w)
            .border(Color.blue, width: 3)
            .anchorPreference(key: RowFrame.self, value: .bounds) { [$0] }
    }
}

struct NextView: View {
    @State var sum: CGFloat = 0.0

    var body: some View {
        VStack {
            Text("Sum is \(Int(sum)).").padding(.bottom)
            Third(w: 40)
            Third(w: 40)
            Third(w: 40)
        }.overlayPreferenceValue(RowFrame.self) { value in // the value is filled here
            GeometryReader { g in
                Text("").onAppear {
                    (0..<3).forEach { self.sum += g[value[$0]].size.width }
                }
            }
        }
    }
}

```
