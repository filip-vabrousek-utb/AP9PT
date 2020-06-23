## Map

```swift
struct MapView: View {
    @State var region = MKCoordinateRegion(center: .init(latitude: 23.0, longitude: 52.0), span: .init(latitudeDelta: 0.6, longitudeDelta: 0.6))
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
}
```
