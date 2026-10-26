## Label
```swift
 Label("Hello", image: "nature")
```


## Gauge
```swift
struct GaugeView: View {
    var body: some View {
        Gauge(value: 3.0, in: 3...10){
            Label("Water intake:", systemImage: "drop.fill")
                .foregroundColor(.green)
        } currentValueLabel: {
            Text("Value: 3.0")
        }
    }
}
```
