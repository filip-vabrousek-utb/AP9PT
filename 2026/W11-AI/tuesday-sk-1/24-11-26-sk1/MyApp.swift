import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
          ListView()
                .environment(Fetcher())
        }
    }
}

struct CounterView: View {
    @AppStorage("count") private var count = 0
    @State private var taps = 0
    
    var body: some View {
        VStack {
            Text("Count \(count)")
            Text("Taps \(taps)")
            
            Button("+"){
                count += 1
                taps += 1
            }
        }
    }
}




// revise


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
        }.border(Color.green, width: 3)
            .font(.largeTitle)
    }
}

#Preview {
    Layout()
}





