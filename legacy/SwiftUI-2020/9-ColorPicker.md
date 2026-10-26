## ColorPicker

```swift
struct Colors: View {
    @State private var color = Color.white
    
    var body: some View {
        ColorPicker("Set a color", selection: $color)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .labelsHidden()
    }
}
```
