//
//  ContentView.swift
//  ListUI
//
//  Created by Filip Vabroušek on 14/06/2020.
//  Copyright © 2020 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var items = [
        "Item 1", "Item 2", "Item 3", "Item 4", "Item 5",
        "Item 6", "Item 7", "Item 8", "Item 9", "Item 10",
        "Item 11", "Item 12", "Item 13"
    ]

    @State var indexPathToSetVisible: IndexPath?

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<self.items.count, id: \.self) { index in
                    Text(self.items[index])
                }
            }.overlay(
                ScrollManagerView(indexPathToSetVisible: $indexPathToSetVisible)
                    .allowsHitTesting(false).frame(width: 0, height: 0)
            )
                .navigationBarTitle("Items")
                .navigationBarItems(
                    leading:
                        Button("Scroll to bottom") {
                            self.items.append("Item \(self.items.count + 1)")
                            self.indexPathToSetVisible = IndexPath(
                                row: self.items.count - 1, section: 0
                            )
                    }
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
