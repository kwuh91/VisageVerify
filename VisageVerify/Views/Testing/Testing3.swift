//
//  Testing3.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 28.08.2024.
//

import SwiftUI

struct Testing3: View {
    let image = UIImage(named: "ben")!
    
    var body: some View {
        ZStack {
            Colors.blackish
                .ignoresSafeArea()
            
            Image("ben")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350,
                       height: 350)
                .clipShape(Circle())
                .shadow(color: .black, radius: 15)
        }
    }
}

#Preview {
    Testing3()
}
