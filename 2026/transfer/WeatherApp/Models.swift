import Foundation

struct Location: Hashable, Identifiable, Sendable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String?
    let state: String?

    var id: String { "\(lat),\(lon)" }

    var subtitle: String {
        [state, country].compactMap { $0 }.joined(separator: ", ")
    }
}

struct CurrentWeather: Sendable {
    let temperature: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    let pressure: Double
    let windSpeed: Double
    /// Meters.
    let visibility: Double?
    let condition: Condition
}

/// A WMO weather interpretation code, as returned by Open-Meteo.
struct Condition: Sendable {
    let code: Int
    let isDay: Bool

    var description: String {
        switch code {
        case 0: "Clear sky"
        case 1: "Mainly clear"
        case 2: "Partly cloudy"
        case 3: "Overcast"
        case 45, 48: "Fog"
        case 51, 53, 55: "Drizzle"
        case 56, 57: "Freezing drizzle"
        case 61: "Light rain"
        case 63: "Rain"
        case 65: "Heavy rain"
        case 66, 67: "Freezing rain"
        case 71: "Light snow"
        case 73: "Snow"
        case 75: "Heavy snow"
        case 77: "Snow grains"
        case 80, 81, 82: "Rain showers"
        case 85, 86: "Snow showers"
        case 95: "Thunderstorm"
        case 96, 99: "Thunderstorm with hail"
        default: "Unknown"
        }
    }

    var symbolName: String {
        switch code {
        case 0: isDay ? "sun.max.fill" : "moon.stars.fill"
        case 1, 2: isDay ? "cloud.sun.fill" : "cloud.moon.fill"
        case 3: "cloud.fill"
        case 45, 48: "cloud.fog.fill"
        case 51...57: "cloud.drizzle.fill"
        case 61...67, 80...82: isDay ? "cloud.sun.rain.fill" : "cloud.moon.rain.fill"
        case 71...77, 85, 86: "snowflake"
        case 95...99: "cloud.bolt.rain.fill"
        default: "cloud.fill"
        }
    }
}

enum Units: String, CaseIterable, Identifiable, Sendable {
    case metric, imperial

    var id: String { rawValue }
    var temperatureSymbol: String { self == .metric ? "°C" : "°F" }
    var speedSymbol: String { self == .metric ? "m/s" : "mph" }
}
