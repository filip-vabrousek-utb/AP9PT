## SwiftUI

* v metodě ```scene``` v ```AppDelegate.swift``` změňte 
```swift 
let contentView = ContentView()
```
na
 ```swift
 let contentView = Welcome()
 ```
 
Následně definujte ```View``` Welcome
* tento kód zobrazí text "Hello" uprostřed obrazovky. Toto je kompletní aplikace ve SwiftUI!
```swift
struct Welcome: View {
    var body: some View {
        Text("Hello!")
    }
}
```

