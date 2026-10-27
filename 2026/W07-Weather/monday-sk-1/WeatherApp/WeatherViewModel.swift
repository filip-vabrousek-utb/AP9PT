import Foundation
import Observation

@MainActor
@Observable
final class WeatherViewModel {
    enum SearchState {
        case idle
        case searching
        case results([Location])
        case failed(String)
    }

    enum WeatherState {
        case empty
        case loading(Location)
        case loaded(Location, CurrentWeather, Units)
        case failed(Location, String)
    }

    var query = ""
    var units: Units = .metric
    private(set) var searchState: SearchState = .idle
    private(set) var weatherState: WeatherState = .empty

    private let service: WeatherService

    init(service: WeatherService = Config.useMockData ? MockWeatherService() : OpenMeteoService()) {
        self.service = service
    }

    var trimmedQuery: String { query.trimmingCharacters(in: .whitespacesAndNewlines) }

    /// Debounced live search, driven by `.task(id: query)` in the view.
    func search() async {
        let text = trimmedQuery
        guard text.count >= 2 else {
            searchState = .idle
            return
        }
        do {
            try await Task.sleep(for: .milliseconds(350))
            searchState = .searching
            let results = try await service.searchLocations(text)
            searchState = results.isEmpty ? .failed(WeatherError.notFound.localizedDescription) : .results(results)
        } catch is CancellationError {
            // A newer keystroke replaced this search.
        } catch {
            searchState = .failed(error.localizedDescription)
        }
    }

    /// Return key: pick the top match without waiting for the debounce.
    func submit() async {
        let text = trimmedQuery
        guard !text.isEmpty else { return }
        do {
            if let first = try await service.searchLocations(text).first {
                await select(first)
            } else {
                searchState = .failed(WeatherError.notFound.localizedDescription)
            }
        } catch {
            searchState = .failed(error.localizedDescription)
        }
    }

    func select(_ location: Location) async {
        query = ""
        searchState = .idle
        await loadWeather(for: location)
    }

    func refresh() async {
        switch weatherState {
        case .loaded(let location, _, _), .failed(let location, _), .loading(let location):
            await loadWeather(for: location)
        case .empty:
            break
        }
    }

    private func loadWeather(for location: Location) async {
        // Keep showing current data while refreshing the same place.
        if case .loaded(let current, _, _) = weatherState, current == location {} else {
            weatherState = .loading(location)
        }
        do {
            let units = units
            let weather = try await service.currentWeather(for: location, units: units)
            weatherState = .loaded(location, weather, units)
        } catch is CancellationError {
        } catch {
            weatherState = .failed(location, error.localizedDescription)
        }
    }
}
