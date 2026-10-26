import SwiftUI

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

@Observable
class PostStore {
    var posts: [Post] = []
    var isLoading = false
    var error: String?

    func fetch() async {
        isLoading = true
        error = nil

        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            let (data, _) = try await URLSession.shared.data(from: url)
            posts = try JSONDecoder().decode([Post].self, from: data)
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }
}

struct NetworkingExample: View {
    @State private var store = PostStore()

    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView("Načítám…")
                } else if let error = store.error {
                    ContentUnavailableView("Chyba", systemImage: "wifi.slash", description: Text(error))
                } else {
                    List(store.posts.prefix(20)) { post in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
            }
            .navigationTitle("Příspěvky")
            .task {
                await store.fetch()
            }
        }
    }
}

#Preview {
    NetworkingExample()
}
