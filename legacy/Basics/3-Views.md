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
* před použitím obrázku je potřeba jej přetáhnout do složky `Assets` a přejmenovat

```swift
struct IView: View {
    var body: some View {
        Image("yosemite")
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(Circle())

    }
}
```
