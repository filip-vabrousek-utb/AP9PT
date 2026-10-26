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

## Previews
Preview Canvas slouží k živému náhledu našeho kódu. Po klepnutí na "+" v pravém horním rohu, můžeme na canvas přetáhnout jakýkoli, element. Změna Canvasu se automaticky projeví i v kódu, takže UI a kód je ve stálé synchronizaci.

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
            .previewDevice("iPhone 11 Pro Max")
            .previewDisplayName("MyPreview")
        // .frame(width: 100, height: 100)
    }
}

```
