import SwiftUI

#if os(iOS)
import UIKit
#endif

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MyView()
        }
    }
}


struct MyView: View {
    var body: some View {
        #if os(macOS)
        Text("macOS")
        #else
        Text("iOS")
        #endif
        
        // * means on all other OSs the condition is true
        // iOS, macOS, iPadOS, watchOS, tvOS
        if #available(macOS 27, iOS 28, *) {
            Text("This is newer than / or macOS 27 or iOS 28")
        } else {
            Text("This is older than macOS 27 or iOS 28.")
        }
        
        
        FormView()
    }
}



struct FormView: View {
    @State var isDone = false
    @State var priority = "normal"
    
    var body: some View {
        Toggle("Done", isOn: $isDone)
            .font(.largeTitle)
            #if os(macOS)
            .border(Color.orange, width: 3)
            #endif
        
        Picker("Priority", selection: $priority){
            Text("Low").tag("low")
            Text("Normal").tag("normal")
            Text("High").tag("high")
        }
        #if os(macOS)
        .pickerStyle(.radioGroup)
        #endif
        .onAppear {
            // if the OS is iOS or iPadOS
            #if os(iOS)
            let device = UIDevice.current.userInterfaceIdiom
            if device == .pad {
                print("iPad")
            }
            #endif
        }
    }
}
