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
    let items = ["home", "friends", "profile"]
    
    var body: some View { NavigationStack { List(items, id: \.self) { item in NavigationLink(item, value: item)}
            .navigationDestination(for: String.self) { value in if value == "home" {
                
        Text(value).foregroundStyle(.orange)
    } else {
       // Text(value).foregroundStyle(.green)
     
        // add parameter here (value parameter)
        ChildView(title: value)
        
    }
}
                .onAppear {
                let arr = [2, 4, 6].map { $0 * $0}
                print(arr)
                
                
                //.map { $0 * $0 }
                
            }.navigationTitle("Houses")
        }
    }
}



struct ChildView: View  {
    var title: String
    var body: some View {
        Text("Title is \(title)")
    }
}
