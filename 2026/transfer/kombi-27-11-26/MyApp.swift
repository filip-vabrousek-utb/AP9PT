import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ShowView()
                .environment(Shared())
        }
    }
}


struct MyLayout: View {
    var body: some View {
        VStack {
            Text("Top")
            Text("Bottom")
        }
        
        HStack {
            Text("Left")
            Text("Right")
        }
        
        ZStack {
            Text("Above")
            Text("Below")
        }
    }
}


struct ModifierOrder: View {
    var body: some View {
        Text("Hello")
            .padding()
            .background(Color.orange)
    }
}


struct ImageView: View {
    var body: some View {
        Image(systemName: "sun.min.fill")
        
        Image("rocket")
            .resizable()
            .aspectRatio(contentMode: .fit)
        
        ModifierOrder()
            
    }
}


struct StateView: View {
    @State var counter = 0
    @State var text = ""
    
    var body: some View {
        Button("Increase counter \(counter)"){
            counter += 1
        }.foregroundStyle(counter > 3 ? .orange : .cyan)
            .font(.largeTitle)
        
        
        TextField("Enter some name", text: $text)
            
        
        Text(text).font(.largeTitle)
        
        BoundView(bound: $text)
    }
}


struct BoundView: View {
    var bound: Binding<String>
    
    var body: some View {
        Text(bound.wrappedValue).foregroundStyle(.orange)
            .font(.largeTitle)
    }
}


// Sheet, Multivie comm


// SwiftData
//@Model class Item
// newer persistence library
//  @Environment(\.modelContext) private var context access to context
// @Query(sort: \Item.createdAt) private var items: [Item] loading from storage
// .modelCotainer(for: Item.self) aloows the item to be saved, make persistent store
// WindowGrpoup {}



// Effects + Alltogehter

struct EffectView: View {
    @State var isAnimated = false
    
    var grad: LinearGradient {
        LinearGradient(colors: [.green, .orange], startPoint: .trailing,
                       endPoint: .leading)
    }
    
    var body: some View {
        Button("Anim"){
            withAnimation(.spring(duration: 0.4, bounce: 0.6)) {
                isAnimated.toggle()
            }
            
        }
        
        Rectangle()
            .fill(grad)
            .frame(width: 200, height: 200)
            .shadow(radius: 10)
            .rotationEffect(.degrees(isAnimated ? 80 : -80))
            .scaleEffect(isAnimated ? 0.6 : 1.0)
    }
}


#Preview {
   // ImageView()
    EffectView().padding()
}


