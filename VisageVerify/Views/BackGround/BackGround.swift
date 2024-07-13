//
//  Background.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 13.07.2024.
//

struct BackgroundView: View {
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
        for _ in 0..<50 {
            let startPosition = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            let endPosition = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                      y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            let control1 = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                   y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            let control2 = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                   y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            let firefly = Firefly(
                startPosition: startPosition,
                endPosition: endPosition,
                control1: control1,
                control2: control2,
                color: Color(hue: Double.random(in: 0...1),
                             saturation: 0.8,
                             brightness: 0.9),
                scale: CGFloat.random(in: 0.5...1.5),
                opacity: Double.random(in: 0.5...1.0),
                speed: Double.random(in: 5...10)
            )
            fireflies.append(firefly)
        }
    }
}

#Preview {
    BackgroundView()
}
