## Gradients

```swift
struct Grad: View {
    var body: some View {
        let grad = LinearGradient(gradient: .init(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing)

        return Circle()
            .fill(grad)
            .padding()
    }
}
```
