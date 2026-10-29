import SwiftUI

struct ContentView: View {
    @State private var query = "Prague"
    @State private var place: Place?
    @State private var weather: CurrentWeather?
    @State private var errorMessage: String?
    @State private var isLoading = false

    private let service = WeatherService()

    var body: some View {
        ZStack {
            LinearGradient(colors: backgroundColors, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                searchBar

                if let weather, let place {
                    weatherContent(weather, place: place)
                } else if let errorMessage {
                    Text(errorMessage).foregroundStyle(.white)
                } else {
                    ProgressView().tint(.white)
                }

                Spacer()
            }
            .padding()
        }
        .task { await load() }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search city", text: $query)
                .submitLabel(.search)
                .onSubmit { Task { await load() } }
            if isLoading { ProgressView() }
        }
        .padding(12)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 14))
    }

    private func weatherContent(_ weather: CurrentWeather, place: Place) -> some View {
        VStack(spacing: 20) {
            VStack(spacing: 4) {
                Text(place.name).font(.largeTitle.bold())
                if let country = place.country {
                    Text(country).font(.subheadline).opacity(0.8)
                }
                Label(weather.condition.text, systemImage: weather.condition.symbol)
                    .font(.headline)
                    .symbolRenderingMode(.multicolor)
                    .padding(.top, 4)
            }
            .foregroundStyle(.white)

            RealFeelCard(weather: weather)

            HStack(spacing: 12) {
                DetailTile(title: "Actual", value: "\(Int(weather.temperature.rounded()))°", symbol: "thermometer.medium")
                DetailTile(title: "Humidity", value: "\(Int(weather.humidity))%", symbol: "humidity.fill")
                DetailTile(title: "Wind", value: "\(Int(weather.windSpeed.rounded())) km/h", symbol: "wind")
            }
        }
    }

    private var backgroundColors: [Color] {
        guard let feels = weather?.feelsLike else { return [.blue, .indigo] }
        switch feels {
        case ..<0: return [.cyan, .blue]
        case ..<15: return [.blue, .indigo]
        case ..<25: return [.teal, .blue]
        default: return [.orange, .red]
        }
    }

    private func load() async {
        let trimmed = query.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let found = try await service.findPlace(trimmed)
            let current = try await service.currentWeather(for: found)
            withAnimation {
                place = found
                weather = current
                errorMessage = nil
            }
        } catch {
            withAnimation {
                place = nil
                weather = nil
                errorMessage = error.localizedDescription
            }
        }
    }
}

/// The highlighted "real feel" temperature — the hero of the screen.
struct RealFeelCard: View {
    let weather: CurrentWeather

    private var difference: Int {
        Int(weather.feelsLike.rounded()) - Int(weather.temperature.rounded())
    }

    private var explanation: String {
        switch difference {
        case ..<0: "Feels \(-difference)° colder than actual"
        case 1...: "Feels \(difference)° warmer than actual"
        default: "Feels the same as actual"
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Label("REAL FEEL", systemImage: "figure.walk")
                .font(.caption.bold())
                .tracking(2)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.yellow, in: .capsule)
                .foregroundStyle(.black)

            Text("\(Int(weather.feelsLike.rounded()))°")
                .font(.system(size: 120, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)
                .contentTransition(.numericText())
                .shadow(color: .yellow.opacity(0.6), radius: 20)

            Text(explanation)
                .font(.callout.weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(.white.opacity(0.15), in: .rect(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .strokeBorder(.yellow, lineWidth: 3)
        )
    }
}

struct DetailTile: View {
    let title: String
    let value: String
    let symbol: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: symbol).font(.title3)
            Text(value).font(.headline)
            Text(title).font(.caption).opacity(0.8)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.white.opacity(0.15), in: .rect(cornerRadius: 16))
    }
}

#Preview {
    ContentView()
}
