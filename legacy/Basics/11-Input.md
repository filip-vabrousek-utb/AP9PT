# Input

### TextField

```swift
struct TF: View {
    @State var name = ""

    var body: some View {
        VStack {
            Text(name)
            TextField("Enter your name", text: $name)
        }
    }
}
```

### Picker
```swift
struct PickerView: View {
    @State var name = "Filip"
    @State var names = ["Filip", "Terka", "Honza"]

    var body: some View {
        Picker(selection: $name, label: Text("Hello")) {
            ForEach(0..<names.count) {
                Text(self.names[$0]).bold()
            }
        }.labelsHidden()
    }
}
```
