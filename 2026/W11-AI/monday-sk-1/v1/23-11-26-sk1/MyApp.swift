import SwiftUI

@main
struct MyApp: App {
    let fetcher = Fetcher()
    
    var body: some Scene {
        WindowGroup {
            ListView().environment(fetcher)
        }
    }
}


struct Layout: View {
    var body: some View {
        VStack {
            Text("Top")
            Text("Bottom")
        }
        
        HStack {
            Text("Left")
            Text("Right")
        }
        
        ZStack {
            Text("Top")
                .foregroundStyle(.green)
            
            Text("Bottom")
        }.border(Color.orange, width: 3)
         .font(.largeTitle)
    }
}


