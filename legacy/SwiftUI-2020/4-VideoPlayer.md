## Video Player
```swift
struct VideoView: View {
    var body: some View {
        VideoPlayer(player: AVPlayer(url: URL(string: "video.mp4")!))
    }
}
```
