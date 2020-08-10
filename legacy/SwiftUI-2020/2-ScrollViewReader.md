## ScrollViewReader

```swift
struct Finally: View {
    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                VStack {
                    Button("Scroll to bottom"){
                        withAnimation{
                            value.scrollTo(100, anchor: .bottom)
                        }
                    }
                    
                    ForEach(1...100, id: \.self){ idx in
                        Text("Number \(idx)").bold()
                    }
                }
            }
    }
  }
}
```


## 2nd example

```swift
struct ContentView: View {
    @State var items = Array(0...100)

    var body: some View {
            ScrollViewReader { sproxy in
                Text("Hide").hidden().onAppear {
                    // fetch here
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        sproxy.scrollTo(80, anchor: .bottom)
                    }
                }
                
                VStack {
                    Button("Add"){
                        items.append(items.count + 2)
                        sproxy.scrollTo(items.count - 1, anchor: .bottom)
                    }
                    
                    List(items, id:\.self){ item in
                        Text("\(item)").id(item)
                    }.padding()
                }
            }
    }
}
```
