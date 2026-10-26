//
//  ContentView.swift
//  ListUI
//
//  Created by Filip Vabroušek on 14/06/2020.
//  Copyright © 2020 Filip Vabroušek. All rights reserved.
//

import SwiftUI




class Message {
    var text: String = ""
    var incoming: Bool = false
    var date: String

    init(text: String, incoming: Bool, date: String) {
        self.text = text
        self.incoming = incoming
        self.date = date
    }
}

struct WrapperCell: View {

    var indexo: Int
    var prevDate = ""
    var text: Message
    var w = UIScreen.main.bounds.width

    var body: some View {
        VStack {

            if (prevDate != text.date) {
                Text(text.date).bold()
            }

            if (indexo == 0) {
                Text(text.date).bold()
            }






            if text.text.count == 0 {
                Image("tree")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: w / 2, maxHeight: w / 0.5)

            } else {


                HStack {
                    if (text.incoming) {
                        Spacer()
                        Rectangle().frame(width: w / 4)
                    }

                    Text(text.text)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 18))


                    if (!text.incoming) {
                        Spacer()
                        Rectangle().frame(width: w / 4)
                    }
                }







            }


        }

    }
}


struct ContentView: View {
    @State var items = [Message]()
    @State var initial = 18
    @State var date: String = "18/06/2020"
    @State var indexPathToSetVisible: IndexPath?

    var btn: some View {
        Button("Scroll to bottom") {
            let m = Message(text: Double.random(in: 0...1) > 0.7 ? "Some very long text, but I love that this doesn't breake !!" : "", incoming: Double.random(in: 0...1) > 0.5 ? true : false, date: self.date)
            self.items.append(m)
            self.indexPathToSetVisible = IndexPath(row: self.items.count - 1,
                section: 0)
        }
    }

    var changeDate: some View {
        Button("NEW Date") {
            self.initial += 1
            self.date = "\(self.initial)/06/20"
        }
    }

    var body: some View {
        VStack {
            HStack {
                btn
                changeDate
            }.padding()

            List {
                ForEach(0..<self.items.count, id: \.self) { indexo in
                    Group {
                        if (indexo > 0) {
                            WrapperCell(indexo: indexo, prevDate: self.items[indexo - 1].date, text: self.items[indexo])
                        } else {
                            WrapperCell(indexo: indexo, prevDate: self.items[indexo].date, text: self.items[indexo])
                        }
                    }
                }
            }.overlay(
                ScrollManagerView(indexPathToSetVisible: $indexPathToSetVisible)
                    .allowsHitTesting(false).frame(width: 0, height: 0)
            )
        }
    }
}



struct ScrollManagerView: UIViewRepresentable {

    @Binding var indexPathToSetVisible: IndexPath?

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let indexPath = indexPathToSetVisible else { return }
        let superview = uiView.findViewController()?.view

        if let tableView = superview?.subview(of: UITableView.self) {
            if tableView.numberOfSections > indexPath.section &&
                tableView.numberOfRows(inSection: indexPath.section) > indexPath.row {
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }

            //tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }

        DispatchQueue.main.async {
            self.indexPathToSetVisible = nil
        }
    }
}



extension UIView {
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }

    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




/*@State var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5",
        "Item 6", "Item 7", "Item 8", "Item 9", "",
        "Item 11", "Item 12", "Item 13"
    ].map { Message(text: $0, incoming: Double.random(in: 0...1) > 0.5 ? true : false, date: "14/06/2020") }
*/

