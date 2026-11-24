//
//  Effects.swift
//  24-11-26-sk2
//
//  Created by Filip Vabroušek on 24.11.2026.
//

import SwiftUI

struct EffectsView: View {
    var gradient: LinearGradient {
        LinearGradient(
            colors: [.blue, .orange],
            startPoint: .leading,
            endPoint: .trailing)
    }
    
    // RadialGradient
    var body: some View {
        Circle()
            .fill(gradient)
            .shadow(color: Color.orange, radius: 30)
    }
}


struct SquareView: View {
    @State var isRotated = false
    
    var gradient: LinearGradient {
        LinearGradient(
            colors: [.blue, .orange],
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
            .fill(gradient)
            .frame(width: 200, height: 200)
            .rotationEffect(.degrees(isRotated ? 45 : -45))
            .scaleEffect(isRotated ? 1.0 : 0.6)
            
    }
}

#Preview {
    SquareView()
        .padding()
}
