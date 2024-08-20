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
            Colors.blackish
                .ignoresSafeArea()

            RegistrationForm(registrationFormModel: .init())
        }
    }
}
    
#Preview {
    RegistrationScreen()
}
