//
//  InitialScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct InitialScreen: View {
    @State private var isTapped:          Bool   = false
    @State private var iconOpacity:       Double = 0.0
    @State private var hideTempFireflies: Bool   = false
    // var tempFireflies: FloatingFireflies
    
    var body: some View {
        ZStack {
            // background color
            FloatingFireflies(quantity:          50,
                              backgroundOpacity: 1.0)
            
            // temp background layer, which is removed after tap
            let tempFireflies = FloatingFireflies(quantity:          100,
                                                  backgroundOpacity: 0.0)
            tempFireflies
                .opacity(hideTempFireflies ? 0.0 : 1.0)
            
            VStack{
                // AppName[Icon]
                HStack {
                    AppName(color: Colors.boneColor, fontSize: 36)
                    
                    Icon(iconName:  "eye.fill",
                         iconColor: Colors.boneColor,
                         iconSize: 30,
                         fontWeight: .thin)
                }
                Slogan(color: Colors.boneColor, fontSize: 30)
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
            isTapped.toggle()
            
            // remove one bg layer
            withAnimation(
                Animation.easeOut(
                    duration: 1.0
                )
            ){
                hideTempFireflies.toggle()
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
