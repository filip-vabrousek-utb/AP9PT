import Foundation

struct Place: Decodable {
    let name: String
    let country: String?
    let latitude: Double
    let longitude: Double
}

struct CurrentWeather: Decodable {
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

    var condition: (text: String, symbol: String) {
        switch weatherCode {
        case 0: ("Clear", "sun.max.fill")
        case 1, 2: ("Partly cloudy", "cloud.sun.fill")
        case 3: ("Overcast", "cloud.fill")
        case 45, 48: ("Fog", "cloud.fog.fill")
        case 51...57: ("Drizzle", "cloud.drizzle.fill")
        case 61...67, 80...82: ("Rain", "cloud.rain.fill")
        case 71...77, 85, 86: ("Snow", "cloud.snow.fill")
        case 95...99: ("Thunderstorm", "cloud.bolt.rain.fill")
        default: ("Unknown", "questionmark")
        }
    }
}

enum WeatherError: LocalizedError {
    case placeNotFound

    var errorDescription: String? { "City not found." }
}

// Open-Meteo: free, no API key required.
struct WeatherService {
    func findPlace(_ query: String) async throws -> Place {
        struct Response: Decodable { let results: [Place]? }
        var components = URLComponents(string: "https://geocoding-api.open-meteo.com/v1/search")!
        components.queryItems = [
            URLQueryItem(name: "name", value: query),
            URLQueryItem(name: "count", value: "1"),
        ]
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        guard let place = try JSONDecoder().decode(Response.self, from: data).results?.first else {
            throw WeatherError.placeNotFound
        }
        return place
    }

    func currentWeather(for place: Place) async throws -> CurrentWeather {
        struct Response: Decodable { let current: CurrentWeather }
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")!
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(place.latitude)"),
            URLQueryItem(name: "longitude", value: "\(place.longitude)"),
            URLQueryItem(name: "current", value: "temperature_2m,apparent_temperature,relative_humidity_2m,wind_speed_10m,weather_code"),
        ]
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        return try JSONDecoder().decode(Response.self, from: data).current
    }
}
