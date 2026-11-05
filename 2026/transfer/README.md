# Code review Weather Feel
App: Weather feel
From: 29/10/26
Date: 05/11/26

# # What did the agent decide (local state, global state)
Local state
```swift
@State private var query = "Prague"
```
Where: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/thursday-sk-1/WeatherFeel/ContentView.swift
RIGHT SHIFT + APOSTROFA
Global state: None, no @Observable
# # Where is error/empty state shown in the UI?
Error handling
```swift
else {
                    ProgressView().tint(.white)
                }

                if weather == nil { Spacer() }
```
Where: https://github.com/filip-vabrousek-utb/AP9PT/blob/main/2026/W07-Weather/thursday-sk-1/WeatherFeel/ContentView.swift
