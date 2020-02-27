# Layout

## VStack, HStack
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
* flexibilní mezera mezi Views
```swift
HStack {
   Text("Pushed to the left.")
   Spacer()
   Text("Pushed to the right.")
}
```



## ZStack
* zarovná pohledy nad sebe
```swift
struct DepthView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
            Text("I am above")
        }
    }
}
```


## Vlastní zarovnání
* můžeme ovlivnit zarovnání: např.

```swift
ZStack(alignment: .leading) {
        Rectangle()
           .fill(Color.blue)
           .frame(width: 100, height: 100)
        Text("I am above")
}
```
