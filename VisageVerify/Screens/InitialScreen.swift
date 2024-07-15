//
//  InitialScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct InitialScreen: View {
    @State private var isTapped:    Bool   = false
    @State private var iconOpacity: Double = 0.0 // initial icon opacity
    
    var body: some View {
        ZStack {
            // background color
            Colors.boneColor
                .edgesIgnoringSafeArea(.all)
            
            // temp background layer, which is removed after tap
            let tempFireflies = FloatingFireflies(quantity: 100)
            tempFireflies
                .opacity(isTapped ? 0.0 : 1.0)
            
            VStack{
                // AppName[Icon]
                HStack {
                    AppName(color: isTapped     ?
                                Colors.blackish :
                                Colors.boneColor,
                            fontSize: 36)
                    
                    Icon(iconName:  "eye.fill",
                         iconColor: isTapped ?
                            Colors.blackish  :
                            Colors.boneColor,
                         iconSize: 30,
                         fontWeight: .thin)
                }
                Slogan(color: Colors.boneColor, fontSize: 30)
                    .opacity(isTapped ? 0.0 : 1.0)
            }
            .position(x: isTapped ?
                      UIScreen.main.bounds.width / 2  : // x pos after tap
                      UIScreen.main.bounds.width / 2  , // inital x pos
                      y: isTapped ?
                      UIScreen.main.bounds.height / 5 :   // y pos after tap
                      UIScreen.main.bounds.height / 2.5 ) // initial y pos
            .opacity(iconOpacity) // set initial opacity
            .onAppear {
                // fade in animation
                withAnimation(.easeIn(duration: 2.0)) {
                    iconOpacity = 1.0
                }
            }
            // animation to move up after tap
            .animation(.easeInOut(duration: 1.0), value: isTapped)
        }
        // whole screen is tappable
        .onTapGesture {
            // move the AppName[Icon] up
            // remove one bg layer
            // change icon & AppName[Icon] colors
            // remove slogan
            withAnimation(
                Animation.easeOut(
                    duration: 1.0
                )
            ){
                isTapped.toggle()
            }
//            if !isTapped {
//                isTapped.toggle()
//            }
        }
    }
}

#Preview {
    InitialScreen()
}
