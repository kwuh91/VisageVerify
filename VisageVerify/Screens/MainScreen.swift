//
//  MainScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 18.08.2024.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        MultipleBlinkingEyes(quantity:     70,
                             mainEyeColor: Colors.blackish,
                             sectorColor:  Colors.boneColor,
                             pupilColor:   Colors.blackish,
                             delayBetweenChangingStates: 0.025,
                             intervalForRandomTimeBetweenBlinking: 1...30,
                             intervalForRandomSize: 50...300,
                             intervalForRandomDelayBeforeAppearing: 0...0.25,
                             randomizeAnchor: false,
                             animation: .spring(duration: 0.5, bounce: 0.5))
    }
}

#Preview {
    MainScreen()
}
