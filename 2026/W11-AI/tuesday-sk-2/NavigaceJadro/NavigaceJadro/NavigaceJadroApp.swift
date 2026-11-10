//
//  NavigaceJadroApp.swift
//  NavigaceJadro
//
//  Jádro navigace z týdne 8 (Notes): seznam → detail.
//

import SwiftUI

struct Note: Identifiable, Hashable {        // 4. Hashable – jinak hodnotu nejde poslat do value:
    let id = UUID()
    var title: String
}

@main
struct NavigaceJadroApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var notes = [Note(title: "Nákup"), Note(title: "Škola"), Note(title: "Nápady")]

    var body: some View {
        NavigationStack {                      // 1. stack obaluje celou obrazovku
            List(notes) { note in
                NavigationLink(note.title, value: note)   // 2. odkaz nese hodnotu, ne obrazovku
            }
            .navigationTitle("Poznámky")
            .navigationDestination(for: Note.self) { note in   // 3. jedno místo: hodnota → detail
                Text(note.title)
                    .font(.largeTitle)
                    .navigationTitle(note.title)
            }
        }
    }
}

#Preview {
    ContentView()
}
