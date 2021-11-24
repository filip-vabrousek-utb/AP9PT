//
//  ContentView.swift
//  ToDo
//
//  Created by Student on 24.11.2021.
//

import SwiftUI

struct Host: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let l = UILabel()
        l.text = "Hello from UIKit"
        return l
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Update")
    }
}


// UIHostingController(rootView: MyView) in UIKit app


struct ViewWithUIKitView: View {
    var body: some View {
        VStack {
            Text("Hello from SwiftUI")
            Host()
        }
       
    }
}




struct ContentView: View {
    
    @State var items = [String]()
    @State var task = ""
    
    var body: some View {
        VStack {
            TextField("Enter task", text: $task)
            
            Button("Add task"){
                items.append(task)
            }
            
            List(items, id:\.self){ item in
                Text(item)
            }
            // TextField a navázat "task"
            // Button akce: přidání task do pole items
            // List a projít pole items
        }
    }
}


// po [UIApplication sharedApplication].keyWindow.recursiveDescription

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
