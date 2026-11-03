# Code review

- **App:** Weather app (`RealFeelWeather`)
- **From:** 27/10/26
- **Date:** 03/11/26

## What did the agent decide about? State, Observable (local/global state)

- **Global state:** none
- **Local state:** `@State private var query = "Prague"`
  - Where: [ContentView.swift, line 4](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/ContentView.swift#L4)

### Other things the agent decided about

- What weather information is loaded
  - Where: [WeatherService.swift](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/WeatherService.swift)

## Where is the error/empty state shown in the UI?

- **Error shown:**

  ```swift
  } else if let errorMessage {
      Text(errorMessage)
  ```

  - Where: [ContentView.swift, line 23](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/ContentView.swift#L23)
- **Assigned to local state:** `errorMessage = error.localizedDescription`
  - Where: [ContentView.swift, line 73](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/tuesday-sk-1/RealFeelWeather/ContentView.swift#L73)
