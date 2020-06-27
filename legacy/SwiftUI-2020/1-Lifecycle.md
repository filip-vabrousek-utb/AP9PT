## New lifecycle - iOS, iPadOS, macOS, tvOS, multiplatform

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




## SceneBuilder in Universal app
```swift
@main
struct Complex_GridsApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            Styles()
        }
        
        #if os(macOS)
        Settings {
            Text("Settings") // Will open in preferences
        }
        #endif
    }
}
```

## using AppDelegate

```swift
class Delegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        return true
    }
}

@main
struct MenuApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
          Text("Wow")
        }
    }
}
```
