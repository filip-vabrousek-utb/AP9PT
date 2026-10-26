import SwiftUI
import Foundation

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            FetchView()
        }
    }
}

struct Post: Codable {
    let id: Int
    let title: String
}

struct FetchView: View {
    let myURL = "https://jsonplaceholder.typicode.com/posts"
    @State var posts = [Post]()
    @State var hasFailed = false
    
    var body: some View {
        if hasFailed {
            Text("Loading failed")
            
            Button("Try again"){
                Task {
                    await fetchData()
                }
            }
            
           
        } else {
            Button("Filter > 25 letter length"){
                posts = posts.filter { $0.title.count > 25 }
                // ["A", "ba", "cda"].filter {$0.count < 3 }
                
            }
            
            List(posts, id: \.id){ post in
                Text(post.title)
            }
        }
        
        Text("Fetch")
        .task {
          await fetchData()
        }
    }
    
    
     func fetchData() async {
        do {
            let url = URL(string: myURL)!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            posts = try JSONDecoder().decode([Post].self, from: data)
            print(posts.count)
            hasFailed = false
           // posts = try JSONDecoder().decode([Post].self, from: data)
        } catch {
            print("Fetch failed: \(error)")
            hasFailed = true
        }
    }
}

// Next weather app via Claude, openWeatherAPI
// What will be shown during the outage/wrongURL
// Will .task modifier be used
//

/*
 Make weather app in SwiftUI using Open Weather API
 Allow user to search any location using field.
 Highlight feels like temperature.
 */
