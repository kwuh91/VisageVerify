//
//  ButtonStyle.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 17.07.2024.
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
    VStack {
        Spacer()
        
        // sign in
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
        
        Spacer()
        
        // sign up
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
        
        
        Spacer()
    }
}
