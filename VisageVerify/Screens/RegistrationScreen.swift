//
//  RegistrationScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 03.08.2024.
//

import SwiftUI

struct RegistrationScreen: View {
    var body: some View {
        ZStack {
            // background color
            Colors.boneColor
                .edgesIgnoringSafeArea(.all)
            
            // image
            Image("swiftCat")
                .resizable()
                .frame(height: 644)
                .padding(20)
        }
    }
}

#Preview {
    RegistrationScreen()
}
