//
//  EffectsView.swift
//  23-11-26-sk1
//
//  Created by Filip Vabroušek on 23.11.2026.
//

import SwiftUI

struct GradientView: View {
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.orange, .green],
                       startPoint: .leading,
                       endPoint: .trailing)
        // RadialGradient
    }
    
    var radial: RadialGradient {
        RadialGradient(colors: [.orange, .green],
                       center: .center,
                       startRadius: 0,
                       endRadius: 50)
    }
    
    
    var body: some View {
        Circle()
           // .foregroundStyle(.green)
            .fill(radial)
            .shadow(color: .orange, radius: 27)
    }
}


struct SqView: View {
    @State var isRotated = false
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.orange, .green],
                       startPoint: .leading,
                       endPoint: .trailing)
        // RadialGradient
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
   SqView()
        .padding()
}
