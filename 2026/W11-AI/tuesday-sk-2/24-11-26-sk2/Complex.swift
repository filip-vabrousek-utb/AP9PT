//
//  Complex.swift
//  24-11-26-sk2
//
//  Created by Filip Vabroušek on 24.11.2026.
//

import SwiftUI

// Complex example

struct Post: Identifiable {
    var id = UUID()
    var url: URL
    var posterName: String
}

@Observable
class Fetcher {
    var posts = [Post]()
    
    // Fake API call
    func fetchPosts() {
        let p = Post(url: URL(string: "https://www.collectspace.com/images/news-040726b-lg.jpg")!,
                     posterName: "Eda")
        posts.append(p)
    }
}


struct InstaCell: View {
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image("moon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(.circle)
                
                Text(post.posterName)
                Spacer()
            }
            
            
            AsyncImage(url: post.url) { image in
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
        NavigationStack {
            List(fetcher.posts, id: \.id){ post in
                InstaCell(post: post)
            }.navigationTitle("Feed")
                .toolbar {
                    Button("Show sheet"){
                        showSheet.toggle()
                    }
                }
        }.listStyle(.plain)
            .onAppear {
                fetcher.fetchPosts()
            }
            .sheet(isPresented: $showSheet) {
                SheetView()
            }
    }
}

struct SheetView: View {
    @Environment(Fetcher.self) var fetcher
    @State var text = ""
    
    var body: some View {
        Text("A")
        
        TextField("Enter poster name", text: $text)
        
        Button("Add post"){
            let p = Post(url: URL(string: "https://www.collectspace.com/images/news-040726b-lg.jpg")!, posterName: text)
            fetcher.posts.append(p)
        }
    }
}



#Preview {
    
}

// Effect
