import Foundation

protocol WeatherService: Sendable {
    func searchLocations(_ query: String) async throws -> [Location]
    func currentWeather(for location: Location, units: Units) async throws -> CurrentWeather
}

enum WeatherError: LocalizedError {
    case notFound
    case server(Int, String?)

    var errorDescription: String? {
        switch self {
        case .notFound: "No matching location found."
        case .server(let code, let reason): reason ?? "The weather service returned an error (\(code))."
        }
    }
}

/// Open-Meteo (https://open-meteo.com) — free, no API key required.
struct OpenMeteoService: WeatherService {
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()

    func searchLocations(_ query: String) async throws -> [Location] {
        let response: GeocodingResponse = try await get("https://geocoding-api.open-meteo.com/v1/search", query: [
            URLQueryItem(name: "name", value: query),
            URLQueryItem(name: "count", value: "8"),
            URLQueryItem(name: "language", value: "en"),
        ])
        return (response.results ?? []).map {
            Location(name: $0.name, lat: $0.latitude, lon: $0.longitude, country: $0.country, state: $0.admin1)
        }
    }

    func currentWeather(for location: Location, units: Units) async throws -> CurrentWeather {
        let response: ForecastResponse = try await get("https://api.open-meteo.com/v1/forecast", query: [
            URLQueryItem(name: "latitude", value: String(location.lat)),
            URLQueryItem(name: "longitude", value: String(location.lon)),
            URLQueryItem(name: "current", value: "temperature_2m,apparent_temperature,relative_humidity_2m,pressure_msl,wind_speed_10m,weather_code,is_day,visibility"),
            URLQueryItem(name: "daily", value: "temperature_2m_max,temperature_2m_min"),
            URLQueryItem(name: "forecast_days", value: "1"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "temperature_unit", value: units == .metric ? "celsius" : "fahrenheit"),
            URLQueryItem(name: "wind_speed_unit", value: units == .metric ? "ms" : "mph"),
        ])
        let current = response.current
        return CurrentWeather(
            temperature: current.temperature2m,
            feelsLike: current.apparentTemperature,
            tempMin: response.daily.temperature2mMin.first ?? current.temperature2m,
            tempMax: response.daily.temperature2mMax.first ?? current.temperature2m,
            humidity: current.relativeHumidity2m,
            pressure: current.pressureMsl,
            windSpeed: current.windSpeed10m,
            visibility: current.visibility,
            condition: Condition(code: current.weatherCode, isDay: current.isDay == 1)
        )
    }

    private func get<T: Decodable>(_ endpoint: String, query: [URLQueryItem]) async throws -> T {
        var components = URLComponents(string: endpoint)!
        components.queryItems = query

        let (data, response) = try await session.data(from: components.url!)
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200..<300).contains(status) else {
            let reason = try? decoder.decode(ErrorResponse.self, from: data).reason
            throw WeatherError.server(status, reason)
        }
        return try decoder.decode(T.self, from: data)
    }
}

// MARK: Open-Meteo responses

private struct GeocodingResponse: Decodable {
    struct Result: Decodable {
        let name: String
        let latitude: Double
        let longitude: Double
        let country: String?
        let admin1: String?
    }

    /// Missing entirely when nothing matches.
    let results: [Result]?
}

private struct ForecastResponse: Decodable {
    struct Current: Decodable {
        let temperature2m: Double
        let apparentTemperature: Double
        let relativeHumidity2m: Int
        let pressureMsl: Double
        let windSpeed10m: Double
        let weatherCode: Int
        let isDay: Int
        let visibility: Double?

        enum CodingKeys: String, CodingKey {
            case temperature2m = "temperature_2m"
            case apparentTemperature = "apparent_temperature"
            case relativeHumidity2m = "relative_humidity_2m"
            case pressureMsl = "pressure_msl"
            case windSpeed10m = "wind_speed_10m"
            case weatherCode = "weather_code"
            case isDay = "is_day"
            case visibility
        }
    }

    struct Daily: Decodable {
        let temperature2mMax: [Double]
        let temperature2mMin: [Double]

        enum CodingKeys: String, CodingKey {
            case temperature2mMax = "temperature_2m_max"
            case temperature2mMin = "temperature_2m_min"
        }
    }

    let current: Current
    let daily: Daily
}

private struct ErrorResponse: Decodable {
    let reason: String
}

/// Offline sample data for SwiftUI previews and `-UseMockData` runs.
struct MockWeatherService: WeatherService {
    static let locations = [
        Location(name: "Prague", lat: 50.0875, lon: 14.4213, country: "Czechia", state: "Prague"),
        Location(name: "Paris", lat: 48.8534, lon: 2.3488, country: "France", state: "Île-de-France"),
        Location(name: "Phoenix", lat: 33.4484, lon: -112.0740, country: "United States", state: "Arizona"),
        Location(name: "Perth", lat: -31.9522, lon: 115.8614, country: "Australia", state: "Western Australia"),
    ]

    func searchLocations(_ query: String) async throws -> [Location] {
        try await Task.sleep(for: .milliseconds(250))
        return Self.locations.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    func currentWeather(for location: Location, units: Units) async throws -> CurrentWeather {
        try await Task.sleep(for: .milliseconds(400))
        let (temp, feels, code): (Double, Double, Int) = switch location.name {
        case "Phoenix": (38, 42, 0)
        case "Perth": (22, 22, 2)
        case "Paris": (11, 8, 61)
        default: (4, -1, 3)
        }
        let convert: (Double) -> Double = { units == .metric ? $0 : $0 * 9 / 5 + 32 }
        return CurrentWeather(
            temperature: convert(temp), feelsLike: convert(feels),
            tempMin: convert(temp - 2), tempMax: convert(temp + 3),
            humidity: 72, pressure: 1014,
            windSpeed: units == .metric ? 5.4 : 12.1,
            visibility: 10000,
            condition: Condition(code: code, isDay: true)
        )
    }
}
