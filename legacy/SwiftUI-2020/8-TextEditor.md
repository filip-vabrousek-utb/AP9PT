## TextEditor

```swift
struct Multiline: View {
    @State var text = ""
    
    var body: some View {
        TextEditor(text: $text)
    }
}
```
