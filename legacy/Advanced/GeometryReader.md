## GeometryReader

```swift
struct Geometry: View {
    var body: some View {
        GeometryReader { g in
            Rectangle()
                .foregroundColor(Color.green)
                .frame(width: g.size.width / 2, height: 200)
                .offset(x: g.size.width / 2)

            Rectangle()
                .foregroundColor(Color.blue)
                .frame(width: g.size.width / 2, height: 200)

            Rectangle()
                .foregroundColor(Color.yellow)
                .frame(width: g.size.width, height: 200)
                .offset(y: g.size.width / 2)
        }
    }
}
```
