//
//  Fireflies.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

// a model for a firefly
struct Firefly: Identifiable {
    // sets random offset and height ratio
    @StateObject var provider = FireflyProvider()
    
    let id = UUID()
    
    //TODO: change to let?
    var color: Color
    var initialPosition: CGPoint // CGPoint(x: 10.0, y: 10.0)
    
    // var endPosition:   CGPoint
    // var color:         Color
    // var scale:         CGFloat
    // var opacity:       Double
    // var speed:         Double
}

// a view for a firefly model
struct FireflyView: View {
    @State var firefly: Firefly
    
    var body: some View {
        Circle()
            // apply a color
            .fill(firefly.color)
        
            // set the size
            .frame(height:
                    UIScreen.main.bounds.height / firefly.provider.frameHeightRatio)
            
            // set the offset
            .offset(firefly.provider.offset)
        
            // set the limits
            .frame(maxWidth:  .infinity,
                   maxHeight: .infinity)
            
            // set the position
            .position(firefly.initialPosition)
    }
}

// class for randomizing position
class FireflyProvider: ObservableObject {
    let offset: CGSize
    let frameHeightRatio: CGFloat
    
    init() {
        // take a random number for a screen height divider
        frameHeightRatio = CGFloat.random(in: 10..<30)
        
        // find a random offset
        // change later
        offset = CGSize(
            width: CGFloat.random(
                in: -UIScreen.main.bounds.width/5..<UIScreen.main.bounds.width/5
            ),
            height: CGFloat.random(
                in: -UIScreen.main.bounds.height/5..<UIScreen.main.bounds.height/5
            )
        )
    }
}

// create a bunch of fireflies
struct FloatingFireflies: View {
    
    @Environment(\.colorScheme) var scheme
    @State private var fireflies: [Firefly] = []
                  
    let quantity: Int
    
    var body: some View {
        ZStack {
            // background color
            // Color.white
            Theme.generalBackground(forScheme: scheme)
            
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
//        if scheme == .dark {
//            let _ = print("applied dark")
//        } else {
//            let _ = print("applied light")
//        }
        
        // generate fireflies in a loop
        for _ in 0..<quantity {
            
            let initialPosition = CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
            )
            
            let firefly = Firefly(
                color: Theme.FireflyTheme(forScheme: scheme),
                initialPosition: initialPosition
            )

            fireflies.append(firefly)
        }
    }
}

#Preview {
    // Dot(initialPosition: CGPoint(x: 100, y: 100))
    FloatingFireflies(quantity: 50)
}
