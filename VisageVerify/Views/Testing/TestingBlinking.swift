////
////  Testing3.swift
////  VisageVerify
////
////  Created by Nikita Ochkin on 06.08.2024.
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
//        .onAppear {
//            startBlinkingAnimation()
//        }
//        .onDisappear {
//            stopBlinkingAnimation()
//        }
//        
//    }
//    
//    func startBlinkingAnimation() {
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//            switch eyeState {
//            // closing sequence
//            case .state1:
//                eyeState = .state2
//            case .state2:
//                eyeState = .state3
//            case .state3:
//                eyeState = .state4
//            case .state4:
//                eyeState = .state5
//            case .state5:
//                eyeState = .state6
//            case .state6:
//                eyeState = .state7
//            
//            // opening sequence
//            case .state7:
//                eyeState = .state6p2
//            case .state6p2:
//                eyeState = .state5p2
//            case .state5p2:
//                eyeState = .state4p2
//            case .state4p2:
//                eyeState = .state3p2
//            case .state3p2:
//                eyeState = .state2p2
//            case .state2p2:
//                eyeState = .state1
//            }
//        }
//    }
//    
//    func stopBlinkingAnimation() {
//        timer?.invalidate()
//        timer = nil
//    }
//}
//
//struct TestingBlinking: View {
//    var body: some View {
//        Text("Hello, World!")
//    }
//}
//
//#Preview {
//    BlinkingEyeView()
//        .aspectRatio(0.5, contentMode: .fit)
//        .frame(height: 500)
//}
