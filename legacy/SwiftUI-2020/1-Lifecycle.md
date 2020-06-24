## New lifecycle 

```swift
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Hello!")
        }
    }
}
```

## watchOS

```swift
@main
struct Complex_GridsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                Text("Hello!")
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
```
