//
//  ButtonTestViewStyle.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 03.08.2024.
//

import SwiftUI

//struct ButtonTestViewStyle: View {
//    var body: some View {
//        Text("Hello, World!")
//    }
//}

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
