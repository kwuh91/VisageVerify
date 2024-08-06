//
//  Testing3.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 06.08.2024.
//

import SwiftUI

struct Testing3: View {
    var body: some View {
        ZStack {
            VStack(spacing: -500) {
                ClosedEye(mainEyeColor: .black)
                    .aspectRatio(0.5, contentMode: .fit)
                    .frame(height: 500)
                    .rotationEffect(Angle(degrees: 180))
                
                ClosedEye(mainEyeColor: .black)
                    .aspectRatio(0.5, contentMode: .fit)
                    .frame(height: 500)
            }
            
            VStack(spacing: -200) {
                ClosedEye(mainEyeColor: .black)
                    .aspectRatio(0.5, contentMode: .fit)
                    .frame(height: 200)
                    .rotationEffect(Angle(degrees: 180))
                
                ClosedEye(mainEyeColor: .black)
                    .aspectRatio(0.5, contentMode: .fit)
                    .frame(height: 200)
            }.rotationEffect(Angle(degrees: 90))
            
        }
    }
}

#Preview {
    Testing3()
}
