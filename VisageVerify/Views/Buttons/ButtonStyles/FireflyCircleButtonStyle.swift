//
//  FireflyCircleButtonStyle.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 03.08.2024.
//

import SwiftUI

struct FireflyCircleButtonStyle: ButtonStyle {
    let padding:  CGFloat
    let quantity: Int
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .background(FloatingFireflies(quantity: quantity))
            .foregroundStyle(Colors.boneColor)
            .clipShape(Circle())
            .shadow(color: Colors.blackish, radius: 10)
            .opacity(configuration.isPressed ? 0.1 : 1)
            //.scaleEffect(configuration.isPressed ? 1.1 : 1)
    }
}

#Preview {
    Button {
        print("Button1 tapped!")
    } label: {
        PrettyText(text:     "Sign in",
                   fontName: "ArsenalSC-Regular",
                   color:    Colors.boneColor,
                   fontSize: 46)
            .shadow(color: Colors.blackish, radius: 10)
    }
    .buttonStyle(FireflyCircleButtonStyle(padding: 90,
                                          quantity: 70))
}
