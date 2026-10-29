import SwiftUI

@main
struct WeatherFeelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class Machine {
    var id = UUID()
    var name: String = ""
    var age: Int = -1
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
}

struct MachineView: View {
    var machine: Machine
    
    var body: some View {
        Text("\(machine.name)").bold()
    }
}

#Preview {
    let machine = Machine(name: "Hello", age: 10)
    MachineView(machine: machine)
}
