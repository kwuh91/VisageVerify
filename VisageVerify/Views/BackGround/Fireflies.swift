//
//  Fireflies.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

// view for a firefly
struct FireflyView: View {
    // sets random offset and height ratio
    @StateObject var provider = FireflyProvider()
    
    @State var move:        Bool   = false
    @State var glowOpacity: CGFloat = 1.0 // initial opacity
    @State var scale:       CGFloat = 2.0 // initial scale multiplier
    
    var body: some View {
        Circle()
            // apply a color
            .fill(provider.color)
        
            // set the size
            .frame(height:
                    UIScreen.main.bounds.height / provider.frameHeightRatio * scale)
            
            // set the offset
            .offset(provider.offset)
        
            // set the rotation
            .rotationEffect(
                .init(
                    degrees: move ?
                    provider.rotationStart :
                        provider.rotationStart + 360
                )
            )
        
            // set the limits
            .frame(maxWidth:  .infinity,
                   maxHeight: .infinity)
            
            // set the initial position
            .position(provider.initialPosition)
        
            // set the initial opacity
            .opacity(glowOpacity)
        
            .shadow(color: provider.shadowColor, radius: 10)
        
            // start all the animations
            .onAppear {
                DispatchQueue.main.async {
                    startAnimation()
                }
            }
    }
    
    private func startAnimation() {
        // set the rotation animation
        withAnimation(
            Animation.easeOut(
                duration: provider.rotationDuration
            ).repeatForever(autoreverses: true)
        ){
            move.toggle()
        }
        
        // set the glowing animation
        withAnimation(
            Animation.easeOut(
                duration: provider.glowDuration
            ).repeatForever(autoreverses: true)
        ){
            glowOpacity = provider.glow
        }
        
        // set the scaling animation
        withAnimation(
            Animation.easeInOut(
                duration: provider.scaleDuration
            ).repeatForever(autoreverses: true)
        ){
            scale = provider.scale
        }
    }
}

// class for randomizing
class FireflyProvider: ObservableObject {
    let offset:           CGSize
    let frameHeightRatio: CGFloat
    let color:            Color
    let shadowColor:      Color
    let rotationStart:    CGFloat
    let rotationDuration: CGFloat
    let scale:            CGFloat
    let scaleDuration:    CGFloat
    let glow:             CGFloat
    let glowDuration:     CGFloat
    let initialPosition:  CGPoint // CGPoint(x: 10.0, y: 10.0)
    
    init() {
        // take a random number for a screen height divider
        frameHeightRatio = CGFloat.random(in: 10..<30)
        
        // find a random offset
        offset = CGSize(
            width: CGFloat.random(
                in: -UIScreen.main.bounds.width/5..<UIScreen.main.bounds.width/5
            ),
            height: CGFloat.random(
                in: -UIScreen.main.bounds.height/5..<UIScreen.main.bounds.height/5
            )
        )
        
        initialPosition = CGPoint(
            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
            y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
        )
        
        color            = StaticTheme.fireflyTheme
        shadowColor      = StaticTheme.shadowTheme
        rotationStart    = CGFloat.random(in: 0...300)
        rotationDuration = CGFloat.random(in: 10...50)
        scale            = CGFloat.random(in: 1...3)
        scaleDuration    = CGFloat.random(in: 10...50)
        glow             = CGFloat.random(in: 0...1)
        glowDuration     = CGFloat.random(in: 5...20)
        
    }
}

// create a bunch of fireflies
struct FloatingFireflies: View {
    
    let quantity:          Int
    var backgroundOpacity: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // background color
            StaticTheme.generalBackground
                .opacity(backgroundOpacity)
            
            // generate fireflies and put them on screen
            ForEach(0..<quantity, id: \.self) { _ in
                FireflyView()
            }
        }
        .drawingGroup()
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    FloatingFireflies(quantity: 50)
}
