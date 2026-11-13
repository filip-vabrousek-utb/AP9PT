import SwiftUI

// Left CMD + S => Save
// Left CMS + R

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            BMI()
          //  MyView(name: "Karel")
        }
    }
}



struct MyView: View {
    var name: String
    
    var body: some View {
        Text("Hello \(name)")
            .foregroundStyle(.green)
            .font(.largeTitle)
    }
}


struct NextView: View {
    var body: some View {
        VStack {
            Text("Top")
            Text("Bottom")
        }.border(.orange, width: 3)
         .font(.largeTitle)
        
        HStack {
            Text("Left")
            Spacer()
            Text("Right")
        }.border(.green, width: 3)
    }
}



struct StyleView: View {
    var body: some View {
        Text("View will be styled")
            .font(.system(size: 40, weight: .black))
            .padding()
            .border(.green, width: 6)
    }
}


struct ImageView: View {
    var body: some View {
        Image("rocket")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
    }
}


struct ScrollTest: View {
    var body: some View {
        ScrollView {
            ForEach(0..<300){ i in
                // Text("Hello \(i)")
               
                VStack(alignment: .leading) {
                    
                    Text("Artemis II")
                        .bold()
                    
                    ImageView()
                    
                }
            }
        }
    }
}



// PLAN
// State counter, view hider by hand
// BMI by hand
// todo app via agent (prompt together)
// API app via agent (review)


struct InstaView: View {
    
    var body: some View {
        VStack(alignment: .leading){
            
            
            HStack(spacing: 0) {
                Image("nasa-logo-A")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                
                Text("NASA")
            }
            
            Image("rocket")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Button {
                    print("Like")
                } label: {
                    Image(systemName: "heart.fill")
                }
                
                Button {
                    print("Like")
                } label: {
                    Image(systemName: "heart")
                }
                
                Button {
                    print("Like")
                } label: {
                    Image(systemName: "scribble.variable")
                }
            }.font(.largeTitle)
                .foregroundStyle(.black)
            
            Button("Click"){
                print("Hello")
            }
               
        }
    }
}







struct StateView: View {
    @State var counter = 0
    
    var body: some View {
        Button("Count \(counter)"){
            counter += 1
        }.font(.largeTitle)
        
        if counter > 2 {
            Text("Bigger than 2")
        }
    }
}




struct BMI: View {
    @State var height = 0.0 //m
    @State var weight = 0.0 // kg
    
    var bmi: Double {
        return weight / (height * height)
    }
    
    var body: some View {
        Text("BMI")
        
        Slider(value: $height, in: 0...3)
        Text("\(height)")
        
        Slider(value: $weight, in: 0...30)
        Text("\(weight)")
        
        Text("Result BMI \(bmi)")
        
        

    }
}


struct Task: Identifiable {
    var id = UUID()
    var text: String
}

struct Tasks: View {
    @State var tasks = [Task]()
    @State var text = ""
    
    var body: some View {
        TextField("Enter task", text: $text)
        
        NavigationStack {
            List(tasks){ task in
                Text(task.text)
            }.toolbar {
                Button("+"){
                    let t = Task(text: text)
                    tasks.append(t)
                }
            }
        }
    }
}

#Preview {
    // MyView(name: "Eda")
    // NextView()
   // StyleView()
    // ImageView()
    
   // StateView()
   
 //   BMI()

    Tasks()
}









