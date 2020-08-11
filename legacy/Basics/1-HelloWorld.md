## App struct

```swift
@main
struct Test: App {
    var body: some Scene {
        WindowGroup {
            Text("Hello World!")
        }
    }
}
```


## Jednoduchý View
* lze ním nahradit Text ve WindowGroup
```swift
struct MyView: View {
    var body: some View {
        Text("Hello")
    }
}
```


tedy:

```swift
@main
struct Test: App {
    var body: some Scene {
        WindowGroup {
            MyView()
        }
    }
}
```

