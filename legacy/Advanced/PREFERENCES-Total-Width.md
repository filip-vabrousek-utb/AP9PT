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



## Rectangle that can fit both texts

```swift
struct BoundsKey: PreferenceKey {
    static var defaultValue: [Anchor<CGRect>] { return [] }
    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct NextView: View {
    var body: some View {
        VStack {
            Text("Rectangle can fit")
                .anchorPreference(key: BoundsKey.self, value: .bounds) { [$0] }

            Text("both text's widths.")
                .anchorPreference(key: BoundsKey.self, value: .bounds) { [$0] }
        }
            .backgroundPreferenceValue(BoundsKey.self) { preferences in
                GeometryReader { g in
                    VStack {
                        Rectangle()
                            .frame(width: g[preferences[0]].width + g[preferences[1]].width,
                                   height: 20)
                            .offset(y: 51)
                    }
                }
        }
    }
}
```
