//
//  Firefly.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

struct Firefly: Identifiable {
    let id = UUID()
    var startPosition: CGPoint
    var endPosition: CGPoint
    var control1: CGPoint
    var control2: CGPoint
    var color: Color
    var scale: CGFloat
    var opacity: Double
    var speed: Double
}

struct FireflyView: View {
    @State var firefly: Firefly
    @State private var animatePath = false
    @State private var glowOpacity: Double = 0.0
    
    var body: some View {
        Circle()
            .fill(firefly.color)
            .frame(width: 10 * firefly.scale, height: 10 * firefly.scale)
            .position(x: animatePath ? firefly.endPosition.x : firefly.startPosition.x,
                      y: animatePath ? firefly.endPosition.y : firefly.startPosition.y)
            .opacity(glowOpacity)
            .onAppear {
                startAnimation()
            }
    }
    
    private func startAnimation() {
        let glowDuration = Double.random(in: 1...3)
        
        withAnimation(Animation.easeInOut(duration: glowDuration).repeatForever(autoreverses: true)) {
            glowOpacity = 1.0
        }
        
        withAnimation(Animation.linear(duration: firefly.speed).repeatForever(autoreverses: true)) {
            animatePath.toggle()
        }
    }
}
