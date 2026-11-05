# Code review

- **App:** Weather app (`WeatherFeel`)
- **From:** 29/10/26
- **Date:** 05/11/26

## What did the agent decide about? State, Observable (local/global state)

- **Global state:** none, no `@Observable`
- **Local state:** `@State private var query = "Prague"`
  - Where: [ContentView.swift, line 5](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/thursday-sk-1/WeatherFeel/ContentView.swift#L5)

## Where is the error/empty state shown in the UI?

- **Empty/loading state:**

  ```swift
  } else {
      ProgressView().tint(.white)
  }

  if weather == nil { Spacer() }
  ```

  - Where: [ContentView.swift, lines 25–29](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/thursday-sk-1/WeatherFeel/ContentView.swift#L25-L29)
- **Error state:** `Text(errorMessage).foregroundStyle(.white)`
  - Where: [ContentView.swift, line 24](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/thursday-sk-1/WeatherFeel/ContentView.swift#L24)
- **Assigned to local state:**

  ```swift
  do {
      let found = try await service.findPlace(trimmed)
      let current = try await service.currentWeather(for: found)
      withAnimation {
          place = found
          weather = current
          errorMessage = nil
      }
  } catch {
      withAnimation {
          place = nil
          weather = nil
          errorMessage = error.localizedDescription
      }
  }
  ```

  - Where: [ContentView.swift, lines 89–103](https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/thursday-sk-1/WeatherFeel/ContentView.swift#L89-L103)
