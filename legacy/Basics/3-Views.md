# Views

### Text
```swift
Text("Hello")
```

### Button
```swift
Button("Tap me") {
   print("tapped")
}
```


### Image
* před použitím obrázku je potřeba jej přetáhnout do složky `Assets.xcassets` a přejmenovat jej na "yosemite"
* nastavíme výšku, šířku a vysekneme jej do tvaru kruhu
* obrázek lze ze své původní pozice posunout nahoru o -100 bodů

```swift
struct IView: View {
    var body: some View {
        Image("yosemite")
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
             .offset(y: -100)

    }
}
```
