//
//  InitialScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct InitialScreen: View {
    @State private var isTapped:        Bool   = false
    @State private var isTappedButtons: Bool   = false
    @State private var iconOpacity:     Double = 0.0 // initial icon opacity
    
    var body: some View {
        NavigationView{
            ZStack {
                // background color
                Colors.boneColor
                    .edgesIgnoringSafeArea(.all)
                
                // temp background layer, which is removed after tap
                let tempFireflies = FloatingFireflies(quantity: 150)
                tempFireflies
                    .opacity(isTapped ? 0.0 : 1.0)
                
                // stack witn AppName[Icon] & slogan
                VStack{
                    // AppName[Icon]
                    HStack {
                        AppName(color: isTapped ?
                                Colors.blackish :
                                Colors.boneColor,
                                fontSize: isTapped ? 46 : 36)
                        
                        Icon(iconName:  "eye.fill",
                             iconColor: isTapped ?
                             Colors.blackish     :
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
                          UIScreen.main.bounds.height / 5 - 50 : // y pos after tap
                          UIScreen.main.bounds.height / 2.5 )    // initial y pos
                .opacity(iconOpacity) // set initial opacity
                .onAppear {
                    // fade in animation
                    withAnimation(.easeIn(duration: 2.0)) {
                        iconOpacity = 1.0
                    }
                }
                // animation to move up after tap
                // remove slogan
                // change AppName[Icon] colors
                .animation(.easeInOut(duration: 1.0), value: isTapped)
                
                // stack with sign in/up buttons
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    // sign in button
                    NavigationLink(destination: {
                        FloatingFireflies(quantity: 5)
                    }, label: {
                        PrettyText(text: "Sign in",
                                   color: Colors.boneColor,
                                   fontSize: 46)
                    })
                    .buttonStyle(FireflyCircleButtonStyle(padding:  150,
                                                          quantity: 150))
                    
                    Spacer()
                    
                    // sign up button
                    NavigationLink(destination: {
                        FloatingFireflies(quantity: 150)
                    }, label: {
                        FloatingFireflies(quantity: 150)
                    })
                    .buttonStyle(FireflyTextMaskButtonStyle(buttonText: "Sign up",
                                                            fontSize:   46,
                                                            padding:    10,
                                                            width:      300,
                                                            height:     100))
                    
                    Spacer()
                    
                }.opacity(isTappedButtons ? 1 : 0)
                
            }
            // whole screen is tappable
            .onTapGesture {
                // remove one bg layer
                withAnimation(
                    Animation.easeOut(
                        duration: 1.0
                    )
                ){
                    isTapped.toggle()
                }
                // fades in buttons
                withAnimation(
                    Animation.easeInOut(
                        duration: 2.0
                    ).delay(0.7)
                ){
                    isTappedButtons.toggle()
                }
                
                //            if !isTapped {
                //                isTapped.toggle()
                //            }
            }
        }
    }
}

#Preview {
    InitialScreen()
}
