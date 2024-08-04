//
//  InitialScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct InitialScreen: View {
    @State private var isTapped:               Bool   = false
    @State private var isTappedButtons:        Bool   = false
    @State private var iconOpacity:            Double = 0.0 // initial icon opacity
    @State private var scale:                  Bool   = false
    @State private var hideSignUpButton:       Bool   = false
    @State private var hideInitialScreen:      Bool   = false
    @State private var hideRegistrationScreen: Bool   = false
    
    var body: some View {
        ZStack {
            // background color
            Colors.boneColor
                .edgesIgnoringSafeArea(.all)
            
            // temp background layer, which is removed after tap
            FloatingFireflies(quantity: 150)
                .opacity(isTapped ? 0.0 : 1.0)
                // remove it on tap
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
                .opacity(hideInitialScreen ? 0 : 1)
                
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
            //.animation(.easeInOut(duration: 1.0), value: isTapped)
            .animation(.spring(duration: 1, bounce: 0.3), value: isTapped)
            
            // stack with sign in/up buttons
            VStack {
                // sign up button
                SignUpButton(padding:  40,
                             fontSize: 46,
                             quantity: 150)
                // needed to fix a bug with scaling
                .rotationEffect(
                    scale ? Angle(degrees: 0.0001) : Angle(degrees: 0)
                )
                .scaleEffect(scale ? 4 : 1, anchor: .center) // increase the button
                .opacity(hideSignUpButton ? 0 : 1)           // fade it out
                .onTapGesture {
                    // sign up button scale animation
                    withAnimation(
                        Animation.easeInOut(
                            duration: 2.2
                        )
                    ){
                        scale.toggle()
                    }
                    
                    // initial screen fade out animation (AppName[Icon] & Sign in button)
                    withAnimation(
                        Animation.easeInOut(
                            duration: 1.5
                        )
                    ){
                        hideInitialScreen.toggle()
                    }
                    
                    // registration screen fade in animation
                    withAnimation(
                        Animation.easeInOut(
                            duration: 1.5
                        ).delay(1.5)
                    ){
                        hideRegistrationScreen.toggle()
                    }
                    
                    // sign up button fade out animation
                    withAnimation(
                        Animation.easeInOut(
                            duration: 2.0
                        ).delay(0.2)
                    ){
                        hideSignUpButton.toggle()
                    }
                    
                    // debug message
                    print("Sign up button tapped!")
                }
                
                // sign in button
                SignInButton(fontSize: 56, quantity: 150)
                .opacity(hideInitialScreen ? 0 : 1)
                .offset(y: -100)
                .onTapGesture {

                    // debug message
                    print("Sign in button tapped!")
                }
                
                // Spacer()
                
            }.opacity(isTappedButtons ? 1 : 0)
            
            RegistrationScreen()
                .opacity(hideRegistrationScreen ? 1 : 0)
        }
    }
}

#Preview {
    InitialScreen()
    // Testing()
}
