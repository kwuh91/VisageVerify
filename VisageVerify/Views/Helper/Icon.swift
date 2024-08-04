//
//  Icon.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct Icon: View {
    let iconName:   String
    let iconColor:  Color
    let iconSize:   CGFloat
    let fontWeight: Font.Weight
    
    var body: some View {
        Image(systemName: iconName)
            // .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: iconSize)
            .font(Font.title.weight(fontWeight))
            .foregroundStyle(iconColor)
    }
}

#Preview {
//    Icon(iconName: "eye",
//         iconColor: .black,
//         iconSize: 100,
//         fontWeight: .thin)
    
    Icon(iconName:   "eye.fill",
         iconColor:  Colors.blackish,
         iconSize:   70,
         fontWeight: .thin)
}
