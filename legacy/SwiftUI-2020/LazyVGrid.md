## LazyVGrid

```swift
struct TwoColumn: View {
    var items = (0...99).map {"Item: \($0)"}
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(items, id: \.self){ i in
                    Text(i).bold()
                }
            }
        }
    }
}
```
