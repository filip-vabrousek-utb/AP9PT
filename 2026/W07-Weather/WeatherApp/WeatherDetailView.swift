import SwiftUI

struct WeatherDetailView: View {
    let location: Location
    let weather: CurrentWeather
    let units: Units

    var body: some View {
        VStack(spacing: 20) {
            header
            FeelsLikeCard(weather: weather, units: units)
            detailsGrid
        }
    }

    private var header: some View {
        VStack(spacing: 6) {
            Text(location.name)
                .font(.largeTitle.bold())
            if !location.subtitle.isEmpty {
                Text(location.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
            Label(weather.condition.description, systemImage: weather.condition.symbolName)
                .symbolRenderingMode(.multicolor)
                .font(.headline)
                .padding(.top, 4)
        }
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
    }

    private var detailsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
            DetailTile(title: "Actual", value: weather.temperature.degrees, systemImage: "thermometer.medium")
            DetailTile(title: "Low / High",
                       value: "\(weather.tempMin.degrees) / \(weather.tempMax.degrees)",
                       systemImage: "arrow.up.arrow.down")
            DetailTile(title: "Humidity", value: "\(weather.humidity)%", systemImage: "humidity.fill")
            DetailTile(title: "Wind",
                       value: "\(weather.windSpeed.formatted(.number.precision(.fractionLength(1)))) \(units.speedSymbol)",
                       systemImage: "wind")
            DetailTile(title: "Pressure", value: "\(Int(weather.pressure.rounded())) hPa", systemImage: "gauge.with.dots.needle.33percent")
            if let visibility = weather.visibility {
                DetailTile(title: "Visibility",
                           value: Measurement(value: visibility, unit: UnitLength.meters)
                               .formatted(.measurement(width: .abbreviated, usage: .road)),
                           systemImage: "eye.fill")
            }
        }
    }
}

/// The hero of the screen: the "feels like" temperature, with the actual
/// temperature shown as context rather than the headline.
struct FeelsLikeCard: View {
    let weather: CurrentWeather
    let units: Units

    private var difference: Int {
        Int(weather.feelsLike.rounded()) - Int(weather.temperature.rounded())
    }

    var body: some View {
        VStack(spacing: 8) {
            Label("FEELS LIKE", systemImage: "figure.walk")
                .font(.caption.weight(.bold))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.85))

            Text(weather.feelsLike.degrees)
                .font(.system(size: 112, weight: .heavy, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(.white)
                .contentTransition(.numericText())
                .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                .minimumScaleFactor(0.6)
                .lineLimit(1)

            Text(comparison)
                .font(.headline)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(.white.opacity(0.22), in: .capsule)
                .foregroundStyle(.white)

            Text(reason)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.85))
                .multilineTextAlignment(.center)
                .padding(.top, 2)
        }
        .padding(.vertical, 28)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(FeelsLikePalette.gradient(forCelsius: celsius(weather.feelsLike)))
                .overlay {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .strokeBorder(.white.opacity(0.35), lineWidth: 1)
                }
                .shadow(color: FeelsLikePalette.color(forCelsius: celsius(weather.feelsLike)).opacity(0.5),
                        radius: 24, y: 12)
        }
        .accessibilityElement(children: .combine)
    }

    private var comparison: String {
        let actual = "\(weather.temperature.degrees)\(units.temperatureSymbol.dropFirst())"
        switch difference {
        case 0: return "Same as the actual \(actual)"
        case ..<0: return "\(-difference)° colder than the actual \(actual)"
        default: return "\(difference)° warmer than the actual \(actual)"
        }
    }

    private var reason: String {
        let windKmh = units == .metric ? weather.windSpeed * 3.6 : weather.windSpeed * 1.609
        if difference <= -2, windKmh >= 10 {
            return "Wind chill is making it feel colder than it is."
        } else if difference >= 2, weather.humidity >= 50 {
            return "Humidity is making it feel warmer than it is."
        } else if difference >= 2 {
            return "Sun and still air are making it feel warmer."
        } else if difference <= -2 {
            return "Damp air is making it feel colder than it is."
        }
        return "Dress for what the thermometer says."
    }

    private func celsius(_ value: Double) -> Double {
        units == .metric ? value : (value - 32) * 5 / 9
    }
}

enum FeelsLikePalette {
    static func color(forCelsius t: Double) -> Color {
        switch t {
        case ..<0: Color(red: 0.25, green: 0.38, blue: 0.95)
        case ..<10: Color(red: 0.20, green: 0.60, blue: 0.95)
        case ..<18: Color(red: 0.10, green: 0.72, blue: 0.70)
        case ..<26: Color(red: 0.98, green: 0.62, blue: 0.15)
        default: Color(red: 0.95, green: 0.30, blue: 0.22)
        }
    }

    static func gradient(forCelsius t: Double) -> LinearGradient {
        let base = color(forCelsius: t)
        return LinearGradient(colors: [base.mix(with: .white, by: 0.15), base.mix(with: .black, by: 0.2)],
                              startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct DetailTile: View {
    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(title, systemImage: systemImage)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3.weight(.semibold))
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(.regularMaterial, in: .rect(cornerRadius: 18, style: .continuous))
    }
}

extension Double {
    var degrees: String { "\(Int(rounded()))°" }
}

#Preview {
    let location = MockWeatherService.locations[0]
    let weather = CurrentWeather(
        temperature: 4, feelsLike: -1, tempMin: 2, tempMax: 7,
        humidity: 72, pressure: 1014, windSpeed: 5.4, visibility: 10000,
        condition: Condition(code: 3, isDay: true)
    )
    ScrollView {
        WeatherDetailView(location: location, weather: weather, units: .metric).padding()
    }
    .background(.indigo.gradient)
}
