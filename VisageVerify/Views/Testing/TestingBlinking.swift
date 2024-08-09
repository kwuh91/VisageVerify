//
//  Testing3.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 06.08.2024.
//

import SwiftUI

// Define the different eye states
enum EyeState {
    case open1
    case halfClosed1
    case halfClosed2
    case closed
}

// Main view with blinking animation
struct BlinkingEyeView: View {
    @State private var eyeState: EyeState = .open1
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            switch eyeState {
            case .open1:
                OpenEye(mainEyeColor: .black,
                        sectorColor:  .white,
                        pupilColor:   .black)
            case .halfClosed1:
                HalfEye(mainEyeColor: .black,
                        sectorColor:  .white,
                        pupilColor:   .black)
            case .halfClosed2:
                HalfEye(mainEyeColor: .black,
                        sectorColor:  .white,
                        pupilColor:   .black)
            case .closed:
                ClosedEye(mainEyeColor: .black)
            }
        }
        .onAppear {
            startBlinkingAnimation()
        }
        .onDisappear {
            stopBlinkingAnimation()
        }
    }
    
    func startBlinkingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
//            withAnimation (
//                Animation.linear(
//                    duration: 0.1
//                )
//            )
            switch eyeState {
            case .open1:
                eyeState = .halfClosed1
            case .halfClosed1:
                eyeState = .closed
            case .closed:
                eyeState = .halfClosed2
            case .halfClosed2:
                eyeState = .open1
            }
        }
    }
    
    func stopBlinkingAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

struct TestingBlinking: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    BlinkingEyeView()
        .aspectRatio(0.5, contentMode: .fit)
        .frame(height: 500)
}
