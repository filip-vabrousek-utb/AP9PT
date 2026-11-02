import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
           NavView()
        }
    }
}


struct NavView: View {
    let items = ["Home", "Groups", "Settings"]
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self){ item in
                NavigationLink(item, value: item)
            }.navigationDestination(for: String.self) { item in
                
                if item == "Home"{
                    Text("Detail \(item)").foregroundStyle(.orange)
                } else {
                   // Text("Detail \(item)").foregroundStyle(.green)
                    // Note View instead of texts (Students did this)
                    NoteView(title: item)
                }
           
            }.navigationTitle("Notes")
        }
    }
}


struct NoteView: View {
    var title: String
    
    var body: some View {
        Text("Detail arg is \(title)")
        TextField("Some", text: .constant("Text"))
    }
}



/*
 We want app that makes notes
 
 PROMPT:
 Make Notes SwiftUI app:
 * List of notes
 * TextField to edit note on the detail screen
 * Allow badges to organise the notes
 * Allow filtering them by search terms and badges
 * Keep it KISS, do nothing else
 * No persistence yet
 
 
 
Code-review: to-do
 
 */












// Weather app
// What did agent decide? State, Observable (local/global state)
// GLOBAL STATE: @State private var model = WeatherViewModel()
// WHERE: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/monday-sk-1/WeatherApp/ContentView.swift
// LOCAL STATE: No local state

// Where is error/empty state shown in the UI?
// ContentUnavailableView
// WHERE: ContentUnavailableView {
// https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/monday-sk-1/WeatherApp/ContentView.swift



