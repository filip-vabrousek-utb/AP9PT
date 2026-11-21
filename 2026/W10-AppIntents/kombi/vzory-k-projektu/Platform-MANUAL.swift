import SwiftUI

// Jedna aplikace pro iPhone i Mac.
// Mac: cíl → General → Supported Destinations → + Mac (ne „Designed for iPad“) → spustit na „My Mac“.
// #if os(...) rozhoduje při PŘEKLADU (kód pro jiný systém se vůbec nepřeloží),
// if #available(...) rozhoduje až ZA BĚHU podle verze systému.

struct PlatformView: View {
    @State private var size = "M"

    var body: some View {
        VStack(spacing: 16) {
            #if os(macOS)
            Text("Běžím na Macu")          // přeloží se jen pro Mac
            #else
            Text("Běžím na iPhonu")        // přeloží se pro všechno ostatní
            #endif

            if #available(iOS 27, macOS 27, *) {
                Text("Nový systém")         // rozhoduje se až za běhu
            } else {
                Text("Starší systém")
            }

            Picker("Velikost", selection: $size) {
                Text("S").tag("S")
                Text("M").tag("M")
                Text("L").tag("L")
            }
            #if os(macOS)
            .pickerStyle(.radioGroup)       // existuje jen na Macu – bez #if se pro iOS nepřeloží
            #endif
        }
        .padding()
        #if os(macOS)
        .frame(minWidth: 400, minHeight: 300)
        #endif
    }
}

#Preview { PlatformView() }
