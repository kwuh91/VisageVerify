//
//  InitialScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct InitialScreen: View {
    @State private var isTapped:    Bool   = false
    @State private var iconOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            Icon(iconName:  "eye",
                 iconColor: .black)
                .position(x: isTapped ?
                          UIScreen.main.bounds.width / 2  : // x pos after tap
                          UIScreen.main.bounds.width / 2  , // inital x pos
                          y: isTapped ?
                          100                             : // y pos after tap
                          UIScreen.main.bounds.height / 2 ) // initial y pos
                .opacity(iconOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)) {
                        iconOpacity = 1.0
                    }
                }
                .animation(.easeInOut(duration: 1.0), value: isTapped)
        }
        .onTapGesture {
            isTapped.toggle()
//            if !isTapped {
//                isTapped.toggle()
//            }
        }
    }
}

#Preview {
    InitialScreen()
}
