////
////  RestrictedArea.swift
////  VisageVerify
////
////  Created by Nikita Ochkin on 11.08.2024.
////
//
//import SwiftUI
//
//// Define the different eye states
//enum EyeState {
//    case state1
//    case state2
//    case state2p2
//    case state3
//    case state3p2
//    case state4
//    case state4p2
//    case state5
//    case state5p2
//    case state6
//    case state6p2
//    case state7
//}
//
//// Main view with blinking animation
//struct BlinkingEyeView: View {
//    @State private var eyeState: EyeState = .state1
//    @State private var timer: Timer?
//    
//    var body: some View {
//        Group {
//            switch eyeState {
//            case .state1:
//                OpenEye(mainEyeColor: .black,
//                        sectorColor:  .white,
//                        pupilColor:   .black)
//            case .state2:
//                BlinkingEyeAnimationState2(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state2p2:
//                BlinkingEyeAnimationState2(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state3:
//                BlinkingEyeAnimationState3(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state3p2:
//                BlinkingEyeAnimationState3(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state4:
//                BlinkingEyeAnimationState4(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state4p2:
//                BlinkingEyeAnimationState4(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state5:
//                BlinkingEyeAnimationState5(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state5p2:
//                BlinkingEyeAnimationState5(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state6:
//                BlinkingEyeAnimationState6(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state6p2:
//                BlinkingEyeAnimationState6(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            case .state7:
//                ClosedEye(mainEyeColor: .black)
//            }
//        }
//        .onAppear() {
//            scheduleNextBlink()
//        }
//        .onDisappear() {
//            stopBlinkingAnimation()
//        }
//    }
//    
//    func startBlinkingAnimation() {
//        let blinkingSequence: [EyeState] = [
//            .state2,   .state3,   .state4,   .state5,   .state6,   .state7,
//            .state6p2, .state5p2, .state4p2, .state3p2, .state2p2, .state1
//        ]
//        var delay = 0.0
//        for state in blinkingSequence {
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                eyeState = state
//            }
//            delay += 0.025
//        }
//        scheduleNextBlink()
//    }
//    
//    func scheduleNextBlink() {
//        let randomInterval = CGFloat.random(in: 3...16)
//        timer = Timer.scheduledTimer(withTimeInterval: randomInterval,
//                                     repeats: false) { _ in
//            startBlinkingAnimation()
//        }
//    }
//    
//    func stopBlinkingAnimation() {
//        timer?.invalidate()
//        timer = nil
//    }
//}
//
//struct Eye {
//    var position: CGPoint
//    var height: CGFloat
//   // var color: Color
//}
//
//struct MultipleBlinkingEyes: View {
//    var quantity: Int
//    
//    let screenWidth  = UIScreen.main.bounds.width
//    let screenHeight = UIScreen.main.bounds.height
//    var allCoordinates = [CGPoint]()
//    var generatedEyes  = [Eye]()
//    
//    // preprocess all the eye coordinates
//    init(quantity: Int) {
//        self.quantity = quantity
//        // populate coordinates array with all posible natural coordinates for the screen
//        for w in 0..<Int(screenWidth + 1) {
//
//            for h in 0..<Int(screenHeight + 1) {
//                // let _ = print("(\(w), \(h))")
//                allCoordinates.append(CGPoint(x: w, y: h))
//            }
//        }
//        
//      //  let _ = print("1")
//        
//        for _ in 0..<quantity {
//           // let _ = print("2!")
//            if let randomEyePos = allCoordinates.randomElement() {
//                
//                let randomEyeHeight = CGFloat.random(in: 50...300)
//                
//                // find the edge coordinates for a restricted area
//                let beginSafeEyeXCoord = randomEyePos.x - 26 * 2.2 * randomEyeHeight / 100
//                let beginSafeEyeYCoord = randomEyePos.y - 18 * 2.2 * randomEyeHeight / 100
//                let endSafeEyeXCoord   = randomEyePos.x + 26 * 2.2 * randomEyeHeight / 100
//                let endSafeEyeYCoord   = randomEyePos.y + 18 * 2.2 * randomEyeHeight / 100
//                
//                if !((beginSafeEyeXCoord <= randomEyePos.x && randomEyePos.x <= endSafeEyeXCoord) ||
//                     (beginSafeEyeYCoord <= randomEyePos.y && randomEyePos.y <= endSafeEyeYCoord)) {
//                    let generatedEye = Eye(position: randomEyePos,
//                                           height:   randomEyeHeight)
//                    
//                    generatedEyes.append(generatedEye)
//                } else {
//                    self.quantity += 1
//                }
//                
//                // var coordinatesToRemove  = [CGPoint]()
//                
////                for w in Int(beginSafeEyeXCoord)..<Int(endSafeEyeXCoord + 1) {
////                    for h in Int(beginSafeEyeYCoord)..<Int(endSafeEyeYCoord + 1) {
////                        let coordinateToRemove = CGPoint(x: w, y: h)
////                        // let indToRemove = coordToInd(point: coordinateToRemove)
////                        if let indToRemove = allCoordinates.firstIndex(
////                            of: coordinateToRemove) {
////                                allCoordinates.remove(at: indToRemove)
////                        }
////
//////                        let _ = print("removing element \(allCoordinates[indToRemove]) at index \(indToRemove)")
////
////                        // allCoordinates.remove(at: indToRemove)
////                    }
////                }
//                
//
//            }
//        }
//    }
//    
//    var body: some View {
////        let _ = ("3")
////        ForEach(0..<generatedEyes.count, id: \.self) { eyeInd in
////            ZStack {
////                BlinkingEyeView()
////                    .aspectRatio(0.5, contentMode: .fit)
////                    .frame(height: generatedEyes[eyeInd].height)
////                    .position(generatedEyes[eyeInd].position)
////            }
////        }
//        
//        ZStack {
//            // background color
//            Colors.boneColor
//               // .opacity(backgroundOpacity)
//            
//            // generate fireflies and put them on screen
//            ForEach(0..<generatedEyes.count, id: \.self) { eyeInd in
//                BlinkingEyeView()
//                    .aspectRatio(0.5, contentMode: .fit)
//                    .frame(height: generatedEyes[eyeInd].height)
//                    .position(generatedEyes[eyeInd].position)
//            }
//        }
//        // .drawingGroup()
//        .edgesIgnoringSafeArea(.all)
//    }
//    
//    func coordToInd(point: CGPoint) -> Int {
//        Int(point.x * (UIScreen.main.bounds.height + 1) + point.y)
//    }
//}
//
//#Preview {
//    MultipleBlinkingEyes(quantity: 1)
//}
