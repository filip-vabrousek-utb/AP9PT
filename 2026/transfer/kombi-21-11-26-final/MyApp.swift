import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
         // Text("Hello")
           // OurView()
            
           // NameView(name: "Karel")
          //  FetchView()
        
       // NavView()
         
            // Tasks()
              // .environment(TasksState())
            
            IntentTaskView()
            
        }
    }
}

struct OurView: View {
    var body: some View {
        Text("My view")
            .font(.largeTitle)
            .foregroundStyle(.orange)
            .padding()
            .background(.green)
    }
}


struct NameView: View {
    var name: String
    
    var body: some View {
        Text("Name is \(name)")
    }
}


struct MoreView: View {
    var body: some View {
        VStack {
            Text("Vertical")
            Text("Bottom")
        }
        
        HStack {
            Text("Left")
            Text("Right")
        }
        
        ZStack {
            Text("Top")
            Text("Bottom")
        }
        
    }
}


struct InstaCell: View {
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack {
                Image("artemis-II")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 60)
                     .clipShape(.circle)
                
                
                Text("NASA").bold()
                
                Spacer()
                
              /*  Button("..."){
                    
                } */
                
                Button {
                    print("Show more sheet")
                } label: {
                    Image(systemName: "ellipsis")
                }
            }.padding([.leading, .trailing])
            
            Image("artemis-II")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
            
          LikeView()
        }
        
        
       
            
    }
}


struct LikeView: View {
    var body: some View {
        HStack {
            Button {
                print("Show more sheet")
            } label: {
                Image(systemName: "heart.fill")
            }
            
            Button {
                print("Show more sheet")
            } label: {
                Image(systemName: "heart.fill")
            }
            
            Button {
                print("Show more sheet")
            } label: {
                Image(systemName: "heart.fill")
            }
        }.font(.largeTitle)
            .foregroundStyle(.black)
    }
}



#Preview {
    ScrollView {
        InstaCell()
        InstaCell()
        InstaCell()
    }
    
}



// State
//


struct StateView: View {
    @State var counter = 0
    
    var body: some View {
        Button("Count \(counter)"){
            counter += 1
        }
        
        if counter > 3 {
            Text("Counter is bigger than 3")
        }
    }
}

struct Current: Codable {
    var temperature_2m: Double
}

struct Forecast: Codable {
    let current: Current
}

struct FetchView: View {
    @State var response: String = ""
    
    func load(lat: Double = 49.22, lon: Double = 17.66) async throws -> Double {
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current=temperature_2m")!
        let (data, _) = try await URLSession.shared.data(from: url)
        print("DATA")
        print(data)
        return try JSONDecoder().decode(Forecast.self, from: data).current.temperature_2m
        
    }
    
   
    
    
    var body: some View {
        Text(response)
            .onAppear {
                print("View appeared")
              
            }
            .task {
                do {
                    
                    
                    let temp = try await load()
                    print("Temp is \(temp)")
                    response = "Temp is \(temp)"
                } catch {
                    
                }
            }
    }
}



struct NavView: View {
    @State var items = ["A", "B", "C"]
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                NavigationLink(item, value: item)
            }.navigationDestination(for: String.self) { item in
                Text("Nav dest is \(item)")
            }.navigationTitle("Hello")
        }
    }
}

@Observable
class TasksState {
   var tasks = [String]()
    
}

struct Tasks: View {
    @Environment(TasksState.self) private var tasks
    
    // @State var items = [String]()
   @State var text = ""
    
    var body: some View {
        TextField("Enter", text: $text)
        Button("Add item"){
            tasks.tasks.append(text)
        }
        
        List(tasks.tasks, id: \.self){ item in
            Text("Item is \(item)")
        }
        
        
        Text("Total of tasks")
        ControlView()
    }
}


struct ControlView: View {
    @Environment(TasksState.self) private var tasks
    
    var body: some View {
        Text("Task count is \(tasks.tasks.count)")
    }
}



struct IntentTaskView: View {
    @AppStorage("count") private var count = 0
    
    var body: some View {
        Text("Count \(count)")
        
        Button("Increase the count"){
            count += 1
        }
    }
}


