import SwiftUI

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

/*
 [
   {
     "userId": 1,
     "id": 1,
     "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
     "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
   },
   {
     "userId": 1,
     "id": 2,
     "title": "qui est esse",
     "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
   },
 */


struct FetchView: View {
    @State var posts = [Post]()
    @State var showError = false
    
    var body: some View {
        if showError {
            Text("Something went wrong")
            
            Button("Try again"){
                Task {
                    await load()
                 }
                }
        } else {
            List(posts, id: \.id) { p in
                Text(p.title)
            }
        }
        
        Text("Load data")
            .task {
                await load()
            }
        
    } // end body: some View
    
    
    func load() async {
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            print(url)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            posts = try JSONDecoder().decode([Post].self, from: data)
            
            print("Posts count \(posts.count)")
        } catch {
            print("Something went wrong \(error.localizedDescription)")
            showError = true
        }
    }
    
}


/*
 PROMPT FOR WEATHER APP USING API:
 Make simple SwiftUI Weather app, highlight real feel temperature.
 If you find existing project, make a new one.
 
 
 WHAT WE EXPECT:
 @observableObject?
 task modifier
 
 
 
 
 
 */
