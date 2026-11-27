//
//  CombinedAPp.swift
//  kombi-27-11-26
//
//  Created by Filip Vabroušek on 27.11.2026.
//

import SwiftUI

// @AppStoreg  = persistent storage

struct Item: Identifiable {
    var id = UUID()
    var name: String
    init(name: String){
        self.name = name
    }
}

@Observable
class Shared {
    var items = [Item]()
    
    // Sim of API call
    func fetch() {
        let it = Item(name: "Eda")
        items.append(it)
    }
}

struct ShowView: View {
    @Environment(Shared.self) var shared
    @State var showSheet = false
    
    var body: some View {
        Button("Show sheet"){
            showSheet.toggle()
        }
        
        List(shared.items, id: \.id){ item in
            Text(item.name)
        }.onAppear {
            shared.fetch()
        }.sheet(isPresented: $showSheet){
            SheetView()
        }
    }
}

struct SheetView: View {
    @Environment(Shared.self) var shared
    @State var text = ""
    
    var body: some View {
        TextField("Etner a name", text: $text)
        
        Button("Add text"){
            shared.items.append(Item(name: text))
        }
    }
}

