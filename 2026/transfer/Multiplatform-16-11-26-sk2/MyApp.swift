import SwiftUI

#if os(iOS)
import UIKit
#endif

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            BothView()
        }
    }
}


struct BothView: View {
    var body: some View {
        VStack {
            #if os(macOS)
            Text("macOS")
            #else
            Text("iOS")
            #endif
        }
        
        // * means on umarke platform treat condition as true
        if #available(macOS 27, iOS 28, *) {
            Text("This OS is newer then / or macOS 27 or iOS 28")
        } else {
            Text("This is older than macOS 27 or iOS 28")
        }
        
        
        FormView()
    }
}



struct FormView: View {
    @State var isDone = false
    @State var priority = "normal"
    
    var body: some View {
        Toggle("Done", isOn: $isDone)
            #if os(iPadOS)
            .border(Color.orange, width: 3)
            #endif
            .onAppear {
                #if os(iOS)
                let device = UIDevice.current.userInterfaceIdiom
                if device == .pad {
                    print("iPad")
                }
                #endif
            }
        
        
        
        Picker("Priority", selection: $priority){
            Text("Low").tag("low")
            Text("Normal").tag("normal")
            Text("High").tag("high")
        }
    }

}
