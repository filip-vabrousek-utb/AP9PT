import Foundation

struct City: Hashable, Identifiable {
    let name: String
    let latitude: Double
    let longitude: Double
    var id: String { name }

    static let all: [City] = [
        City(name: "Prague", latitude: 50.08, longitude: 14.44),
        City(name: "London", latitude: 51.51, longitude: -0.13),
        City(name: "New York", latitude: 40.71, longitude: -74.01),
        City(name: "Dubai", latitude: 25.20, longitude: 55.27),
        City(name: "Tokyo", latitude: 35.68, longitude: 139.69),
        City(name: "Reykjavík", latitude: 64.15, longitude: -21.94),
    ]
}

struct Weather {
    struct Hour: Identifiable {
        let time: Date
        let temperature: Double
        let feelsLike: Double
        var id: Date { time }
    }

    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let windSpeed: Double
    let code: Int
    let hours: [Hour]
}

// Open-Meteo: free, no API key. `apparent_temperature` is the "real feel".
private struct ForecastResponse: Decodable {
    struct Current: Decodable {
        let temperature_2m: Double
        let apparent_temperature: Double
        let relative_humidity_2m: Int
        let wind_speed_10m: Double
        let weather_code: Int
    }
    struct Hourly: Decodable {
        let time: [Double]
        let temperature_2m: [Double]
        let apparent_temperature: [Double]
    }
    let current: Current
    let hourly: Hourly
}

enum WeatherService {
    static func fetch(for city: City) async throws -> Weather {
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")!
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(city.latitude)"),
            URLQueryItem(name: "longitude", value: "\(city.longitude)"),
            URLQueryItem(name: "current", value: "temperature_2m,apparent_temperature,relative_humidity_2m,wind_speed_10m,weather_code"),
            URLQueryItem(name: "hourly", value: "temperature_2m,apparent_temperature"),
            URLQueryItem(name: "forecast_hours", value: "12"),
            URLQueryItem(name: "timeformat", value: "unixtime"),
            URLQueryItem(name: "timezone", value: "auto"),
        ]
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let response = try JSONDecoder().decode(ForecastResponse.self, from: data)

        let h = response.hourly
        let hours = h.time.indices.map { i in
            Weather.Hour(
                time: Date(timeIntervalSince1970: h.time[i]),
                temperature: h.temperature_2m[i],
                feelsLike: h.apparent_temperature[i]
            )
        }
        let c = response.current
        return Weather(
            temperature: c.temperature_2m,
            feelsLike: c.apparent_temperature,
            humidity: c.relative_humidity_2m,
            windSpeed: c.wind_speed_10m,
            code: c.weather_code,
            hours: hours
        )
    }
}

extension Weather {
    var conditionText: String {
        switch code {
        case 0: "Clear sky"
        case 1, 2: "Partly cloudy"
        case 3: "Overcast"
        case 45, 48: "Fog"
        case 51...57: "Drizzle"
        case 61...67, 80...82: "Rain"
        case 71...77, 85, 86: "Snow"
        case 95...99: "Thunderstorm"
        default: "—"
        }
    }

    var symbolName: String {
        switch code {
        case 0: "sun.max.fill"
        case 1, 2: "cloud.sun.fill"
        case 3: "cloud.fill"
        case 45, 48: "cloud.fog.fill"
        case 51...57: "cloud.drizzle.fill"
        case 61...67, 80...82: "cloud.rain.fill"
        case 71...77, 85, 86: "cloud.snow.fill"
        case 95...99: "cloud.bolt.rain.fill"
        default: "questionmark"
        }
    }

    /// Why the real feel differs from the thermometer reading.
    var feelsLikeExplanation: String {
        let diff = (feelsLike - temperature).rounded()
        if abs(diff) < 1 { return "Feels about the same as the actual temperature." }
        let amount = "\(Int(abs(diff)))°"
        if diff < 0 {
            return windSpeed >= 10
                ? "Feels \(amount) colder — wind chill from \(Int(windSpeed)) km/h wind."
                : "Feels \(amount) colder than the thermometer says."
        } else {
            return humidity >= 60
                ? "Feels \(amount) warmer — \(humidity)% humidity makes it muggy."
                : "Feels \(amount) warmer than the thermometer says."
        }
    }
}
