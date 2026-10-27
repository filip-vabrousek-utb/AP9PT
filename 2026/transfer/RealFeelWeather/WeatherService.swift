import Foundation

// Free Open-Meteo API, no key required.
// "Real feel" = Open-Meteo's apparent_temperature (wind chill + humidity + sun).

struct Place: Decodable {
    let name: String
    let country: String?
    let latitude: Double
    let longitude: Double
}

struct Forecast: Decodable {
    struct Current: Decodable {
        let temperature: Double
        let feelsLike: Double
        let humidity: Double
        let windSpeed: Double
        let weatherCode: Int

        enum CodingKeys: String, CodingKey {
            case temperature = "temperature_2m"
            case feelsLike = "apparent_temperature"
            case humidity = "relative_humidity_2m"
            case windSpeed = "wind_speed_10m"
            case weatherCode = "weather_code"
        }
    }

    struct Daily: Decodable {
        let time: [String]
        let weatherCode: [Int]
        let tempMax: [Double]
        let tempMin: [Double]
        let feelsMax: [Double]
        let feelsMin: [Double]

        enum CodingKeys: String, CodingKey {
            case time
            case weatherCode = "weather_code"
            case tempMax = "temperature_2m_max"
            case tempMin = "temperature_2m_min"
            case feelsMax = "apparent_temperature_max"
            case feelsMin = "apparent_temperature_min"
        }
    }

    let current: Current
    let daily: Daily
}

enum WeatherError: LocalizedError {
    case placeNotFound(String)

    var errorDescription: String? {
        switch self {
        case .placeNotFound(let name): "Couldn't find “\(name)”."
        }
    }
}

enum WeatherService {
    static func findPlace(_ name: String) async throws -> Place {
        struct Response: Decodable { let results: [Place]? }

        var url = URLComponents(string: "https://geocoding-api.open-meteo.com/v1/search")!
        url.queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "count", value: "1"),
        ]
        let (data, _) = try await URLSession.shared.data(from: url.url!)
        guard let place = try JSONDecoder().decode(Response.self, from: data).results?.first else {
            throw WeatherError.placeNotFound(name)
        }
        return place
    }

    static func forecast(for place: Place) async throws -> Forecast {
        var url = URLComponents(string: "https://api.open-meteo.com/v1/forecast")!
        url.queryItems = [
            URLQueryItem(name: "latitude", value: String(place.latitude)),
            URLQueryItem(name: "longitude", value: String(place.longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,apparent_temperature,relative_humidity_2m,wind_speed_10m,weather_code"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min"),
            URLQueryItem(name: "timezone", value: "auto"),
        ]
        let (data, _) = try await URLSession.shared.data(from: url.url!)
        return try JSONDecoder().decode(Forecast.self, from: data)
    }
}

// WMO weather codes -> SF Symbol + label.
func weatherInfo(_ code: Int) -> (symbol: String, label: String) {
    switch code {
    case 0: ("sun.max.fill", "Clear")
    case 1, 2: ("cloud.sun.fill", "Partly cloudy")
    case 3: ("cloud.fill", "Overcast")
    case 45, 48: ("cloud.fog.fill", "Fog")
    case 51...57: ("cloud.drizzle.fill", "Drizzle")
    case 61...67, 80...82: ("cloud.rain.fill", "Rain")
    case 71...77, 85, 86: ("cloud.snow.fill", "Snow")
    case 95...99: ("cloud.bolt.rain.fill", "Thunderstorm")
    default: ("cloud.fill", "Cloudy")
    }
}
