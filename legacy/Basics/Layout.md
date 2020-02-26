# Layout

## Zarovnání Views
* z ```body``` se musí vracet jen 1 View, takže vracíme ```Group```, který nemá vliv na layout
* ```VStack```: dá pohledy do vertikálního layoutu
* ```HStack```: dá pohledy do horizontálního layoutu

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

## Spacer
* flexibilní mezera mezi pohledy
```swift
HStack {
       Text("Pushed to the left.")
       Spacer()
       Text("Pushed to the right.")
}
```
