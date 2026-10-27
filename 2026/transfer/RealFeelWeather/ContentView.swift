import SwiftUI

struct ContentView: View {
    @State private var query = "Prague"
    @State private var place: Place?
    @State private var forecast: Forecast?
    @State private var errorMessage: String?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    searchBar

                    if let forecast, let place {
                        RealFeelCard(place: place, current: forecast.current)
                        DetailsRow(current: forecast.current)
                        DailyList(daily: forecast.daily)
                    } else if let errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.white)
                            .padding(.top, 60)
                    } else {
                        ProgressView().tint(.white).padding(.top, 120)
                    }
                }
                .padding()
            }
            .refreshable { await load() }
        }
        .task { await load() }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("City", text: $query)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .onSubmit { Task { await load() } }
            if isLoading { ProgressView().tint(.white) }
        }
        .foregroundStyle(.white)
        .padding(12)
        .background(.white.opacity(0.18), in: .rect(cornerRadius: 14))
    }

    // Background follows the real-feel temperature, not the thermometer.
    private var background: LinearGradient {
        let colors = forecast.map { feelsColors($0.current.feelsLike) } ?? [.indigo, .blue]
        return LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
    }

    private func load() async {
        let name = query.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let found = try await WeatherService.findPlace(name)
            let result = try await WeatherService.forecast(for: found)
            withAnimation {
                place = found
                forecast = result
                errorMessage = nil
            }
        } catch {
            withAnimation {
                forecast = nil
                errorMessage = error.localizedDescription
            }
        }
    }
}

// MARK: - Real feel hero card

struct RealFeelCard: View {
    let place: Place
    let current: Forecast.Current

    private var difference: Int {
        Int(current.feelsLike.rounded()) - Int(current.temperature.rounded())
    }

    var body: some View {
        let info = weatherInfo(current.weatherCode)

        VStack(spacing: 6) {
            Text(place.name)
                .font(.title2.weight(.semibold))
            Label(info.label, systemImage: info.symbol)
                .symbolRenderingMode(.multicolor)
                .font(.subheadline)

            Text("REAL FEEL")
                .font(.caption.weight(.heavy))
                .tracking(3)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(.white, in: .capsule)
                .foregroundStyle(feelsColors(current.feelsLike).last!)
                .padding(.top, 16)

            Text(degrees(current.feelsLike))
                .font(.system(size: 120, weight: .bold, design: .rounded))
                .contentTransition(.numericText())
                .shadow(color: .black.opacity(0.2), radius: 8, y: 4)

            Text("Actual \(degrees(current.temperature))")
                .font(.title3)
                .opacity(0.8)

            Text(differenceText)
                .font(.footnote.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.black.opacity(0.15), in: .capsule)
                .padding(.top, 8)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(.white.opacity(0.15), in: .rect(cornerRadius: 28))
        .overlay(RoundedRectangle(cornerRadius: 28).stroke(.white.opacity(0.35), lineWidth: 1.5))
    }

    private var differenceText: String {
        switch difference {
        case 0: "Feels just like it reads"
        case ..<0: "Feels \(-difference)° colder" + (current.windSpeed > 10 ? " — wind chill" : "")
        default: "Feels \(difference)° warmer" + (current.humidity > 60 ? " — humidity" : "")
        }
    }
}

// MARK: - Details

struct DetailsRow: View {
    let current: Forecast.Current

    var body: some View {
        HStack {
            detail("wind", "\(Int(current.windSpeed.rounded())) km/h", "Wind")
            detail("humidity.fill", "\(Int(current.humidity))%", "Humidity")
        }
    }

    private func detail(_ symbol: String, _ value: String, _ title: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: symbol)
            Text(value).font(.headline)
            Text(title).font(.caption).opacity(0.7)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.white.opacity(0.15), in: .rect(cornerRadius: 18))
    }
}

// MARK: - 7-day forecast, real feel first

struct DailyList: View {
    let daily: Forecast.Daily

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("7-DAY FORECAST")
                Spacer()
                Text("Real feel").foregroundStyle(.white)
                Text("/ actual")
            }
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white.opacity(0.7))
            .padding(.bottom, 8)

            ForEach(daily.time.indices, id: \.self) { i in
                HStack {
                    Text(dayName(daily.time[i], index: i))
                        .frame(width: 56, alignment: .leading)
                    Image(systemName: weatherInfo(daily.weatherCode[i]).symbol)
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 30)
                    Spacer()
                    Text("\(degrees(daily.feelsMin[i])) – \(degrees(daily.feelsMax[i]))")
                        .font(.headline)
                    Text("\(degrees(daily.tempMin[i]))–\(degrees(daily.tempMax[i]))")
                        .font(.caption)
                        .opacity(0.6)
                        .frame(width: 64, alignment: .trailing)
                }
                .foregroundStyle(.white)
                .padding(.vertical, 10)

                if i < daily.time.count - 1 {
                    Divider().overlay(.white.opacity(0.3))
                }
            }
        }
        .padding()
        .background(.white.opacity(0.15), in: .rect(cornerRadius: 22))
    }

    private func dayName(_ isoDate: String, index: Int) -> String {
        if index == 0 { return "Today" }
        let parser = DateFormatter()
        parser.dateFormat = "yyyy-MM-dd"
        guard let date = parser.date(from: isoDate) else { return isoDate }
        return date.formatted(.dateTime.weekday(.abbreviated))
    }
}

// MARK: - Helpers

func degrees(_ value: Double) -> String {
    "\(Int(value.rounded()))°"
}

func feelsColors(_ feelsLike: Double) -> [Color] {
    switch feelsLike {
    case ..<0: [Color(red: 0.35, green: 0.55, blue: 0.95), Color(red: 0.15, green: 0.25, blue: 0.6)]
    case ..<10: [Color(red: 0.3, green: 0.7, blue: 0.9), Color(red: 0.15, green: 0.4, blue: 0.7)]
    case ..<20: [Color(red: 0.35, green: 0.75, blue: 0.7), Color(red: 0.2, green: 0.5, blue: 0.55)]
    case ..<28: [Color(red: 1.0, green: 0.7, blue: 0.3), Color(red: 0.9, green: 0.45, blue: 0.2)]
    default: [Color(red: 1.0, green: 0.5, blue: 0.3), Color(red: 0.8, green: 0.2, blue: 0.2)]
    }
}

#Preview {
    ContentView()
}
