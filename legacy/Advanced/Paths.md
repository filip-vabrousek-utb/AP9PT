## Paths

```swift
struct Paths: View {
    var body: some View {
        Path { p in
            p.addEllipse(in: .init(x: 100, y: 100, width: 80, height: 80))
            p.closeSubpath()
        }
    }
}
```
