## EnvironmentObject

```swift
struct AView: View {
    @EnvironmentObject var set: Settings

    var body: some View {
        VStack {
            Button("Hey") {
                self.set.count += 1
            }

            // if we use ObservedObject, we have to pass it here
            BView()
        }
    }
}


struct BView: View {
    @EnvironmentObject var set: Settings

    var body: some View {
        Text("Count in 2nd BView is \(set.count)")
    }
}
```
