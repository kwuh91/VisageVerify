//
//  ButtonShape.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 15.07.2024.
//

import SwiftUI

struct ButtonShape: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 65.0)
            .frame(height: UIScreen.main.bounds.height / 10)
            // .padding()
    }
}

#Preview {
    ButtonShape()
}
