## Modifiers
* upravují daný ```View```
* někdy záleží na pořadí


```swift
struct StyleView: View {
    var body: some View {
        VStack {
            Text("Styled text")
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .font(.system(size: 24))

            // usage with modifier
            Text("Modifier").modifier(M())
        }
    }
}

struct M: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(.blue)
    }
}
```
