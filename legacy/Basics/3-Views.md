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

### Toggle
```swift
struct ToggleView: View {
    @State var on = false

    var body: some View {
        VStack {
            Text("isOn: \(String(on))")

            Toggle(isOn: $on) {
                Text("")
            }.labelsHidden()
        }
    }
}}
}
```

### Slider
```swift
struct SliderView: View {
    @State var value = 0.1

    var body: some View {
        VStack {
            Text("Slider value is \(value)")
                .padding()

            Slider(value: $value)
                .padding()
        }
    }
}
```








### Image
* před použitím obrázku je potřeba jej přetáhnout do složky `Assets.xcassets` a přejmenovat jej na "yosemite"
* nastavíme výšku, šířku a vysekneme jej do tvaru kruhu
* obrázek lze ze své původní pozice posunout nahoru o -100 bodů pomocí metody ```offset```

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
