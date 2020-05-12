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
            /*  NavigationLink(destination: NextView()) {
                               Text("J").foregroundColor(.white).padding()
                           }  */
            Group {
                Button(action: { print("Tapped") }) {
                    Text("SwiftUI in UIKit").foregroundColor(.white).padding()
                }
            }.background(Color.blue)

            //.clipShape(RoundedRectangle(cornerRadius: 6.0))
        }.frame(width: UIScreen.main.bounds.width * 0.8)
            .padding(20)
            .border(Color.blue, width: 3)
    }
}

//  Present from UIKit :)
class NextController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
}




struct PresentNext: View {
    
    var str: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(str).foregroundColor(.blue).bold()
            Spacer()
            Spacer()
        }
    }
}



class WrapVC: UIViewController {
    
    var str = ""
    
    init(str: String){
        super.init(nibName: nil, bundle: nil)
        self.str = str
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let host = UIHostingController(rootView: PresentNext(str: str))
        host.view.frame = UIScreen.main.bounds
        view.addSubview(host.view)
    }
}






/*
class WrapperCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
      /*  let hvi = UIHostingController(rootView: CellView())
        addSubview(hvi.view)
        hvi.view.frame = self.frame*/
    }
    
    
    func updateUI(str: String){
        let hvi = UIHostingController(rootView: CellView(str: str))
        addSubview(hvi.view)
        hvi.view.frame = self.frame
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}  */




struct CellView: View {
    var str: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(str).bold()
        }
    }
}

/*
 var opener: UIButton = {
        let btn = UIButton()
        btn.setTitle("Push SwiftUI View", for: [])
        btn.addTarget(self, action: #selector(leave(sender:)), for: .touchUpInside)
        return btn
    }()
 */


// Songlist in Runny (open new UIViewController :D)
struct RacesView: View {
    @State var items = ["Filip", "Sára", "Jana"]
    var body: some View {
        List(items, id:\.self){ user in
            Text(user).bold()
        }
    }
}


class ListController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        let host = UIHostingController(rootView: RacesView())
        view.addSubview(host.view)
        host.view.pin(a: .bottom, b: .left, ac: 0, bc: 0, w: w, h: h - 90, to: nil)
    }
}









class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data = ["This", "is", "List"]
    
    @objc func leave(sender: UIButton!) {
        present(WrapVC(str: ""), animated: true, completion: nil)
    }

    lazy var table: UITableView = {
        let t = UITableView(frame: .zero)
        t.register(HostingTableViewCell<CellView>.self, forCellReuseIdentifier: "Cell")
        t.delegate = self
        t.dataSource = self
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        view.addSubview(table)
        table.pin(a: .bottom, b: .left, ac: 0, bc: 0, w: w, h: h - 80, to: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HostingTableViewCell<CellView>
        cell.host(CellView(str: data[indexPath.row]), parent: self)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WrapVC(str: data[indexPath.row])
        self.present(vc, animated: true, completion: nil)
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}







/*
 let childView = UIHostingController(rootView: SwiftUIView())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
        childView.didMove(toParent: self)
 
 
 
 
 */






// label.frame = CGRect(x: 0, y: 100, width: w, height: 40)
// host.view.frame = CGRect(x: 0, y: 200, width: w, height: 0)

/*var label: UILabel = {
     let label = UILabel()
     label.textColor = .white
     label.text = "UIKit Label"
     label.layer.borderColor = UIColor.white.cgColor
     label.layer.borderWidth = 2.0
     return label
 }()*/

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






/*
struct NextView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        NextController()
    }
}*/




class HostingTableViewCell<Content: View>: UITableViewCell {

    private weak var controller: UIHostingController<Content>?

    func host(_ view: Content, parent: UIViewController) {
        if let controller = controller {
            controller.rootView = view
            controller.view.layoutIfNeeded()
        } else {
            let swiftUICellViewController = UIHostingController(rootView: view)
            controller = swiftUICellViewController
            swiftUICellViewController.view.backgroundColor = .clear

            layoutIfNeeded()

            parent.addChild(swiftUICellViewController)
            contentView.addSubview(swiftUICellViewController.view)
            swiftUICellViewController.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: swiftUICellViewController.view!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))

            swiftUICellViewController.didMove(toParent: parent)
            swiftUICellViewController.view.layoutIfNeeded()
        }
    }
}
