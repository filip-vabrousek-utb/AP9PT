#  # Weather code review
App: Weather
From: 26/10/26
Date: 02/11/26

## What did the agent decide about?
State, Observable, local, global state
Local state:`` @State private var query = "
Where: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/monday-sk-2/OpenMeteoWeather/ContentView.swift

Global state:
 @Observable
final class WeatherStore {
Where: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/monday-sk-2/OpenMeteoWeather/WeatherStore.swift


# Where is the error/empty state shown in UI?
ContenUnavailableView
Where:   ContentUnavailableView("Search Failed", systemImage: "wifi.exclamationmark", description: Text(searchError))


