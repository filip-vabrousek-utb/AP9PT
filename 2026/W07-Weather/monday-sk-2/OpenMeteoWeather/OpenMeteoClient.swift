import Foundation

enum OpenMeteoError: LocalizedError {
    case http(Int, String?)

    var errorDescription: String? {
        switch self {
        case .http(let status, let reason): reason ?? "Open-Meteo returned an error (\(status))."
        }
    }
}

/// Open-Meteo (https://open-meteo.com) — free, no API key required.
struct OpenMeteoClient: Sendable {
    func search(_ query: String) async throws -> [Place] {
        let response: GeocodingResponse = try await get("https://geocoding-api.open-meteo.com/v1/search", [
            "name": query,
            "count": "10",
            "language": "en",
            "format": "json",
        ])
        return (response.results ?? []).map { result in
            let region = [result.admin1, result.country]
                .compactMap { $0 }
                .filter { $0 != result.name }
                .joined(separator: ", ")
            return Place(
                id: String(result.id),
                name: result.name,
                region: region.isEmpty ? nil : region,
                latitude: result.latitude,
                longitude: result.longitude
            )
        }
    }

    func forecast(latitude: Double, longitude: Double) async throws -> Forecast {
        let response: ForecastResponse = try await get("https://api.open-meteo.com/v1/forecast", [
            "latitude": String(latitude),
            "longitude": String(longitude),
            "current": "temperature_2m,apparent_temperature,relative_humidity_2m,is_day,precipitation,weather_code,pressure_msl,wind_speed_10m,wind_direction_10m",
            "hourly": "temperature_2m,weather_code,precipitation_probability,is_day",
            "daily": "weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max,sunrise,sunset,uv_index_max",
            "timezone": "auto",
            "timeformat": "unixtime",
            "forecast_days": "7",
        ])
        return response.forecast
    }

    private func get<T: Decodable>(_ endpoint: String, _ query: KeyValuePairs<String, String>) async throws -> T {
        var components = URLComponents(string: endpoint)!
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }

        let (data, response) = try await URLSession.shared.data(from: components.url!)
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200..<300).contains(status) else {
            let reason = try? JSONDecoder().decode(ErrorResponse.self, from: data).reason
            throw OpenMeteoError.http(status, reason)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - Responses

private struct ErrorResponse: Decodable {
    let reason: String
}

private struct GeocodingResponse: Decodable {
    struct Result: Decodable {
        let id: Int
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
        let time: Int
        let temperature: Double
        let apparentTemperature: Double
        let humidity: Double
        let isDay: Int
        let precipitation: Double
        let weatherCode: Int
        let pressure: Double
        let windSpeed: Double
        let windDirection: Double

        enum CodingKeys: String, CodingKey {
            case time, precipitation
            case temperature = "temperature_2m"
            case apparentTemperature = "apparent_temperature"
            case humidity = "relative_humidity_2m"
            case isDay = "is_day"
            case weatherCode = "weather_code"
            case pressure = "pressure_msl"
            case windSpeed = "wind_speed_10m"
            case windDirection = "wind_direction_10m"
        }
    }

    // Series values can be null at the edges of a model's range, hence the optionals.
    struct Hourly: Decodable {
        let time: [Int]
        let temperature: [Double?]
        let weatherCode: [Int?]
        let precipitationProbability: [Int?]
        let isDay: [Int?]

        enum CodingKeys: String, CodingKey {
            case time
            case temperature = "temperature_2m"
            case weatherCode = "weather_code"
            case precipitationProbability = "precipitation_probability"
            case isDay = "is_day"
        }
    }

    struct Daily: Decodable {
        let time: [Int]
        let weatherCode: [Int?]
        let high: [Double?]
        let low: [Double?]
        let precipitationProbability: [Int?]
        let sunrise: [Int?]
        let sunset: [Int?]
        let uvIndex: [Double?]

        enum CodingKeys: String, CodingKey {
            case time, sunrise, sunset
            case weatherCode = "weather_code"
            case high = "temperature_2m_max"
            case low = "temperature_2m_min"
            case precipitationProbability = "precipitation_probability_max"
            case uvIndex = "uv_index_max"
        }
    }

    let timezone: String
    let current: Current
    let hourly: Hourly
    let daily: Daily

    var forecast: Forecast {
        let date = { (seconds: Int) in Date(timeIntervalSince1970: TimeInterval(seconds)) }

        let hours = hourly.time.indices.compactMap { i -> Forecast.Hour? in
            // Keep the hour that's in progress, drop the ones already over.
            guard hourly.time[i] + 3600 > current.time,
                  let temperature = hourly.temperature[i],
                  let code = hourly.weatherCode[i]
            else { return nil }
            return Forecast.Hour(
                date: date(hourly.time[i]),
                temperature: temperature,
                code: WeatherCode(rawValue: code),
                isDay: hourly.isDay[i] != 0,
                precipitationChance: hourly.precipitationProbability[i]
            )
        }

        let days = daily.time.indices.compactMap { i -> Forecast.Day? in
            guard let high = daily.high[i], let low = daily.low[i], let code = daily.weatherCode[i] else { return nil }
            return Forecast.Day(
                date: date(daily.time[i]),
                code: WeatherCode(rawValue: code),
                high: high,
                low: low,
                precipitationChance: daily.precipitationProbability[i],
                sunrise: daily.sunrise[i].map(date),
                sunset: daily.sunset[i].map(date),
                uvIndex: daily.uvIndex[i]
            )
        }

        return Forecast(
            timeZone: TimeZone(identifier: timezone) ?? .current,
            current: Forecast.Current(
                date: date(current.time),
                temperature: current.temperature,
                feelsLike: current.apparentTemperature,
                humidity: current.humidity,
                isDay: current.isDay != 0,
                precipitation: current.precipitation,
                code: WeatherCode(rawValue: current.weatherCode),
                pressure: current.pressure,
                windSpeed: current.windSpeed,
                windDirection: current.windDirection
            ),
            hourly: Array(hours.prefix(25)),
            daily: days,
            fetchedAt: .now
        )
    }
}
