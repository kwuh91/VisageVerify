//
//  Testing3.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 06.08.2024.
//

import SwiftUI

struct Testing3: View {
    var body: some View {
        VStack(spacing: -300) {
            OpenEye(mainEyeColor: .black,
                    sectorColor:  .white,
                    pupilColor:   .black)
                .aspectRatio(0.5, contentMode: .fit)
                .frame(height: 500)
            
            BlinkingEyeAnimationState2(mainEyeColor: .black,
                                       sectorColor:  .white,
                                       pupilColor:   .black)
            .aspectRatio(0.5, contentMode: .fit)
            .frame(height: 500)
            
            BlinkingEyeAnimationState3(mainEyeColor: .black,
                                       sectorColor:  .white,
                                       pupilColor:   .black)
            .aspectRatio(0.5, contentMode: .fit)
            .frame(height: 500)
            
            BlinkingEyeAnimationState4(mainEyeColor: .black,
                                       sectorColor:  .white,
                                       pupilColor:   .black)
            .aspectRatio(0.5, contentMode: .fit)
            .frame(height: 500)
        }
    }
}

#Preview {
    Testing3()
}
