import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(Fetcher())
        }
    }
}


struct MyLayout: View {
    var body: some View {
        VStack {
            Text("Top")
            Text("Bottom")
        }
        
        HStack {
            Text("Left")
            Text("Right")
        }.padding(20)
         .border(Color.orange, width: 3)
    }
}


