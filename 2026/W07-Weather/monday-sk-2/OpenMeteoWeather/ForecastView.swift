import SwiftUI

struct ForecastView: View {
    let place: Place
    @Environment(WeatherStore.self) private var store

    var body: some View {
        let forecast = store.forecasts[place.id]

        ZStack {
            LinearGradient(colors: Self.background(for: forecast?.current), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            if let forecast {
                ScrollView {
                    VStack(spacing: 16) {
                        header(forecast)
                        HourlyCard(forecast: forecast, unit: store.unit)
                        DailyCard(forecast: forecast, unit: store.unit)
                        DetailsGrid(forecast: forecast, unit: store.unit)
                        Link("Weather data by Open-Meteo.com", destination: URL(string: "https://open-meteo.com")!)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                    }
                    .padding()
                }
                .refreshable { await store.load(place, force: true) }
            } else if let error = store.errors[place.id] {
                ContentUnavailableView {
                    Label("Couldn't Load Weather", systemImage: "wifi.exclamationmark")
                } description: {
                    Text(error)
                } actions: {
                    Button("Try Again") { Task { await store.load(place, force: true) } }
                        .buttonStyle(.bordered)
                }
            } else {
                ProgressView()
                    .controlSize(.large)
            }
        }
        .environment(\.colorScheme, .dark)
        .navigationTitle(place.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            if !store.isSaved(place) {
                Button("Add", systemImage: "plus") { store.add(place) }
            }
        }
        .task { await store.load(place) }
    }

    private func header(_ forecast: Forecast) -> some View {
        let current = forecast.current
        let unit = store.unit

        return VStack(spacing: 4) {
            if let region = place.region {
                Text(region)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Text(unit.temperature(current.temperature))
                .font(.system(size: 96, weight: .thin))
                .monospacedDigit()
                .contentTransition(.numericText())
            Label(current.code.description, systemImage: current.code.symbol(isDay: current.isDay))
                .symbolRenderingMode(.multicolor)
                .font(.title3.weight(.medium))
            if let today = forecast.today {
                Text("H:\(unit.temperature(today.high))  L:\(unit.temperature(today.low))")
                    .font(.headline)
                    .monospacedDigit()
            }
        }
        .padding(.vertical, 24)
    }

    static func background(for current: Forecast.Current?) -> [Color] {
        guard let current else { return [Color(white: 0.3), Color(white: 0.15)] }
        guard current.isDay else {
            return [Color(red: 0.04, green: 0.07, blue: 0.20), Color(red: 0.18, green: 0.20, blue: 0.38)]
        }
        return switch current.code.category {
        case .clear: [Color(red: 0.16, green: 0.47, blue: 0.90), Color(red: 0.45, green: 0.72, blue: 0.98)]
        case .partlyCloudy: [Color(red: 0.25, green: 0.48, blue: 0.80), Color(red: 0.55, green: 0.68, blue: 0.85)]
        case .cloudy, .fog: [Color(red: 0.38, green: 0.45, blue: 0.55), Color(red: 0.60, green: 0.65, blue: 0.72)]
        case .drizzle, .rain: [Color(red: 0.22, green: 0.30, blue: 0.42), Color(red: 0.40, green: 0.48, blue: 0.58)]
        case .snow: [Color(red: 0.45, green: 0.55, blue: 0.68), Color(red: 0.72, green: 0.78, blue: 0.86)]
        case .storm: [Color(red: 0.17, green: 0.15, blue: 0.30), Color(red: 0.35, green: 0.32, blue: 0.48)]
        }
    }
}

// MARK: - Cards

private struct Card<Content: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: systemImage)
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
    }
}

private struct HourlyCard: View {
    let forecast: Forecast
    let unit: TemperatureUnit

    var body: some View {
        var hourStyle = Date.FormatStyle(date: .omitted, time: .shortened).hour()
        hourStyle.timeZone = forecast.timeZone

        return Card(title: "Hourly Forecast", systemImage: "clock") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 22) {
                    ForEach(Array(forecast.hourly.enumerated()), id: \.element.id) { index, hour in
                        VStack(spacing: 8) {
                            Text(index == 0 ? "Now" : hour.date.formatted(hourStyle))
                                .font(.subheadline.weight(.medium))
                            Image(systemName: hour.code.symbol(isDay: hour.isDay))
                                .symbolRenderingMode(.multicolor)
                                .font(.title3)
                                .frame(height: 26)
                            PrecipitationChance(value: hour.precipitationChance)
                            Text(unit.temperature(hour.temperature))
                                .font(.headline)
                                .monospacedDigit()
                        }
                    }
                }
            }
        }
    }
}

private struct DailyCard: View {
    let forecast: Forecast
    let unit: TemperatureUnit

    var body: some View {
        var dayStyle = Date.FormatStyle().weekday(.abbreviated)
        dayStyle.timeZone = forecast.timeZone
        let weekLow = forecast.daily.map(\.low).min() ?? 0
        let weekHigh = forecast.daily.map(\.high).max() ?? 0

        return Card(title: "7-Day Forecast", systemImage: "calendar") {
            VStack(spacing: 0) {
                ForEach(Array(forecast.daily.enumerated()), id: \.element.id) { index, day in
                    if index > 0 { Divider() }
                    HStack(spacing: 10) {
                        Text(index == 0 ? "Today" : day.date.formatted(dayStyle))
                            .font(.body.weight(.medium))
                            .frame(width: 54, alignment: .leading)
                        VStack(spacing: 0) {
                            Image(systemName: day.code.symbol(isDay: true))
                                .symbolRenderingMode(.multicolor)
                            PrecipitationChance(value: day.precipitationChance)
                        }
                        .frame(width: 36)
                        Text(unit.temperature(day.low))
                            .foregroundStyle(.secondary)
                            .frame(width: 38, alignment: .trailing)
                        TemperatureRangeBar(
                            low: day.low,
                            high: day.high,
                            weekLow: weekLow,
                            weekHigh: weekHigh,
                            current: index == 0 ? forecast.current.temperature : nil
                        )
                        Text(unit.temperature(day.high))
                            .frame(width: 38, alignment: .trailing)
                    }
                    .monospacedDigit()
                    .padding(.vertical, 10)
                }
            }
        }
    }
}

private struct DetailsGrid: View {
    let forecast: Forecast
    let unit: TemperatureUnit

    var body: some View {
        let current = forecast.current
        let today = forecast.today
        var timeStyle = Date.FormatStyle(date: .omitted, time: .shortened)
        timeStyle.timeZone = forecast.timeZone

        return LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())], spacing: 16) {
            DetailTile(title: "Feels Like", systemImage: "thermometer.medium", value: unit.temperature(current.feelsLike),
                       note: current.feelsLike < current.temperature - 1 ? "Wind is making it feel colder."
                           : current.feelsLike > current.temperature + 1 ? "Humidity is making it feel warmer."
                           : "Similar to the actual temperature.")
            DetailTile(title: "Humidity", systemImage: "humidity", value: "\(Int(current.humidity))%",
                       note: nil)
            DetailTile(title: "Wind", systemImage: "wind", value: unit.windSpeed(current.windSpeed),
                       note: "From the \(Self.compass(current.windDirection))")
            DetailTile(title: "Precipitation", systemImage: "drop.fill", value: unit.precipitation(current.precipitation),
                       note: today?.precipitationChance.map { "\($0)% chance today" })
            DetailTile(title: "UV Index", systemImage: "sun.max", value: today?.uvIndex.map { String(Int($0.rounded())) } ?? "–",
                       note: today?.uvIndex.map(Self.uvLevel))
            DetailTile(title: "Pressure", systemImage: "gauge.with.dots.needle.33percent", value: "\(Int(current.pressure.rounded())) hPa",
                       note: nil)
            DetailTile(title: "Sunrise", systemImage: "sunrise.fill", value: today?.sunrise?.formatted(timeStyle) ?? "–",
                       note: nil)
            DetailTile(title: "Sunset", systemImage: "sunset.fill", value: today?.sunset?.formatted(timeStyle) ?? "–",
                       note: nil)
        }
    }

    static func compass(_ degrees: Double) -> String {
        let points = ["north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest"]
        return points[Int((degrees / 45).rounded()) % points.count]
    }

    static func uvLevel(_ index: Double) -> String {
        switch index {
        case ..<3: "Low"
        case ..<6: "Moderate"
        case ..<8: "High"
        case ..<11: "Very High"
        default: "Extreme"
        }
    }
}

private struct DetailTile: View {
    let title: String
    let systemImage: String
    let value: String
    let note: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: systemImage)
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title.weight(.medium))
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            Spacer(minLength: 0)
            if let note {
                Text(note)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .topLeading)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
    }
}

// MARK: - Small pieces

private struct PrecipitationChance: View {
    let value: Int?

    var body: some View {
        // Always laid out so rows and columns stay aligned; only visible when worth mentioning.
        Text("\(value ?? 0)%")
            .font(.caption2.weight(.semibold))
            .foregroundStyle(.cyan)
            .opacity((value ?? 0) >= 20 ? 1 : 0)
    }
}

private struct TemperatureRangeBar: View {
    let low: Double
    let high: Double
    let weekLow: Double
    let weekHigh: Double
    let current: Double?

    var body: some View {
        GeometryReader { geometry in
            let span = max(weekHigh - weekLow, 1)
            let x = { (value: Double) in (value - weekLow) / span * geometry.size.width }
            let width = max(x(high) - x(low), 5)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.white.opacity(0.15))
                Capsule()
                    .fill(LinearGradient(colors: [Self.color(for: low), Self.color(for: high)], startPoint: .leading, endPoint: .trailing))
                    .frame(width: width)
                    .offset(x: x(low))
                if let current {
                    Circle()
                        .fill(.white)
                        .overlay(Circle().stroke(.black.opacity(0.3), lineWidth: 1.5))
                        .frame(width: 7, height: 7)
                        .offset(x: min(max(x(current) - 3.5, x(low)), x(low) + width - 7))
                }
            }
        }
        .frame(height: 6)
    }

    static func color(for celsius: Double) -> Color {
        switch celsius {
        case ..<0: Color(red: 0.45, green: 0.65, blue: 1.0)
        case ..<10: .cyan
        case ..<20: .green
        case ..<28: .yellow
        case ..<34: .orange
        default: .red
        }
    }
}
