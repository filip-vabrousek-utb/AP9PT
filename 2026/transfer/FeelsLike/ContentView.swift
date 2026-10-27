import SwiftUI

struct ContentView: View {
    @State private var city = City.all[0]
    @State private var weather: Weather?
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    header

                    if let weather {
                        RealFeelCard(weather: weather)
                        DetailsRow(weather: weather)
                        HourlyCard(hours: weather.hours)
                    } else if let errorMessage {
                        ContentUnavailableView("Couldn't load weather",
                                               systemImage: "wifi.exclamationmark",
                                               description: Text(errorMessage))
                    } else {
                        ProgressView().tint(.white).padding(.top, 120)
                    }
                }
                .padding()
            }
            .refreshable { await load() }
        }
        .foregroundStyle(.white)
        .task(id: city) { await load() }
    }

    private var header: some View {
        HStack {
            Menu {
                Picker("City", selection: $city) {
                    ForEach(City.all) { Text($0.name).tag($0) }
                }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                    Text(city.name).font(.title2.bold())
                    Image(systemName: "chevron.down").font(.caption.bold())
                }
                .foregroundStyle(.white)
            }
            Spacer()
        }
    }

    private var background: LinearGradient {
        let color = weather.map { Color.forTemperature($0.feelsLike) } ?? .blue
        return LinearGradient(colors: [color, color.opacity(0.6), .black.opacity(0.85)],
                              startPoint: .top, endPoint: .bottom)
    }

    private func load() async {
        do {
            let result = try await WeatherService.fetch(for: city)
            withAnimation { weather = result; errorMessage = nil }
        } catch is CancellationError {
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

// MARK: - Real feel hero

struct RealFeelCard: View {
    let weather: Weather

    var body: some View {
        VStack(spacing: 8) {
            Label("REAL FEEL", systemImage: "thermometer.variable.and.figure")
                .font(.caption.weight(.heavy))
                .tracking(1.5)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white.opacity(0.25), in: Capsule())

            Text(weather.feelsLike.degrees)
                .font(.system(size: 120, weight: .black, design: .rounded))
                .contentTransition(.numericText())
                .shadow(color: .black.opacity(0.25), radius: 8, y: 4)

            Text(weather.feelsLikeExplanation)
                .font(.callout.weight(.medium))
                .multilineTextAlignment(.center)
                .opacity(0.9)

            Divider().overlay(.white.opacity(0.4)).padding(.vertical, 8)

            HStack(spacing: 12) {
                Image(systemName: weather.symbolName)
                    .symbolRenderingMode(.multicolor)
                    .font(.title)
                VStack(alignment: .leading) {
                    Text(weather.conditionText).font(.headline)
                    Text("Actual \(weather.temperature.degrees)")
                        .font(.subheadline)
                        .opacity(0.8)
                }
                Spacer()
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial.opacity(0.6), in: RoundedRectangle(cornerRadius: 28))
        .overlay(RoundedRectangle(cornerRadius: 28).stroke(.white.opacity(0.35), lineWidth: 1))
    }
}

// MARK: - Details

struct DetailsRow: View {
    let weather: Weather

    var body: some View {
        HStack(spacing: 12) {
            tile("Humidity", "humidity.fill", "\(weather.humidity)%")
            tile("Wind", "wind", "\(Int(weather.windSpeed.rounded())) km/h")
        }
    }

    private func tile(_ title: String, _ icon: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(title, systemImage: icon).font(.caption).opacity(0.8)
            Text(value).font(.title2.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 18))
    }
}

// MARK: - Hourly

struct HourlyCard: View {
    let hours: [Weather.Hour]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Next 12 hours · real feel", systemImage: "clock")
                .font(.caption.weight(.semibold))
                .opacity(0.8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(hours) { hour in
                        VStack(spacing: 6) {
                            Text(hour.time, format: .dateTime.hour())
                                .font(.caption)
                                .opacity(0.8)
                            Text(hour.feelsLike.degrees)
                                .font(.title3.bold())
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.forTemperature(hour.feelsLike).opacity(0.6),
                                            in: Capsule())
                            Text(hour.temperature.degrees)
                                .font(.caption2)
                                .opacity(0.6)
                        }
                    }
                }
            }
        }
        .padding()
        .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 18))
    }
}

// MARK: - Helpers

extension Double {
    var degrees: String { "\(Int(rounded()))°" }
}

extension Color {
    /// Cold → blue, mild → teal/green, warm → orange, hot → red.
    static func forTemperature(_ t: Double) -> Color {
        switch t {
        case ..<0: Color(red: 0.25, green: 0.4, blue: 0.85)
        case ..<10: Color(red: 0.2, green: 0.55, blue: 0.85)
        case ..<18: Color(red: 0.15, green: 0.6, blue: 0.6)
        case ..<25: Color(red: 0.95, green: 0.6, blue: 0.2)
        case ..<32: Color(red: 0.95, green: 0.4, blue: 0.15)
        default: Color(red: 0.85, green: 0.15, blue: 0.15)
        }
    }
}

#Preview {
    ContentView()
}
