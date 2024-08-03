//
//  FireflyTextMaskButtonStyle.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 03.08.2024.
//

import SwiftUI

struct FireflyTextMaskButtonStyle: ButtonStyle {
    let buttonText: String
    let fontSize:   CGFloat
    let padding:    CGFloat
    let width:      CGFloat
    let height:     CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .mask(
                PrettyText(text:     buttonText,
                           fontName: "ArsenalSC-Regular",
                           color:    Colors.boneColor,
                           fontSize: fontSize)
            )
            .shadow(color: Colors.blackish, radius: 8)
            .opacity(configuration.isPressed ? 0.1 : 1)
            // .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .frame(width:  width,
                   height: height)
    }
}

#Preview {
    Button {
        print("Button2 tapped!")
    } label: {
        FloatingFireflies(quantity: 150)
    }
    .buttonStyle(FireflyTextMaskButtonStyle(buttonText: "Sign up",
                                            fontSize:   56,
                                            padding:    10,
                                            width:      300,
                                            height:     100))
}
