#  # Code review
App: WeatherApp
From: 27/10/26
Date: 03/11/26
Group: 03-11-26
Name: Filip Vabrousek
# What did the agent decide about?
## State, observable, local/global state
Global state: None
Where: None
Local state: @State private var query = "Prague"
Where:  https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/WeatherService.swift

### Other stuff agent decided about
\* what weather info will be loaded
Where: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/WeatherService.swift
# Where is the error/empty state shown in the UI?
Error shown:``else if let errorMessage {
                        Text(errorMessage)
Where: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/WeatherService.swift (23)

Assignment to local state: ``errorMessage = error.localizedDescription``
https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/ContentView.swift (73)



