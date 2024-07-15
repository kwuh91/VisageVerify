//
//  ButtonShell.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 15.07.2024.
//

import SwiftUI

struct ButtonShell: View {
    let buttonText: String
    
    var body: some View {
        ZStack {
            // button design
            FloatingFireflies(quantity: 70)
            // Colors.boneColor
                .mask(
                    ButtonShape()
                )
                .shadow(color: Colors.blackish, radius: 10)
                .padding()
            
            PrettyText(text:     buttonText,
                       fontName: "ArsenalSC-Regular",
                       color:    Colors.boneColor,
                       fontSize: 56)
                .shadow(color: Colors.blackish, radius: 5)
        }
    }
}

#Preview {
    VStack {
        ButtonShell(buttonText: "Sample1")
        ButtonShell(buttonText: "Sample2")
    }
}
