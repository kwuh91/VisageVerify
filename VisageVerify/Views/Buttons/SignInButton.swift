//
//  SignInButton.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 04.08.2024.
//

import SwiftUI

func fontSizeToWidthRatio(fontSize: CGFloat) -> CGFloat {
    58*sqrt(fontSize + 47) - 410
}

func fontSizeToHeightRatio(fontSize: CGFloat) -> CGFloat {
    16*sqrt(fontSize + 10) - 60
}

struct SignInButton: View {
    let fontSize: CGFloat
    let quantity: Int
    
    var body: some View {
        ZStack {
            // Text
            FloatingFireflies(quantity: quantity)
                .mask(
                    PrettyText(text:     "Sign in",
                               fontName: "ArsenalSC-Regular",
                               color:    Colors.boneColor,
                               fontSize: fontSize)
                )
                .frame(width:  fontSizeToWidthRatio(fontSize:  fontSize),
                       height: fontSizeToHeightRatio(fontSize: fontSize))
                .contentShape(Rectangle())
                .padding(10)
                .shadow(color: Colors.blackish, radius: 10)
                
        }
    }
}

#Preview {
    SignInButton(fontSize: 56, quantity: 150)
        .onTapGesture {

            // debug message
            print("Sign in button tapped!")
        }
}
