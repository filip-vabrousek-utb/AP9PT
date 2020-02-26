
```swift
struct Counter: View {
    @State var count = 0

    var body: some View {
        VStack {
            Button("Tap me") {
                self.count += 1
            }

            Text("Tapped: \(count)")
        }
    }
}
```
