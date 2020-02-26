# Layout

## VStack
* zarovná pohledy pod sebe
* z ```body``` se musí vracet jen 1 View, takže vracíme ```Group```, který nemá vliv na layout

```swift
struct ContentView: View {
    var body: some View {
        Group {
            VStack {
                Text("Above.")
                Text("Below.")
            }

            HStack {
                Text("On the left.")
                Text("On the right.")
            }
        }
    }
}
```
