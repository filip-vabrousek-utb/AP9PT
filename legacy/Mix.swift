//
//  ViewController.swift
//  MixUI
//
//  Created by Filip Vabroušek on 08/05/2020.
//  Copyright © 2020 Filip Vabroušek. All rights reserved.
//


import UIKit
import SwiftUI

struct Modern: View {
    var body: some View {
        VStack {
            Text("Hello").font(.system(size: 18)).bold()
            Text("Filip")
            Spacer()

            Group {
                Button(action: { print("Tapped") }) {
                    Text("Hello").foregroundColor(.white).padding()
                }
            }.background(Color.blue)

            //.clipShape(RoundedRectangle(cornerRadius: 6.0))
        }.frame(width: UIScreen.main.bounds.width * 0.8)
            .padding(20)
            .border(Color.blue, width: 3)
    }
}



class ViewController: UIViewController {

    var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "UIKit Label"
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 2.0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // UIKit (old way)
        var w = UIScreen.main.bounds.width
        view.addSubview(label)
        label.pin(a: .top, b: .left, ac: 100, bc: 0, w: w, h: 40, to: nil)

        // SwiftUI
        let host = UIHostingController(rootView: Modern())
        view.addSubview(host.view)
        host.view.pin(a: .top, b: .left, ac: 200, bc: 0, w: w, h: 40, to: nil)
    }
}


// label.frame = CGRect(x: 0, y: 100, width: w, height: 40)
   // host.view.frame = CGRect(x: 0, y: 200, width: w, height: 0)




extension UIView {
    enum P {
        case top
        case bottom
    }

    enum O {
        case left
        case right
        case center
        case middle
    }


    func pin(a: P, b: O, ac: CGFloat, bc: CGFloat, w: CGFloat, h: CGFloat, to: UIView?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        self.heightAnchor.constraint(equalToConstant: h).isActive = true


        print("S \(self)")
        let sup = self.superview!

        if a == .bottom {
            self.bottomAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor, constant: -ac).isActive = true // safeAR
        }
        //   navBar.pin(a: .top, b: .center, ac: 0, bc: 0, w: view.bounds.width, h: 20, to: nil)
        if a == .top && b != .center {
            self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }

        if a == .top && b == .center {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // ac
            self.centerYAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }

        if a == .bottom && b == .center { // new addition ???
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // newl
            self.centerYAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor, constant: ac).isActive = true
        }



        if a == .top && b == .middle {
            self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }

        if b == .right {
            self.rightAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.rightAnchor, constant: -bc).isActive = true
        }

        if b == .left {
            self.leftAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.leftAnchor, constant: bc).isActive = true
        }

        if a == .top && b == .center && to != nil {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // ac
            self.centerYAnchor.constraint(equalTo: (to?.bottomAnchor)!, constant: ac).isActive = true
        }

        if a == .bottom && b == .center && to != nil {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true // ac
            self.centerYAnchor.constraint(equalTo: (to?.bottomAnchor)!, constant: -ac).isActive = true
        }


    }
}
