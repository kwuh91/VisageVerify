//
//  Fireflies.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

import SwiftUI

// a model for a firefly
struct Firefly: Identifiable {
    let id = UUID()
    
    //TODO: change to let?
    let color: Color
    let rotationStart: Double
    let duration: Double
    let initialPosition: CGPoint // CGPoint(x: 10.0, y: 10.0)
    
    // var endPosition:   CGPoint
    // var color:         Color
    // var scale:         CGFloat
    // var opacity:       Double
    // var speed:         Double
}

// a view for a firefly model
struct FireflyView: View {
    // sets random offset and height ratio
    @StateObject var provider = FireflyProvider()
    
    @State var firefly: Firefly
    @State var move = false
    
    var body: some View {
        Circle()
            // apply a color
            .fill(firefly.color)
        
            // set the size
            .frame(height:
                    UIScreen.main.bounds.height / provider.frameHeightRatio)
            
            // set the offset
            .offset(provider.offset)
        
            // set the rotation
            .rotationEffect(.init(degrees: move ? firefly.rotationStart : firefly.rotationStart + 360))
        
            // set the limits
            .frame(maxWidth:  .infinity,
                   maxHeight: .infinity)
            
            // set the position
            .position(firefly.initialPosition)
        
            // opacity ?
            //.opacity(0.8)
        
            // update move variable
            .onAppear {
                // set the animation
                withAnimation(
                    Animation.easeInOut(
                        duration: firefly.duration
                    ).repeatForever(autoreverses: true)
                ){
                    move.toggle()
                }
                
            }
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
        // TODO: change later?
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
                rotationStart: Double.random(in: 0...300),
                duration: Double.random(in: 10...50),
                initialPosition: initialPosition
            )

            fireflies.append(firefly)
        }
    }
}

#Preview {
    // Dot(initialPosition: CGPoint(x: 100, y: 100))
    FloatingFireflies(quantity: 70)
}
