## Gestures

```swift
struct GestureView: View {
    @State var off = CGSize.zero

    var body: some View {
        VStack {
            Text("Tap me and watch the console.")
                .gesture(TapGesture().onEnded {
                        print("Tappped.")
                    })

            // You can drag this rectangle
            Rectangle()
                .fill(Color.blue)
                .frame(width: 80, height: 80)
                .offset(off)
                .gesture(DragGesture().onChanged {
                        self.off = $0.translation
                    })

        }
    }
}
```
