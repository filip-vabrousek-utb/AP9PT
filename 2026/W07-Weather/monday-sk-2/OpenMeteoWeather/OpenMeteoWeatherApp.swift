import SwiftUI

@main
struct OpenMeteoWeatherApp: App {
    @State private var store = WeatherStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
