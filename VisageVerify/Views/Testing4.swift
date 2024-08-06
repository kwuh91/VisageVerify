//
//  Testing4.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 07.08.2024.
//

import SwiftUI

struct Testing4: View {
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            ClosedEye(mainEyeColor: .red)
                .aspectRatio(0.5, contentMode: .fit)
                .frame(height: 510)
            
//            ClosedEye(mainEyeColor: .green)
//                .aspectRatio(0.5, contentMode: .fit)
//                .frame(height: 500)
        }
        .rotation3DEffect(.degrees(rotationAngle), axis: (x: 1, y: 0, z: 0))
        .onTapGesture {
            withAnimation(.easeInOut(duration: 3.3)
                          .repeatForever(autoreverses: false)) {
                rotationAngle += 360
            }
        }
    }
}
    
#Preview {
    Testing4()
}
