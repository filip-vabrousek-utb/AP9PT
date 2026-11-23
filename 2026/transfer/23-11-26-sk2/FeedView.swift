//
//  FeedView.swift
//  23-11-26-sk2
//
//  Created by Filip Vabroušek on 23.11.2026.
//

import SwiftUI


// Insta Cell

// Profile image + name in a row

// Main post Image


// class Post
// title, URL

class Post: Identifiable {
    var id = UUID()
    var url: URL
    var title: String
    
    init(url: URL, title: String) {
        self.url = url
        self.title = title
    }
}

@Observable
class Fetcher {
    var posts = [Post]()
    
    // Simulate API call
    func fetchPosts() {
        let p = Post(url: URL(string: "https://cdn.arstechnica.net/wp-content/uploads/2026/02/55050650260_2530fea74e_k.jpg")!,
                     title: "NASA")
        posts.append(p)
    }
}








struct InstaCell: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: post.url){ image in
                    image.image
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                }
                       
                       
                    
                Text(post.title).bold()
                
                
                Spacer()
                
                Button("..."){
                    
                }
                
            }.padding()
            
            AsyncImage(url: post.url){ image in
                image.image?
                    .resizable()
                    .scaledToFit()
            }
            
            
           
        }
    }
}


struct ListView: View {
    @Environment(Fetcher.self) var fetcher
    @State var showSheet = false
    
    var body: some View {
        Button("Show sheet"){
            showSheet.toggle()
        }
        
        List(fetcher.posts) { post in
            InstaCell(post: post)
        }.listStyle(.plain)
            .onAppear {
                fetcher.fetchPosts()
            }
            .sheet(isPresented: $showSheet) {
                AddPostView()
            }
    }
}

struct AddPostView: View {
    @Environment(Fetcher.self) var fetcher
    @State var text: String = ""
    
    var body: some View {
       
            TextField("Enter some text", text: $text)
        
            Button {
                let p = Post(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPWT5-NZ-oBEBzU_U8asJFIkUHYNjIo7YPHRxM3GAP2_IKlGlfxYmhdi8&s=10")!, title: text)
                fetcher.posts.append(p)
            } label: {
                Image(systemName: "plus")
            }
        
      
        
        
        
    }
}



#Preview {
   ListView()
}

