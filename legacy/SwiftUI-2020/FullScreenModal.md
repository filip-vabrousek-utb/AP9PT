## FullScreenModal

```swift
struct FullScreen: View {
    @State var present: Bool = false
    
    var body: some View {
        VStack{
            Button("Hello"){
                present.toggle()
            }.fullScreenCover(isPresented: $present) {
                Text("Wow")
            }
        }
    }
}
```
