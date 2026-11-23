//
//  InstaFeed.swift
//  23-11-26-sk1
//
//  Created by Filip Vabroušek on 23.11.2026.
//

import SwiftUI

struct Post: Identifiable {
    var id = UUID()
    var url: URL // AsyncImage
    var posterName: String
}

@Observable
class Fetcher {
    var posts = [Post]()
    
    // Fake API call
    func fetchPosts() {
        let p = Post(url: URL(string: "https://ca-times.brightspotcdn.com/dims4/default/dadc470/2147483647/strip/true/crop/675x1200+0+0/resize/1200x2133!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F71%2F19%2F1ed95d174e39b1202306121466c5%2F97a352d2f59d444d96d7c522e828380a.jpg")!,
                     posterName: "Eda")
        posts.append(p)
    }
}

struct InstaCell: View {
    var post: Post
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Image("artemis-pad")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(.circle)
                Text(post.posterName)
                Spacer()
            }//.border(Color.orange)
            
            AsyncImage(url: post.url){ im in
                im.image?.resizable()
                    .aspectRatio(contentMode: .fit)
                
            }
               // .resizable()
               
               
            
            
        
            
          
        }
    }
}

struct ListView: View {
    @Environment(Fetcher.self) var fetcher
    @State var sheetShown = false
    
    var body: some View {
        Text("Len is \(fetcher.posts.count)")
        
        NavigationStack {
            List(fetcher.posts, id: \.id) { post in
                InstaCell(post: post)
            }.toolbar {
                Button("Show sheet"){
                    sheetShown.toggle()
                }
            }
        }
        
        .listStyle(.plain)
            .onAppear {
                fetcher.fetchPosts()
                print("Len is \(fetcher.posts.count)")
            }
            .sheet(isPresented: $sheetShown) {
              SheetView()
            }
    }
}



struct SheetView: View {
    @Environment(Fetcher.self) var fetcher
    @State var text = ""
    
    var body: some View {
        TextField("Add post", text: $text)
        
        Button("Add post"){
            let post = Post(url: URL(string: "https://ca-times.brightspotcdn.com/dims4/default/dadc470/2147483647/strip/true/crop/675x1200+0+0/resize/1200x2133!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F71%2F19%2F1ed95d174e39b1202306121466c5%2F97a352d2f59d444d96d7c522e828380a.jpg")!, posterName: text)
            fetcher.posts.append(post)
        }
    }
}
#Preview {
   ListView().environment(Fetcher())
}

