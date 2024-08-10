////
////  TestingBlinking2.swift
////  VisageVerify
////
////  Created by Nikita Ochkin on 09.08.2024.
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
//    @State private var isBlinking: Bool = false
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
//                BlinkingEyeAnimationState7(mainEyeColor: .black,
//                                           sectorColor:  .white,
//                                           pupilColor:   .black)
//            }
//        }
//        .onTapGesture {
//            if !isBlinking {
//                startBlinkingAnimation()
//            }
//        }
//    }
//    
//    func startBlinkingAnimation() {
//        isBlinking = true
//        let blinkingSequence: [EyeState] = [
//            .state2,   .state3,   .state4,   .state5,   .state6,   .state7,
//            .state6p2, .state5p2, .state4p2, .state3p2, .state2p2, .state1
//        ]
//        var delay = 0.0
//        for state in blinkingSequence {
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                eyeState = state
//                if state == .state1 {
//                    isBlinking = false
//                }
//            }
//            delay += 0.025
//        }
//    }
//}
//
//#Preview {
//    BlinkingEyeView()
//        .aspectRatio(0.5, contentMode: .fit)
//        .frame(height: 500)
//}
