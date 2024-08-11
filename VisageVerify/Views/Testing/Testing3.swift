//
//  Testing3.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 10.08.2024.
//

import SwiftUI

// Define the different eye states
enum EyeState {
    case state1
    case state2
    case state2p2
    case state3
    case state3p2
    case state4
    case state4p2
    case state5
    case state5p2
    case state6
    case state6p2
    case state7
}

// Main view with blinking animation
struct BlinkingEyeView: View {
    @State private var eyeState: EyeState = .state1
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            switch eyeState {
            case .state1:
                OpenEye(mainEyeColor: .black,
                        sectorColor:  .white,
                        pupilColor:   .black)
            case .state2:
                BlinkingEyeAnimationState2(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state2p2:
                BlinkingEyeAnimationState2(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state3:
                BlinkingEyeAnimationState3(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state3p2:
                BlinkingEyeAnimationState3(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state4:
                BlinkingEyeAnimationState4(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state4p2:
                BlinkingEyeAnimationState4(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state5:
                BlinkingEyeAnimationState5(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state5p2:
                BlinkingEyeAnimationState5(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state6:
                BlinkingEyeAnimationState6(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state6p2:
                BlinkingEyeAnimationState6(mainEyeColor: .black,
                                           sectorColor:  .white,
                                           pupilColor:   .black)
            case .state7:
                ClosedEye(mainEyeColor: .black)
            }
        }
        .onAppear() {
            scheduleNextBlink()
        }
        .onDisappear() {
            stopBlinkingAnimation()
        }
    }
    
    func startBlinkingAnimation() {
        let blinkingSequence: [EyeState] = [
            .state2,   .state3,   .state4,   .state5,   .state6,   .state7,
            .state6p2, .state5p2, .state4p2, .state3p2, .state2p2, .state1
        ]
        var delay = 0.0
        for state in blinkingSequence {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                eyeState = state
            }
            delay += 0.025
        }
        scheduleNextBlink()
    }
    
    func scheduleNextBlink() {
        let randomInterval = CGFloat.random(in: 3...16)
        timer = Timer.scheduledTimer(withTimeInterval: randomInterval,
                                     repeats: false) { _ in
            startBlinkingAnimation()
        }
    }
    
    func stopBlinkingAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

struct MultipleBlinkingEyes: View {
    let eyeCount = 15
    
    let screenWidth  = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var coordinates  = [CGPoint]()
    
    // populate coordinates array with all posible natural coordinates for the screen
    init() {
        for w in 0..<Int(screenWidth + 1) {
            //
            for h in 0..<Int(screenHeight + 1) {
                // let _ = print("(\(w), \(h))")
                coordinates.append(CGPoint(x: w, y: h))
            }
        }
        
        let ind = 933
        let point = coordinates[Int(ind)]
        let foundInd = coordsToInd(point: point)
        let foundPoint = coordinates[foundInd]
        
        let _ = print("ind: \(ind), point: \(point)")
        let _ = print("found ind: \(foundInd), found point: \(foundPoint)")
    }
    
    var body: some View {
        let eyeCount = 1
        
            ForEach(0..<eyeCount, id: \.self) { _ in
                if let randomEyePos = coordinates.randomElement() {
                    let randomEyeHeight = CGFloat.random(in: 50...300)
                    
//                    let _ = print("eye position = (\(randomEyePos.x), \(randomEyePos.y))")
//                    
//                    let _ = print("eye height = \(randomEyeHeight)")
//                    
//                    let pointArrayInd = coordsToInd(point: randomEyePos)
//                    
//                    let _ = print("func res: \(pointArrayInd)")
//                    
//                    let foundPoint = coordinates[pointArrayInd]
//                    
//                    let _  = print("found point in array: (\(foundPoint.x), \(foundPoint.y))")
                    
                    BlinkingEyeView()
                        .aspectRatio(0.5, contentMode: .fit)
                        .frame(height: randomEyeHeight)
                        .position(randomEyePos)
                }
            
        }
//        let eyePosition = CGPoint(
//            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
//            y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
//        )
        
        // Text("123")
    }
    
    func coordsToInd(point: CGPoint) -> Int {
        return Int(point.x * (UIScreen.main.bounds.height + 1) + point.y)
    }
}
    
#Preview {
    MultipleBlinkingEyes()
}
