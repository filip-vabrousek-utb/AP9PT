## PageView

```swift
struct Pages: View {
    var body: some View {
        TabView {
            Text("Page 1")
            Text("Page 2")
            Text("Page 3")
        }.tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
```
