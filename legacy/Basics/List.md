# List 
* umožňuje vypsat více položek ve scrolovacím seznamu.

```swift'
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

