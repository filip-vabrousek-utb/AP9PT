import CoreLocation
import Foundation
import Observation

@MainActor
@Observable
final class WeatherStore {
    enum LocationStatus: Equatable { case idle, locating, located, unavailable }

    private(set) var places: [Place] {
        didSet { save() }
    }

    var unit: TemperatureUnit {
        didSet { defaults.set(unit.rawValue, forKey: Keys.unit) }
    }

    private(set) var forecasts: [Place.ID: Forecast] = [:]
    private(set) var errors: [Place.ID: String] = [:]
    private(set) var currentLocation: Place?
    private(set) var locationStatus = LocationStatus.idle

    @ObservationIgnored private let client = OpenMeteoClient()
    @ObservationIgnored private let defaults: UserDefaults

    private enum Keys {
        static let places = "places"
        static let unit = "unit"
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if let data = defaults.data(forKey: Keys.places),
           let saved = try? JSONDecoder().decode([Place].self, from: data) {
            places = saved
        } else {
            places = Place.defaults
        }
        unit = defaults.string(forKey: Keys.unit).flatMap(TemperatureUnit.init)
            ?? (Locale.current.measurementSystem == .us ? .fahrenheit : .celsius)
    }

    /// Initial load: saved places and the current location in parallel.
    func start() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.refreshAll() }
            group.addTask { await self.locate() }
        }
    }

    // MARK: Forecasts

    /// Fetches unless a forecast younger than ten minutes is already cached.
    func load(_ place: Place, force: Bool = false) async {
        if !force, let cached = forecasts[place.id], cached.fetchedAt.timeIntervalSinceNow > -600 {
            return
        }
        do {
            forecasts[place.id] = try await client.forecast(latitude: place.latitude, longitude: place.longitude)
            errors[place.id] = nil
        } catch {
            errors[place.id] = error.localizedDescription
        }
    }

    func refreshAll(force: Bool = false) async {
        let all = places + [currentLocation].compactMap { $0 }
        await withTaskGroup(of: Void.self) { group in
            for place in all {
                group.addTask { await self.load(place, force: force) }
            }
        }
    }

    func search(_ query: String) async throws -> [Place] {
        try await client.search(query)
    }

    // MARK: Saved places

    func isSaved(_ place: Place) -> Bool {
        place.isCurrentLocation || places.contains { $0.id == place.id }
    }

    func add(_ place: Place) {
        guard !isSaved(place) else { return }
        places.append(place)
    }

    func remove(atOffsets offsets: IndexSet) {
        for index in offsets {
            forecasts[places[index].id] = nil
        }
        places.remove(atOffsets: offsets)
    }

    func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        places.move(fromOffsets: source, toOffset: destination)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(places) {
            defaults.set(data, forKey: Keys.places)
        }
    }

    // MARK: Current location

    func locate() async {
        locationStatus = .locating
        guard let coordinate = await Self.currentCoordinate() else {
            locationStatus = .unavailable
            return
        }
        let place = Place(
            id: Place.currentLocationID,
            name: "My Location",
            region: nil,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        currentLocation = place
        locationStatus = .located
        await load(place, force: true)
    }

    private struct Coordinate: Sendable {
        let latitude: Double
        let longitude: Double
    }

    /// One-shot location fix; nil when permission is denied or nothing arrives within the timeout.
    private static func currentCoordinate(timeout: Duration = .seconds(15)) async -> Coordinate? {
        let session = CLServiceSession(authorization: .whenInUse)
        defer { session.invalidate() }

        return await withTaskGroup(of: Coordinate?.self) { group in
            group.addTask {
                do {
                    for try await update in CLLocationUpdate.liveUpdates() {
                        if let location = update.location {
                            return Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        }
                        if update.authorizationDenied || update.authorizationDeniedGlobally || update.authorizationRestricted {
                            return nil
                        }
                    }
                } catch {}
                return nil
            }
            group.addTask {
                try? await Task.sleep(for: timeout)
                return nil
            }
            let first = await group.next() ?? nil
            group.cancelAll()
            return first
        }
    }
}
