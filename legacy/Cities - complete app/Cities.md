## Cities

```swift
//
//  ContentView.swift
//  MacTest
//
//  Created by Filip Vabroušek on 01/03/2020.
//  Copyright © 2020 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import MapKit
import UIKit


struct Park: Hashable, Codable {
    var name: String
    var lat: Double
    var lon: Double
    init(name: String, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}


struct Tabs: View {
    var body: some View {
        TabView {
            ContentView().tabItem {
                Text("Places")
            }

            FavouriteView().tabItem {
                Text("Welcome")
            }
        }
    }
}


struct FavouriteView: View {
    @EnvironmentObject var fav: Fav
    @State var search: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("Favourites").font(.headline).bold()
                Spacer()
            }

            TextField("Enter search term", text: $search).padding()

            if (fav.favourites.count > 0) {
                List(search.count > 0 ? fav.favourites.filter { $0.lowercased().contains(search.lowercased()) }: fav.favourites, id: \.self) { i in
                    Text(i).bold()
                }
            } else {
                Spacer()
                Text("Please add the favourite.").bold()
                Spacer()
            }
        }
    }
}


struct ContentView: View {
    @EnvironmentObject var fav: Fav

    @State var parks = [
        Park(name: "San Francisco", lat: 38, lon: -122),
        Park(name: "New York", lat: 40, lon: -74)
    ]

    @State var search = ""

    var body: some View {
        NavigationView {
            List(parks, id: \.self) { p in
                NavigationLink(destination: DetailView(park: p)) {
                    HStack {
                        if (self.fav.favourites.contains(p.name)) {
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                        }
                        Text(p.name)
                    }
                }

            }.navigationBarTitle("Parks")

        } .navigationViewStyle(StackNavigationViewStyle())
    }
}

// List(search.count > 0 ? parks.filter {search.contains($0.name.lowercased())} : parks, id:\.self){ p in

class Fav: ObservableObject {
    @Published var favourites = [String]()
}


struct DetailView: View {
    @EnvironmentObject var fav: Fav
    var park: Park
    var body: some View {

        VStack(alignment: .leading) {

            HStack {
                Text(park.name).font(.system(size: 30, weight: .black, design: .default)).padding()
                Button(self.fav.favourites.contains(self.park.name) ? "Remove" : "Favourite") {
                    if (self.fav.favourites.contains(self.park.name)) {
                        let idx = self.fav.favourites.index(of: self.park.name)!
                        self.fav.favourites.remove(at: idx)
                    } else {
                        self.fav.favourites.append(self.park.name)
                    }

                }
            }

            // HStack {
            Text("Places of interest").font(.system(size: 18, weight: .bold, design: .default)).padding()
            ScrollView(.horizontal) {
                HStack {
                    CircleImage()
                    CircleImage()
                }.frame(height: 100)
                    .padding()

            }
            //  }
            MapView(coordinate: .init(latitude: park.lat, longitude: park.lon))
        }




    }
}

struct CircleImage: View {
    var body: some View {
        VStack {
            Image("ny")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            Text("Empire").bold()
        }

    }
}

// + Instagram Feed


struct MapView {
    var coordinate: CLLocationCoordinate2D

    func makeMapView() -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateMapView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}


extension MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        makeMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateMapView(uiView, context: context)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```
