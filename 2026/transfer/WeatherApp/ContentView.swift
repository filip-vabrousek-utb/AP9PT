import SwiftUI

struct ContentView: View {
    @State private var model = WeatherViewModel()
    @FocusState private var searchFocused: Bool

    var body: some View {
        ZStack(alignment: .top) {
            background.ignoresSafeArea()

            VStack(spacing: 12) {
                searchBar
                    .padding(.horizontal)

                if searchFocused || !model.trimmedQuery.isEmpty {
                    searchResults
                } else {
                    weatherContent
                }
            }
        }
        .task(id: model.query) { await model.search() }
        .onChange(of: model.units) { Task { await model.refresh() } }
        .animation(.smooth, value: searchFocused)
    }

    // MARK: Search

    private var searchBar: some View {
        HStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Search city, e.g. London", text: $model.query)
                    .focused($searchFocused)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .submitLabel(.search)
                    .onSubmit {
                        Task { await model.submit() }
                    }
                if !model.query.isEmpty {
                    Button {
                        model.query = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .accessibilityLabel("Clear search")
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(.regularMaterial, in: .capsule)

            Menu {
                Picker("Units", selection: $model.units) {
                    Text("Celsius (°C)").tag(Units.metric)
                    Text("Fahrenheit (°F)").tag(Units.imperial)
                }
            } label: {
                Text(model.units.temperatureSymbol)
                    .font(.headline)
                    .frame(width: 46, height: 46)
                    .background(.regularMaterial, in: .circle)
            }
            .tint(.primary)
            .accessibilityLabel("Temperature units")
        }
    }

    @ViewBuilder
    private var searchResults: some View {
        Group {
            switch model.searchState {
            case .idle:
                hint("Type at least 2 letters to search any city in the world.")
            case .searching:
                ProgressView().padding(.top, 24)
            case .failed(let message):
                hint(message)
            case .results(let locations):
                List(locations) { location in
                    Button {
                        searchFocused = false
                        Task { await model.select(location) }
                    } label: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(location.name).font(.headline)
                            Text(location.subtitle).font(.subheadline).foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Rectangle().fill(.regularMaterial))
                }
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.immediately)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private func hint(_ text: String) -> some View {
        Text(text)
            .font(.callout)
            .foregroundStyle(.white.opacity(0.9))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
            .padding(.top, 24)
    }

    // MARK: Weather

    @ViewBuilder
    private var weatherContent: some View {
        switch model.weatherState {
        case .empty:
            ContentUnavailableView {
                Label("Search for a place", systemImage: "cloud.sun.fill")
                    .symbolRenderingMode(.multicolor)
            } description: {
                Text("Find any city to see how it really feels outside.")
            } actions: {
                Button("Search") { searchFocused = true }
                    .buttonStyle(.borderedProminent)
                    .tint(.white.opacity(0.25))
            }
            .foregroundStyle(.white)
        case .loading(let location):
            VStack(spacing: 12) {
                ProgressView().tint(.white).controlSize(.large)
                Text("Loading \(location.name)…").foregroundStyle(.white)
            }
            .frame(maxHeight: .infinity)
        case .failed(let location, let message):
            ContentUnavailableView {
                Label("Couldn't load \(location.name)", systemImage: "exclamationmark.triangle.fill")
            } description: {
                Text(message)
            } actions: {
                Button("Try Again") { Task { await model.refresh() } }
                    .buttonStyle(.borderedProminent)
                    .tint(.white.opacity(0.25))
            }
            .foregroundStyle(.white)
        case .loaded(let location, let weather, let units):
            ScrollView {
                WeatherDetailView(location: location, weather: weather, units: units)
                    .padding(.horizontal)
                    .padding(.bottom, 24)
            }
            .refreshable { await model.refresh() }
        }
    }

    /// Screen background follows the feels-like temperature.
    private var background: some View {
        let color: Color
        if case .loaded(_, let weather, let units) = model.weatherState {
            let feels = units == .metric ? weather.feelsLike : (weather.feelsLike - 32) * 5 / 9
            color = FeelsLikePalette.color(forCelsius: feels)
        } else {
            color = Color(red: 0.25, green: 0.42, blue: 0.80)
        }
        return LinearGradient(colors: [color.mix(with: .black, by: 0.35), color.mix(with: .black, by: 0.65)],
                              startPoint: .top, endPoint: .bottom)
            .animation(.smooth(duration: 0.6), value: color)
    }
}

#Preview {
    ContentView()
}
