import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ListView().environment(Fetcher())
           // StorageView()
         //   ContentView()
        }
    }
}
