//
//  Gradient.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

// a model for a firefly
struct Firefly: Identifiable {
    let id = UUID()
    var initialPosition: CGPoint // CGPoint(x: 10.0, y: 10.0)
    // var endPosition:   CGPoint
    // var color:         Color
    // var scale:         CGFloat
    // var opacity:       Double
    // var speed:         Double
}

// define a firefly
struct FireflyView: View {
    @State var firefly: Firefly
    
    var body: some View {
        Circle()
            .frame(width:  50,
                   height: 50)
            .frame(maxWidth:  .infinity,
                   maxHeight: .infinity)
            .position(firefly.initialPosition)
    }
}

// create a bunch of fireflies
struct FloatingFireflies: View {
    let quantity: Int
    
    @State private var fireflies: [Firefly] = []
    
    var body: some View {
        ZStack {
            // background color
            Color.white
            
            // put fireflies on screen
            ForEach(fireflies) { firefly in
                FireflyView(firefly: firefly)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            generateFireflies()
        }
    }
    
    // function to generate fireflies
    private func generateFireflies() {
        // generate fireflies in a loop
        for _ in 0..<quantity {
            
            let initialPosition = CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
            )
            
            let firefly = Firefly(
                initialPosition: initialPosition
            )
            
            fireflies.append(firefly)
        }
    }
}

#Preview {
    // Dot(initialPosition: CGPoint(x: 100, y: 100))
    FloatingFireflies(quantity: 100)
}
