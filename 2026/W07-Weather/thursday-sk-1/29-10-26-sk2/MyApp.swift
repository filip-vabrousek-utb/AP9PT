import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            FetchView()
        }
    }
}


// URL
// https://jsonplaceholder.typicode.com/posts
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}


struct FetchView: View {
    @State var posts = [Post]()
    @State var isShown = false
    let url = "https://jsonplaceholder.typicode.com/posts"
    let wrongURL = "https://jsonfregerolder.typicode.com/posts"
    var body: some View {
        
    
        // Show something went wrong text on mistake (adress is worng etc) in UI
        
        if isShown {
            Text("Something went wrong")
            
            Button("Try again"){
                Task {
                    await fetch(url: url)
                }
            }
            
        } else {
            
            
            List(posts, id: \.id){ post in
                Text(post.title)
            }
        }
        
        
        
        
        
        Text("Fetcher")
            .task {
                await fetch(url: wrongURL)
            }
    }
    
    
    func fetch(url: String) async {
        /*
         [
           {
             "userId": 1,
             "id": 1,
             "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
             "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
           },
         */
        
        do {
            let url = URL(string: url)!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data) // 27520
            
            posts = try JSONDecoder().decode([Post].self, from: data)
            
            print("Posts count is \(posts.count)") // 100
            
            print(posts)
            
            isShown = false
            
        } catch {
            print("Something went wrong: \(error.localizedDescription)")
            isShown = true
        }
        
    }
}

/*
 What do I expect agent has done?
 Where is @State used, where is @ObservableObject used?
 Does search use observableObject
 How is glow effect created?
 
 
 
 */

#Preview {
    ContentView()
}
