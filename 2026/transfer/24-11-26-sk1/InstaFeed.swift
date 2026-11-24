//
//  InstaFeed.swift
//  24-11-26-sk1
//
//  Created by Filip Vabroušek on 24.11.2026.
//

import SwiftUI

struct Post: Identifiable {
    var id = UUID()
    var url: URL
    var posterName: String
}

@Observable
class Fetcher {
    var posts = [Post]()
   
    func fetchPosts() {
            let p = Post(url: URL(string: "https://media.defense.gov/2026/Apr/03/2003906427/2000/2000/0/260401-X-KX339-1003.JPG")!,
                         posterName: "Eda")
        
        posts.append(p)
    }
}


struct InstaCell: View {
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image("art-2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(.circle)
                
                Text(post.posterName).bold()
                
                Spacer()
                
                Button("..."){
                    print("Show more")
                }
            }
            
            
            AsyncImage(url: post.url) { image in
                image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
               
            
        }
    }
}


struct ListView: View {
    @Environment(Fetcher.self) var fetcher
    @State var showSheet = false
    
    var body: some View {
       // Text("Len is \(fetcher.posts.count)")
        
        NavigationStack {
            List(fetcher.posts, id: \.id) { post in
                InstaCell(post: post)
            }.navigationTitle("Feed")
                .toolbar {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .listStyle(.plain)
        }.onAppear {
            fetcher.fetchPosts()
        }.sheet(isPresented: $showSheet) {
            SheetView()
        }
    }
}


struct SheetView: View {
    @Environment(Fetcher.self) var fetcher
    
    @State var text = ""
    
    var body: some View {
        TextField("Enter some text", text: $text)
            .font(.largeTitle)
        
        Button("+"){
            
            let p = Post(url: URL(string: "https://media.defense.gov/2026/Apr/03/2003906427/2000/2000/0/260401-X-KX339-1003.JPG")!, posterName: text)
            fetcher.posts.append(p)
        }
        
    }
}

#Preview {
    ListView().environment(Fetcher())
}
