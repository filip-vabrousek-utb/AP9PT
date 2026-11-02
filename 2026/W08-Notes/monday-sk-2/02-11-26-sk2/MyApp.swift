import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavView()
        }
    }
}

struct NavView: View {
    let items = ["home", "hotels", "more"]
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self){ item in
                NavigationLink(item, value: item)
            }
            .navigationDestination(for: String.self) { item in
                
                if item == "home" {
                    Text("Detail \(item)").foregroundStyle(.orange)
                } else {
                    Text("Detail \(item)").foregroundStyle(.green)
                    OurDetail(name: item)
                    // Replace by OurDetail, pass item into it
                }
                
                
            }
            
        }
    }
}


struct OurDetail: View {
    var name: String
    
    var body: some View {
        Text(name).bold()
    }
}


/*
 PROMPT:
 SwiftUI app:
 1) App for taking notes, keep it simple
 2) square grid of notes
 3) two screens only
 4) 2nd detail will be used to edit
 5) no persistence yet
 
 
 
 
 What decisions did AI make?
 
 
 
 */






// Weather app
// Where is local state in Weather app
// Where is global state
// How is invalid data / empty view handled



