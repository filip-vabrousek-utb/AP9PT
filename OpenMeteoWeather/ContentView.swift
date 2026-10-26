import SwiftUI

struct ContentView: View {
    @Environment(WeatherStore.self) private var store
    @State private var query = ""
    @State private var results: [Place] = []
    @State private var searchError: String?
    @State private var isSearching = false

    private var trimmedQuery: String { query.trimmingCharacters(in: .whitespaces) }

    var body: some View {
        @Bindable var store = store

        NavigationStack {
            List {
                if trimmedQuery.isEmpty {
                    placeSections
                } else {
                    searchResults
                }
            }
            .navigationTitle("Weather")
            .navigationDestination(for: Place.self) { ForecastView(place: $0) }
            .searchable(text: $query, prompt: "Search for a city")
            .autocorrectionDisabled()
            .task(id: trimmedQuery) { await search(trimmedQuery) }
            .refreshable { await store.refreshAll(force: true) }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Units", selection: $store.unit) {
                            ForEach(TemperatureUnit.allCases) { Text($0.label).tag($0) }
                        }
                    } label: {
                        Label("Units", systemImage: "thermometer.medium")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
        .task { await store.start() }
    }

    @ViewBuilder
    private var placeSections: some View {
        switch store.locationStatus {
        case .locating where store.currentLocation == nil:
            Section("Current Location") {
                Label("Locating…", systemImage: "location")
                    .foregroundStyle(.secondary)
            }
        case .located:
            if let here = store.currentLocation {
                Section("Current Location") {
                    NavigationLink(value: here) { PlaceRow(place: here) }
                }
            }
        default:
            EmptyView()
        }

        Section("Saved") {
            ForEach(store.places) { place in
                NavigationLink(value: place) { PlaceRow(place: place) }
            }
            .onDelete { store.remove(atOffsets: $0) }
            .onMove { store.move(fromOffsets: $0, toOffset: $1) }
        }
    }

    @ViewBuilder
    private var searchResults: some View {
        if let searchError {
            ContentUnavailableView("Search Failed", systemImage: "wifi.exclamationmark", description: Text(searchError))
        } else if results.isEmpty && !isSearching && trimmedQuery.count >= 2 {
            ContentUnavailableView.search(text: trimmedQuery)
        } else {
            ForEach(results) { place in
                NavigationLink(value: place) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(place.name)
                            if let region = place.region {
                                Text(region)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                        if store.isSaved(place) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.tint)
                        }
                    }
                }
            }
        }
    }

    private func search(_ text: String) async {
        guard text.count >= 2 else {
            results = []
            searchError = nil
            return
        }
        isSearching = true
        defer { isSearching = false }

        // Debounce: a new keystroke cancels this task before the request goes out.
        try? await Task.sleep(for: .milliseconds(300))
        guard !Task.isCancelled else { return }

        do {
            results = try await store.search(text)
            searchError = nil
        } catch {
            guard !Task.isCancelled else { return }
            results = []
            searchError = error.localizedDescription
        }
    }
}

struct PlaceRow: View {
    let place: Place
    @Environment(WeatherStore.self) private var store

    var body: some View {
        let forecast = store.forecasts[place.id]

        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(place.name)
                        .font(.headline)
                    if place.isCurrentLocation {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundStyle(.tint)
                    }
                }
                Text(forecast?.current.code.description ?? place.region ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if let forecast {
                // Multicolor clouds are white, so give the symbol its own sky to sit on.
                Image(systemName: forecast.current.code.symbol(isDay: forecast.current.isDay))
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                    .frame(width: 42, height: 42)
                    .background(
                        LinearGradient(colors: ForecastView.background(for: forecast.current), startPoint: .top, endPoint: .bottom),
                        in: .rect(cornerRadius: 10)
                    )
                VStack(alignment: .trailing, spacing: 0) {
                    Text(store.unit.temperature(forecast.current.temperature))
                        .font(.title2.weight(.medium))
                    if let today = forecast.today {
                        Text("H:\(store.unit.temperature(today.high)) L:\(store.unit.temperature(today.low))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .monospacedDigit()
            } else if store.errors[place.id] != nil {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.orange)
            } else {
                ProgressView()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
        .environment(WeatherStore())
}
