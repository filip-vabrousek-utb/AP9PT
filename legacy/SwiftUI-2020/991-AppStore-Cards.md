```swift

import SwiftUI

class Expaned: ObservableObject {
@Published var expanded = false
}

struct ContentView: View {
    @EnvironmentObject var exp: Expaned
    
    var body: some View {
        ScrollView {
            Featured()
            
            if !exp.expanded {
            Featured()
            Featured()
            }
        }
    }
}







struct Featured: View {
    @EnvironmentObject var exp: Expaned
    
    
    
    
    var body: some View {
       
            
        
        
        Group {

            if exp.expanded == false {
            ZStack(alignment: .bottomLeading){
                 Image("sahara")
                    .resizable()
                    .frame(width: 350, height: 350)
               
                HStack {
                    VStack(alignment: .leading) {
                        Text("FEATURED APP").bold()
    
                        Text("Hello")
                            .font(.title)
                            .bold()
                    }

                    Spacer()
                }.padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
                .frame(width: 350)
            }.clipShape(RoundedRectangle(cornerRadius: 12.0))
            .onTapGesture {
                withAnimation {
                    self.exp.expanded = !self.exp.expanded
                }
              
            }
                
               
        }
        
        

            if exp.expanded {
                
              
                VStack {
                    ScrollView {
                        ZStack(alignment: .bottomLeading){
                             Image("sahara")
                                .resizable()
                                .frame(width: 366, height: 366)
                           
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("FEATURED APP").bold()
                                    Text("Hello")
                                        .font(.title)
                                        .bold()
                                }

                                Spacer()
                            }.padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
                            .frame(width: 360)
                        } .onTapGesture {
                            withAnimation {
                                self.exp.expanded = !self.exp.expanded
                            }
                        }
                        
                        
                        Text("uhefow fewh fáewh áíewhgáíe hgoewhgweoihhgíáwe hgewá iuewo hgeiu giuew hiue giuew giew ugewhgiuew gie ie ugew i g iue giuew hgiueh giewh gi g ewiu hgiuew gieuw hgiuew hiwu gehi egiu ewghgieu iewu hg uewhi ughwigheiwughewoi giu he i ghe igheiwu ghiue hgiewh girew giuw giuw ghi ugrhgi giureh giur hg iui guh riu ghieru ghr gu hgiure gi u grrh giurghei hghire i gi g greghreiuh gh igr higeiu rgiuher iu reg ehirugheri ghreiu ghire g hr hgireu hgiure hiurg oeuhgw gi hiu gihgoierjhgorejghoerh goireh goirh gioe hgoier hgoigr h ioreh gior hioew hfoiew hfoiew hfiowe foh fwoei fio io")
                        
                        
                    }
                    
                    Spacer()
                }
            }
            
            
            
            
            
        }
          
           // .offset(x: 3)
           
           
        
        
        
        
        
        
        
        
        //}
}
}
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11  Pro")
    }
}
```
