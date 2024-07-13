//
//  Fireflies.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

struct Firefly: Identifiable {
    let id = UUID()
    var startPosition: CGPoint
    var endPosition:   CGPoint
    var color:         Color
    var scale:         CGFloat
    var opacity:       Double
    var speed:         Double
}

struct FireflyView: View {
    @State var firefly: Firefly
    @State private var animatePath: Bool   = false
    @State private var glowOpacity: Double = 0.0

    var body: some View {
        Circle()
            .fill(firefly.color)
            .frame(width:  10 * firefly.scale,
                   height: 10 * firefly.scale)
            .position(x: animatePath          ?
                      firefly.endPosition.x   :
                      firefly.startPosition.x ,
                      y: animatePath          ?
                      firefly.endPosition.y   :
                      firefly.startPosition.y )
            .opacity(glowOpacity)
            .onAppear {
                startAnimation()
            }
    }

    private func startAnimation() {
        let glowDuration = Double.random(in: 1...3)

        withAnimation(
            Animation.easeInOut(duration: glowDuration)
                .repeatForever(autoreverses: true)
        ) {
            glowOpacity = 1.0
        }

        withAnimation(
            Animation.linear(duration: firefly.speed)
                .repeatForever(autoreverses: true)
        ) {
            animatePath.toggle()
        }
    }
}

struct BackgroundView: View {
    let quantity: Int
    
    @State private var fireflies: [Firefly] = []

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            ForEach(fireflies) { firefly in
                FireflyView(firefly: firefly)
            }
        }
        .onAppear {
            generateFireflies()
        }
    }

    private func generateFireflies() {
        for _ in 0..<quantity {
            
            let startPosition = CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
            )
            
            let endPosition = CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
            )
            
            let firefly = Firefly(
                startPosition: startPosition,
                endPosition:   endPosition,
                color: Color(hue: Double.random(in: 0...1),
                             saturation: 0.8,
                             brightness: 0.9),
                scale:   CGFloat.random(in: 0.5...1.5),
                opacity: Double.random(in: 0.5...1.0),
                speed:   Double.random(in: 5...10)
            )
            
            fireflies.append(firefly)
        }
    }
}

#Preview {
    BackgroundView(quantity: 50)
}
