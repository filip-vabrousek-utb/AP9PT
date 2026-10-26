struct RowFrame: PreferenceKey {
    static var defaultValue: [Anchor<CGRect>] { return [] }

    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> [Anchor<CGRect>]) {
        value.append(contentsOf: nextValue())
    }
}

struct Third: View {
    var text: String
    var body: some View {
        Text(text)
            .frame(width: 40)
            .font(.system(size: 20))
            .border(Color.blue, width: 3)
            .anchorPreference(key: RowFrame.self, value: .bounds) { [$0] }
    }
}

struct NextView: View {
    @State var sum:CGFloat = 0.0
    
    var body: some View {
        VStack {
            Text("Width of all texts is \(sum)").padding(.bottom)
            Third(text: "40")
            Third(text: "40")
            Third(text: "40")
        }.backgroundPreferenceValue(RowFrame.self) { value in
            GeometryReader { g in
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.green)
                        .frame(width: g[value[0]].size.width + g[value[1]].size.width + g[value[2]].size.width,
                               height: 30).onAppear {
                                self.sum = g[value[0]].size.width + g[value[1]].size.width + g[value[2]].size.width
                    }
                }
            }
        }
    }
}
