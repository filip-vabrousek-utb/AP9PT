## Gradients

## Linear
```swift
struct Grad: View {
    var body: some View {
        let grad = LinearGradient(gradient: .init(colors: [.blue, .green]),
                                  startPoint: .leading,
                                  endPoint: .trailing)
        
        return Circle()
            .fill(grad)
            .padding()
    }
}
```

## Radial

```swift
let grad = RadialGradient(gradient: .init(colors: [.blue, .green]),
                                  center: .center,
                                  startRadius: 0,
                                  endRadius: 200)
```
