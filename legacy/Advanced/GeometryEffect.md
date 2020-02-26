# GeometryEffect

```swift
struct EffectView: View {
    @State var skew: CGFloat = 0.3

    var body: some View {
        VStack {
            Text("Skewed")
                .font(.system(size: 40, weight: .heavy, design: .default))
                .background(Color.green)
                .modifier(Skew(skew: skew))
        }
    }
}


struct Skew: GeometryEffect {
    var skew: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: skew, d: 1, tx: 0.8, ty: 0))
        // tx is offset
    }
}
```
