//
//  SwiftDataTest.swift
//  23-11-26-sk1
//
//  Created by Filip Vabroušek on 23.11.2026.
//

import SwiftUI
import SwiftData

@Model
final class Item {
    var name: String
    
    init(name: String){
        self.name = name
    }
}

// .modelContainer
// @Environment(modelContext)


