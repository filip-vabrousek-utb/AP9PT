import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
           NavTest()
        }
    }
}


struct NavTest: View {
    @State var items = ["Home", "View", "Profile"]
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
               NavigationLink(item, value: item)
            }.navigationDestination(for: String.self) { dest in
                Text("Destination \(dest)")
            }.navigationTitle("Notes")
        }
    }
}



