//
//  StorageTest.swift
//  24-11-26-sk2
//
//  Created by Filip Vabroušek on 24.11.2026.
//

import SwiftUI

struct StorageView: View {
    @AppStorage("count") private var count = 0
    @State private var taps = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("@AppStorage \(count)")
            Text("@State \(taps)")
            
            Button("+1"){
                count += 1
                taps += 1
            }
        }.font(.largeTitle)
    }
}

// AppStorage DONE


// Layout DONE

struct LayoutView: View {
    var body: some View {
        VStack {
            Text("Top")
            Text("Bottom")
        }
        
        HStack {
            Text("Left")
            Text("Right")
        }
        
        ZStack {
            Text("Above")
            Text("Below")
        }
    }
}

#Preview {
    LayoutView()
}



