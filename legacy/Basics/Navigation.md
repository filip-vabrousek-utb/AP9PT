# Navigation

## List of destinations
```swift
struct Destinations: View {
    @State var dests = [Dest(name: "Yosemite"), Dest(name: "Wanaka"), Dest(name: "Manchester")]

    var body: some View {
        NavigationView {
            List(dests.reversed(), id: \.name) { t in
                NavigationLink(destination: Detail(dest: t)) {
                    Text(t.name)
                }
            }.navigationBarTitle("Travel")
        }
    }
}
```


## Detail View
```swift


struct Detail: View {
    var dest: Dest
    @State var w = UIScreen.main.bounds.width

    var body: some View {
        ScrollView {
            Image("yosemite")
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .frame(width: w, height: 130)

            HStack {
                Text(dest.name)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                Spacer()
            }

            Spacer()

            Text("Yosemite National Park  is an American national park located in the western Sierra Nevada of Central California, bounded on the southeast by Sierra National Forest and on the northwest by Stanislaus National Forest. The park is managed by the National Park Service and covers an area of 748,436 acres (1,169 sq mi; 3,029 km2) and sits in four counties: centered in Tuolumne and Mariposa, extending north and east to Mono and south to Madera County. Designated a World Heritage site in 1984, Yosemite is internationally recognized for its granite cliffs, waterfalls, clear streams, giant sequoia groves, lakes, mountains, meadows, glaciers, and biological diversity. Almost 95% of the park is designated wilderness.").padding()
        }
    }
}
```
