import SwiftUI

// Počasí z Open-Meteo. Ověření: curl -s "https://api.open-meteo.com/v1/forecast?latitude=49.22&longitude=17.66&current=temperature_2m"

struct Current: Codable {
    let temperature_2m: Double
}

struct Forecast: Codable {
    let current: Current
}

func load(lat: Double = 49.22, lon: Double = 17.66) async throws -> Double {
    let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current=temperature_2m")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(Forecast.self, from: data).current.temperature_2m
}

struct TempView: View {
    @State private var text = "…"

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .task {
                do { text = "\(try await load()) °C" }
                catch { text = "Chyba"; print(error) }
            }
    }
}

#Preview { TempView() }
