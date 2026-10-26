import Foundation

struct Post: Codable {
    let id: Int
    let title: String
}

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
let (data, _) = try await URLSession.shared.data(from: url)
let posts = try JSONDecoder().decode([Post].self, from: data)

for post in posts.prefix(5) {
    print("\(post.id). \(post.title)")
}
