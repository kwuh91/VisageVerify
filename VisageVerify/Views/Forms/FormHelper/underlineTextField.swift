//
//  underlineTextField.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 22.08.2024.
//

import SwiftUI

extension View {
    func underlineTextField(color:         Color,
                            fontSize:      CGFloat,
                            fontName:      String = "ArsenalSC-Regular",
                            bottomPadding: CGFloat = 0) -> some View {
        self
            .padding(.vertical, 10)
            .padding(.bottom, bottomPadding)
            .overlay(Rectangle()
                        .frame(height: 2)
                        .padding(.top, 35))
            .font(.custom(fontName, size: fontSize))
            .multilineTextAlignment(.center)
            .foregroundColor(color)
            .padding(10)
    }
}

struct underlineTextField: View {
    @State var text = ""
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            HStack {
                // Image(systemName: "magnifyingglass")
                TextField("Search", text: $text)
            }.underlineTextField(color: .red, fontSize: 26)
        }
    }
}

#Preview {
    underlineTextField()
}
