import Playgrounds

#Playground {
    
    
    
    
    
    
    
    
    
    
    
    
    
    print("Hello")
    
    var name: String = "Eda"
    print(name)
    
    var myName = "Karel"
    print("My name is \(myName)")
    
    var amount = 7500
    
    if amount > 7000 {
        print("I have enough")
    } else {
        print("I don't have enough")
    }
    
    
    for i in 0..<3 {
        print("Hello \(i)")
    }
    
    
    func multiply(a: Double, b: Double) -> Double {
         a * b
    }
    
    let res = multiply(a: 3, b: 3)
    print("Res \(res)")
    
    
    class Person {
        var name: String
        init(name: String){
            self.name = name
        }
        
        func introduce() -> String {
            return "Hello \(self.name)"
        }
    }
    
    let p = Person(name: "Karel")
    print(p.name)
    print("Introduced: \(p.introduce())")
    
    
    
    
    struct PStruct {
        var name: String
        init(name: String){
            self.name = name
        }
    }
    
    let inst = PStruct(name: "Test")
    print(inst.name)
    
    
    // important
    protocol Aged {
        var age: Int { get set }
    }
    
    struct AgedPerson: Aged {
        var name: String
        var age: Int
        
        init(name: String, age: Int){
            self.name = name
            self.age = age
        }
    }
    
    // vrátí jakoukoli instanci třídy nebo struktury, která implementuje protokol Aged
    let pa = AgedPerson(name: "Eda", age: 23)
    print(pa.name)
    
    func returnAgedPerson() -> some Aged {
        return pa
    }
    
    let result = returnAgedPerson().age
    print("Age is \(result)")
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
}
