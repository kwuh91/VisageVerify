//
//  PrettyText.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct PrettyText: View {
    let text:      String
    var fontName:  String = "ArsenalSC-Regular"
    let color:     Color
    let fontSize:  CGFloat
    
    var body: some View {
        Text(text)
            .font(.custom(fontName, size: fontSize))
            .foregroundStyle(color)
    }
}

#Preview {
    PrettyText(text: "VisageVerify",
               fontName: "ArsenalSC-Regular",
               //fontName: "BonaNovaSC-Regular",
               color: .black,
               fontSize: 46)
}
