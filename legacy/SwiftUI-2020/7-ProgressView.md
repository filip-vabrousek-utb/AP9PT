## ProgressView

```swift
struct Progress: View {
    @State var amount = 90.0
    
    var body: some View {
        ProgressView("Downloading...", value: amount, total: 100)
    }
}
```

```swift
  ProgressView("Loading")
```
