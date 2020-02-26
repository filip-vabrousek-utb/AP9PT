# List 
* umožňuje vypsat více položek ve scrolovacím seznamu.

```swift
struct LView: View {
    @State var items = ["Filip", "Terka", "Honza"]

    var body: some View {
        List(items, id: \.self) { i in
            Text(i)
        }
    }
}
```

## State

```swift
struct Counter: View {
    @State var count = 0

    var body: some View {
        VStack {
            Button("Tap me") {
                self.count += 1
            }

            Text("Tapped: \(count)")
        }
    }
}
```


```swift

struct LView: View {
    @State var items = ["Filip", "Terka", "Honza"]
    @State var text = ""

    var body: some View {
        VStack {
            HStack {
                Button("+ item") {
                    self.items.insert(self.text, at: 0)
                }
                Spacer()
            }.padding()

            TextField("Enter item", text: $text).padding()

            List(items, id: \.self) { i in
                Text(i)
            }
        }
    }
}
```
