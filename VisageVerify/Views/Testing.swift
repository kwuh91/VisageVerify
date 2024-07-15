//
//  Testing.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 15.07.2024.
//

import SwiftUI

struct Testing: View {
    var body: some View {
        
        Button {
            print("hey")
        } label: {
            ButtonShell(buttonText: "Sample")
        }
        
    }
}

#Preview {
    Testing()
}
