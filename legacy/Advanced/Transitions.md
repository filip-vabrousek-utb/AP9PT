## Transitions

```swift
struct Transition: View {
    @State var hide = false
    
    var body: some View {
        VStack {
            Spacer()

            Button("Tap to show the text") {
                withAnimation {
                    self.hide.toggle()
                }
            }

            Spacer()

            if (hide) {
                Text("Transition")
                     .transition(.slide)
                // .transition(AnyTransition.opacity.combined(with: .slide))
            }

            Spacer()
        }
    }
}
```


## Custom transitions
```swift
   Text("Transition")
          .transition(.fly)
```

```swift
extension AnyTransition {
    static var fly: AnyTransition {
        get {
            AnyTransition.modifier(active: Fly(pct: 0), identity: Fly(pct: 1))
        }
    }
}

struct Fly: GeometryEffect {
    var pct: CGFloat

    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(.init(scaleX: pct, y: pct))
    }
}
```
