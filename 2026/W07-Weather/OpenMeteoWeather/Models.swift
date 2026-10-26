import Foundation

struct Place: Codable, Hashable, Identifiable, Sendable {
    let id: String
    let name: String
    let region: String?
    let latitude: Double
    let longitude: Double

    static let currentLocationID = "current"

    var isCurrentLocation: Bool { id == Self.currentLocationID }

    /// Seed list for first launch (ids are the GeoNames ids Open-Meteo's geocoder returns).
    static let defaults = [
        Place(id: "3067696", name: "Prague", region: "Czechia", latitude: 50.08804, longitude: 14.42076),
        Place(id: "2643743", name: "London", region: "England, United Kingdom", latitude: 51.50853, longitude: -0.12574),
        Place(id: "5128581", name: "New York", region: "New York, United States", latitude: 40.71427, longitude: -74.00597),
    ]
}

struct Forecast: Sendable {
    struct Current: Sendable {
        let date: Date
        let temperature: Double
        let feelsLike: Double
        let humidity: Double
        let isDay: Bool
        let precipitation: Double
        let code: WeatherCode
        let pressure: Double
        let windSpeed: Double
        let windDirection: Double
    }

    struct Hour: Identifiable, Sendable {
        var id: Date { date }
        let date: Date
        let temperature: Double
        let code: WeatherCode
        let isDay: Bool
        let precipitationChance: Int?
    }

    struct Day: Identifiable, Sendable {
        var id: Date { date }
        let date: Date
        let code: WeatherCode
        let high: Double
        let low: Double
        let precipitationChance: Int?
        let sunrise: Date?
        let sunset: Date?
        let uvIndex: Double?
    }

    let timeZone: TimeZone
    let current: Current
    /// The next ~24 hours, starting with the current hour.
    let hourly: [Hour]
    let daily: [Day]
    let fetchedAt: Date

    var today: Day? { daily.first }
}

/// WMO weather interpretation code, as returned in Open-Meteo's `weather_code`.
struct WeatherCode: Hashable, Sendable {
    enum Category { case clear, partlyCloudy, cloudy, fog, drizzle, rain, snow, storm }

    let rawValue: Int

    var category: Category {
        switch rawValue {
        case 0, 1: .clear
        case 2: .partlyCloudy
        case 3: .cloudy
        case 45, 48: .fog
        case 51...57: .drizzle
        case 61...67, 80...82: .rain
        case 71...77, 85, 86: .snow
        case 95...99: .storm
        default: .cloudy
        }
    }

    var description: String {
        switch rawValue {
        case 0: "Clear"
        case 1: "Mostly Clear"
        case 2: "Partly Cloudy"
        case 3: "Overcast"
        case 45: "Fog"
        case 48: "Freezing Fog"
        case 51, 53: "Drizzle"
        case 55: "Heavy Drizzle"
        case 56, 57: "Freezing Drizzle"
        case 61: "Light Rain"
        case 63: "Rain"
        case 65: "Heavy Rain"
        case 66, 67: "Freezing Rain"
        case 71: "Light Snow"
        case 73: "Snow"
        case 75: "Heavy Snow"
        case 77: "Snow Grains"
        case 80, 81: "Showers"
        case 82: "Heavy Showers"
        case 85, 86: "Snow Showers"
        case 95: "Thunderstorm"
        case 96, 99: "Thunderstorm with Hail"
        default: "Unknown"
        }
    }

    func symbol(isDay: Bool) -> String {
        switch rawValue {
        case 0: isDay ? "sun.max.fill" : "moon.stars.fill"
        case 1, 2: isDay ? "cloud.sun.fill" : "cloud.moon.fill"
        case 3: "cloud.fill"
        case 45, 48: "cloud.fog.fill"
        case 51...55: "cloud.drizzle.fill"
        case 56, 57, 66, 67: "cloud.sleet.fill"
        case 61, 63: "cloud.rain.fill"
        case 65, 82: "cloud.heavyrain.fill"
        case 80, 81: isDay ? "cloud.sun.rain.fill" : "cloud.moon.rain.fill"
        case 71...77, 85, 86: "cloud.snow.fill"
        case 95...99: "cloud.bolt.rain.fill"
        default: "cloud.fill"
        }
    }
}

enum TemperatureUnit: String, CaseIterable, Identifiable {
    case celsius, fahrenheit

    var id: Self { self }

    var label: String {
        switch self {
        case .celsius: "Celsius (°C)"
        case .fahrenheit: "Fahrenheit (°F)"
        }
    }

    /// Open-Meteo is always queried in metric; conversion happens at display time.
    func temperature(_ celsius: Double) -> String {
        let value = self == .celsius ? celsius : celsius * 9 / 5 + 32
        return "\(Int(value.rounded()))°"
    }

    func windSpeed(_ kmh: Double) -> String {
        switch self {
        case .celsius: "\(Int(kmh.rounded())) km/h"
        case .fahrenheit: "\(Int((kmh / 1.609344).rounded())) mph"
        }
    }

    func precipitation(_ mm: Double) -> String {
        switch self {
        case .celsius: mm.formatted(.number.precision(.fractionLength(0...1))) + " mm"
        case .fahrenheit: (mm / 25.4).formatted(.number.precision(.fractionLength(0...2))) + " in"
        }
    }
}
