# SwiftUI Error reporting fix
* released in XCode 11.4 on 24/03/2020


```swift
Text("Hello, World!")
       .frame(width: 100, height: 60)
       .foregroundColor(.weird)
```
* OLD: Double is not convertible to CGFloat
* **NEW: type 'Color?' has no member "weird"**

```swift
Text("Animation").animation(.spring)
```
* OLD: type is ambiguous without more context
* **NEW: Member 'spring' expects argument of type '(response: Double, dampingFraction: Double, blendDuration: Double)'**


## Swift
```swift
let _: [String] = [41].map {foo($0)}
func foo(a: Int) -> String { return "a" }
func foo(a: String) -> String { return "a" }
```

* OLD - argument labels '(_:)' do not match any available overloads
* **NEW - missing argument label a: in call**


