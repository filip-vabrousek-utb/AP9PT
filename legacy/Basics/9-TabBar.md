## TabBar
```swift

struct ContentView: View {
    var body: some View {
        TabView {
            First().tabItem {
                Image(systemName: "heart.fill")
                Text("First")
            }
            
            Second().tabItem {
                Image(systemName: "heart.fill")
                Text("Second")
            }
        }
    }
}

struct First:View {
    var body: some View {
        Text("First view")
    }
}

struct Second: View {
    var body: some View {
        Text("Second view")
    }
}

```
