import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
           BothView()
        }
    }
}


struct BothView: View {
    var body: some View {
        VStack {
            // compiler flag for OS
            #if os(macOS)
            Text("macOS")
            #else
            Text("iOS")
            #endif
        }
        
        // Greater version than macOS 27
        if #available(macOS 27, iOS 28, *) {
            Text("This OS is newer than /or  macOS 27 or iOS 28.")
        } else {
            Text("This OS is older than macOS 27 or iOS 28")
        }
        
        
        // macOS specific modifier
        FormView()
        
        
    }
}


struct FormView: View {
    @State private var isDone = false
    @State var priority = "Normal"
    
    var body: some View {
        // automatically gets different design
        Toggle("Done", isOn: $isDone)
        
        Picker("Priority", selection: $priority){
            Text("Low").tag("Low")
            Text("Normal").tag("Normal")
            Text("High").tag("High")
        }
       
        #if os(macOS)
        .pickerStyle(.radioGroup)
        .border(Color.green, width: 3)
        #endif
    }
}

// Debug view


