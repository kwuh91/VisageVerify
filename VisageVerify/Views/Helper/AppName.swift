//
//  AppName.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct AppName: View {
    let color:    Color
    let fontSize: CGFloat
    
    var body: some View {
        PrettyText(text: "VisageVerify",
                   fontName: "ArsenalSC-Regular",
                   //fontName: "BonaNovaSC-Regular",
                   color:    color,
                   fontSize: fontSize)
    }
}

#Preview {
    AppName(color:    .black,
            fontSize: 46)
}
