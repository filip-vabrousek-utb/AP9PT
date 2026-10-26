## Core Data in SwiftUI


## appDelegate
```swift
 func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }


        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = ContentView().environment(\.managedObjectContext, context)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
```






## ContentView
```swift

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(entity: Tasks.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.content, ascending: false)]) var tasks: FetchedResults<Tasks>

    @State var text = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Enter a task", text: $text).padding()

                Button("+ task") {
                    let task = Tasks(context: self.managedObjectContext)
                    task.content = self.text
                    self.saveContext()
                    self.text = ""
                }
            }

            List {
                ForEach(tasks, id: \.content) {
                    Cell(task: $0)
                }.onDelete(perform: delete)
            }

        }
    }

    func delete(at offsets: IndexSet) {
        offsets.forEach { idx in
            let task = self.tasks[idx]
            self.managedObjectContext.delete(task)
        }

        saveContext()
    }

    func saveContext() {
        do {
            try managedObjectContext.save()
            print("SAVED")
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

```




## Cell
```swift
struct Cell: View {
    var task: Tasks
    var body: some View {
        Text("\(task.content!)").bold()
    }
}
```
