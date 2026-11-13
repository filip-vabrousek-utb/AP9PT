import Playgrounds

#Playground {
    
    
    print("Hello")
    
    var amount: Double = 200
    
    let pi = 3.14
    print(pi)
    print("Pi is \(pi)")
    
    if pi > 3 {
        print("Pi is bigger than 3")
    } else {
        print("Less than 3")
    }
    
    
    func multiply(a: Double, b: Double) -> Double {
        return a * b
    }
    
    let mt = multiply(a: 3, b: 6)
    print("Result is \(mt)")
    
    class Person {
        var name: String
        init(name: String){
            self.name = name
        }
    }
    
    let p = Person(name: "Filip")
    print(p.name)
    
    
    struct SPerson {
        var name: String
        init(name: String){
            self.name = name
        }
    }
    
    let sp = SPerson(name: "Filip")
    print(sp.name)
    
    
    protocol Aged {
        var age: Int { get }
    }
    
    struct AgedPerson: Aged {
        var name: String
        var age: Int
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    let pa = AgedPerson(name: "A", age: 30)
    print(pa.name)
    
    // return instance of class/struct that implements the protocol Aged
    func getAged() -> some Aged {
        return pa
    }
    
    let ag = getAged().age
    print("Age is \(ag)")
    
    
    
    
    
    
}
