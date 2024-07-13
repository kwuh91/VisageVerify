//
//  Icon.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct Icon: View {
    let iconName: String
    let iconColor: Color
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .foregroundStyle(iconColor)
    }
}

#Preview {
    Icon(iconName: "eye",
         iconColor: .black)
}
