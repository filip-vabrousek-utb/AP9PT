## AppStoreOverlay

```swift
struct AppOverlay: View {
    @State var present: Bool = false
    
    var body: some View {
        VStack {
            Button("Show"){
                present.toggle()
            }.appStoreOverlay(isPresented: $present){
                SKOverlay.AppConfiguration(appIdentifier: "1483402813", position: .bottomRaised)
            }
        }
    }
}
```
