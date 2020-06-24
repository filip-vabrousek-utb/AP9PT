# Grids

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




## LazyVStack
```swift
struct LazyStack: View {
    var items = (0...99).map {"Item: \($0)"}
    
    var body: some View {
        ScrollView {
           LazyVStack {
                ForEach(items, id: \.self){ i in
                    Text(i).bold()
                }
            }
        }
    }
}
```


## Layout types
```swift
struct GridView: View {
    let items = Array(1...1000).map {"Item \($0)"}
    
    
    let layout = [
        GridItem(.flexible(minimum: 80, maximum: 100)) // Stretches all the way :)
        // GridItem(.adaptive(minimum: 80)), if 30 => more will fit the screen
        // if 2 times only flexible() like 1fr 1fr :D
        // .fixed()
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 20) { // LazyHGrid(rows...)
                ForEach(items,id: \.self){ item in
                     Capsule()
                        .fill(Color.blue)
                        .frame(height: 80)
                }
            }
        }
    }
}
```
