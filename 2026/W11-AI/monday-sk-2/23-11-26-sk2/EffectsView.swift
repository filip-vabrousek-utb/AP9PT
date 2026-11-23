//
//  EffectsView.swift
//  23-11-26-sk2
//
//  Created by Filip Vabroušek on 23.11.2026.
//

import SwiftUI

struct GradientView: View {
    var linear: LinearGradient {
        LinearGradient(colors: [Color.orange, Color.green],
                       startPoint: .leading,
                       endPoint: .trailing)
    }
    
    var body: some View {
        Circle()
            .fill(linear)
            .shadow(color: .orange, radius: 27)
    }
}


struct SquareView: View {
    @State var isRotated = false
    
    var linear: LinearGradient {
        LinearGradient(colors: [Color.orange, Color.green],
                       startPoint: .leading,
                       endPoint: .trailing)
    }
    
    var body: some View {
        Button("Rotate"){
            withAnimation(.spring(duration: 0.4, bounce: 0.6)) {
                isRotated.toggle()
            }
            
        }
        
        Rectangle()
            .fill(linear)
            .frame(width: 200, height: 200)
            .rotationEffect(.degrees(isRotated ? 45 : -45))
            .scaleEffect(isRotated ? 1.0 : 0.6)
    }
}



#Preview {
    SquareView()
        .padding()
}



