//
//  SimulatingFireflyCircleButtonStyleButton.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 03.08.2024.
//

import SwiftUI

func paddingToFontsizeRatio(padding: CGFloat) -> CGFloat {
    exp(4.5825-0.0084*padding)
}

struct SignUpButton: View {
    let padding:  CGFloat
    let fontSize: CGFloat
    let quantity: Int
    
    
    var body: some View {
        ZStack {
            // Circle
            FloatingFireflies(quantity: quantity)
                .mask(
                    Circle()
                )
                .contentShape(Circle())
                .padding(padding)
                .shadow(color: Colors.blackish, radius: 10)
            
            // text
            PrettyText(text:     "Sign up",
                       fontName: "ArsenalSC-Regular",
                       color:    Colors.boneColor,
                       fontSize: fontSize)
                .shadow(color: Colors.blackish, radius: 10)
            
        }
    }
}

#Preview {
    // initial state
    SignUpButton(padding:  40,
                 fontSize: 46,
                 quantity: 150)
    
    // end state
//    SignUpButton(padding:  40,
//                 fontSize: 46,
//                 quantity: 150)
//    .scaleEffect(3)
//    .opacity(0)
}
