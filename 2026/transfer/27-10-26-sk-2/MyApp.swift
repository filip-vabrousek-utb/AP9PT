import SwiftUI

// https://jsonplaceholder.typicode.com/posts

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            LoadView()
        }
    }
}


/*
 [
   {
     "userId": 1,
     "id": 1,
     "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
     "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
   },
   {
 
 */

struct Post: Codable {
    let id: Int
    let title: String
}


struct LoadView: View {
    @State var posts = [Post]()
    @State var backup = [Post]()
    @State var hasFailed = false
    
    var body: some View {
        
        
        if hasFailed {
            Text("Loading failed")
            
            Button("Try again"){
                Task {
                    await load()
                }
            }
        } else {
            Button("Filter tasks that have more than 10 letters"){
                posts = posts.filter { $0.title.count > 20 }
            }
            
            Button("Reset filter"){
                posts = backup
            }
            
            List(posts, id: \.id){ p in
                Text(p.title)
            }
        }
        
        
        
        
        Text("Load")
            .task {
                
                await load()
            }
    }
    
    func load() async {
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            print(url.absoluteString)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            posts = try JSONDecoder().decode([Post].self, from: data)
            
            backup = posts
            
            print("Posts length \(posts.count)")
            hasFailed = false
            
        } catch {
            print("Something went wrong \(error.localizedDescription)")
            
            hasFailed = true
            
        }
        
    }
}


/*
 Write prompt for weather API app

 What do I expect from the agent:
 @Observable, @STate etc
 */
