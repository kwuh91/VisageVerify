//
//  Slogan.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct Slogan: View {
    let color:    Color
    let fontSize: CGFloat
    
    var body: some View {
        PrettyText(text: "je sais tout, mais je ne sais",
                   //fontName: "ArsenalSC-Regular",
                   fontName: "BonaNovaSC-Regular",
                   color:    color,
                   fontSize: fontSize)
        
        PrettyText(text: "rien de bon",
                   //fontName: "ArsenalSC-Regular",
                   fontName: "BonaNovaSC-Regular",
                   color:    color,
                   fontSize: fontSize)
    }
}

#Preview {
    Slogan(color:    .black,
           fontSize: 30)
}
