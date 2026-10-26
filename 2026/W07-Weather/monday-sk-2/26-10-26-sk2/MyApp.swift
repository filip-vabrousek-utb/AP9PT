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

struct FetchView: View {
    @State var posts = [Post]()
    @State var hasFailed = false
    
    var body: some View {
        if hasFailed {
            Text("Request has failed")
            
            Button("Try again"){
                Task {
                    await fetchData()
                }
            }
        } else {
            
            // Loading has failed show when loading fails
            List(posts, id: \.id) { post in
                Text(post.title).bold()
            }
        }
        
      
        
        
        Text("Fetch data")
            .task {
              await fetchData()
            }
    }
    
    
    func fetchData() async {
        /*
         
         {
            "userId": 1,
            "id": 1,
            "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
          },
         */
        
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/postsHGOIGIOP")!
            
            print("Appeared")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            posts = try JSONDecoder().decode([Post].self, from: data)
            
            print("Posts length is \(posts.count)")
            hasFailed = false
        } catch {
            print("Something went wrong")
            hasFailed = true
        }
    }
}

// FAKE API download data
// https://jsonplaceholder.typicode.com/posts



#Preview {
    FetchView()
}



/*
 PROMPT:
 Make SwiftUI Weather API app (Open-Meteo)
 
 WHAT TO PAY ATTENTION TO:
 Observable object for state
 What does it use local state for?
 How does it handle offline situations.
 
 */
